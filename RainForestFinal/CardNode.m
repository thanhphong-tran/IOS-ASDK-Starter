
#import "CardNode.h"
#import "Factories.h"
#import "RainforestCardInfo.h"
#import "GradientNode.h"

#import "UIImage+ImageEffects.h"

@interface CardNode ()<ASNetworkImageNodeDelegate>

@property (strong, nonatomic) ASImageNode *backgroundImageNode;
@property (strong, nonatomic) ASNetworkImageNode *animalImageNode;
@property (strong, nonatomic) ASTextNode *animalNameTextNode;

@property (strong, nonatomic) ASTextNode *animalDescriptionTextNode;

@property (strong, nonatomic) GradientNode *gradientNode;

@end

@implementation CardNode

- (instancetype)initWithAnimal:(RainforestCardInfo *)animalInfo;
{
    if (!(self = [super init])) { return nil; }
    
    self.animalInfo = animalInfo;
    
    self.backgroundColor = [UIColor lightGrayColor];
    self.clipsToBounds = YES;
    
    self.backgroundImageNode       = [[ASImageNode alloc] init];
    self.animalImageNode           = [[ASNetworkImageNode alloc] init];
    self.animalNameTextNode        = [[ASTextNode alloc] init];
    self.animalDescriptionTextNode = [[ASTextNode alloc] init];
    self.gradientNode              = [[GradientNode alloc] init];

    //Animal Image
    self.animalImageNode.URL = self.animalInfo.imageURL;
    self.animalImageNode.clipsToBounds = YES;
    self.animalImageNode.delegate = self;
    self.animalImageNode.placeholderFadeDuration = 0.15;
    self.animalImageNode.contentMode = UIViewContentModeScaleAspectFill;

    //Animal Name
    self.animalNameTextNode.attributedString = [NSAttributedString attributedStringForTitleText:self.animalInfo.name];
    
    //Animal Description
    self.animalDescriptionTextNode.attributedString = [NSAttributedString attributedStringForDescription:self.animalInfo.animalDescription];
    self.animalDescriptionTextNode.truncationAttributedString = [NSAttributedString attributedStringForDescription:@"…"];
    self.animalDescriptionTextNode.backgroundColor = [UIColor clearColor];

    //Background Image
    self.backgroundImageNode.placeholderFadeDuration = 0.15;
    self.backgroundImageNode.imageModificationBlock = ^(UIImage *image) {
        UIImage *newImage = [image applyBlurWithRadius:30 tintColor:[UIColor colorWithWhite:0.5 alpha:0.3] saturationDeltaFactor:1.8 maskImage:nil];
        return newImage ? newImage : image;
    };
    
    //Gradient Node
    self.gradientNode.layerBacked = YES;
    self.gradientNode.opaque = NO;
    
    [self addSubnode:self.backgroundImageNode];
    [self addSubnode:self.animalImageNode];
    [self addSubnode:self.gradientNode];

    [self addSubnode:self.animalNameTextNode];
    [self addSubnode:self.animalDescriptionTextNode];
    
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    CGFloat ratio = (self.preferredFrameSize.height * (2.0/3.0))/self.preferredFrameSize.width;
    ASRatioLayoutSpec *imageRatioSpec = [ASRatioLayoutSpec ratioLayoutSpecWithRatio:ratio child:self.animalImageNode];

    ASOverlayLayoutSpec *gradientOverlaySpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:imageRatioSpec overlay:self.gradientNode];

    ASInsetLayoutSpec *nameInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 16.0, 8.0, 0.0) child:self.animalNameTextNode];
    
    ASStackLayoutSpec *imageVerticalStackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentEnd alignItems:ASStackLayoutAlignItemsStart children:@[nameInsetSpec]];
    
    ASOverlayLayoutSpec *titleOverlaySpec = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:gradientOverlaySpec overlay:imageVerticalStackSpec];
    
    ASInsetLayoutSpec *descriptionTextInsetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(16.0, 28.0, 12.0, 28.0) child:self.animalDescriptionTextNode];
    self.animalDescriptionTextNode.preferredFrameSize = CGSizeMake(self.preferredFrameSize.width, self.preferredFrameSize.height * (1.0/3.0));
    
    ASStackLayoutSpec *verticalStackSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[titleOverlaySpec, descriptionTextInsetSpec]];

    ASBackgroundLayoutSpec *backgroundLayoutSpec = [ASBackgroundLayoutSpec backgroundLayoutSpecWithChild:verticalStackSpec background:self.backgroundImageNode];
    
    return backgroundLayoutSpec;
}

#pragma mark ASNetworkImageNode Delegate

- (void)imageNode:(ASNetworkImageNode *)imageNode didFailWithError:(NSError *)error
{
    NSLog(@"Image failed to load with error: \n%@", error);
}

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image
{
    self.backgroundImageNode.image = image;
}

- (void)displayWillStart
{
    [super displayWillStart];
    
}

- (void)displayDidFinish
{
    [super displayDidFinish];
    
    self.alpha = 0.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}

@end
