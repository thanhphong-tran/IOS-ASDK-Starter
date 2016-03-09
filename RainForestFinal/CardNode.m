
#import "CardNode.h"
#import "Factories.h"
#import "RainforestCardInfo.h"

#import "UIImage+ImageEffects.h"

@interface CardNode ()<ASNetworkImageNodeDelegate>

@property (strong, nonatomic) ASImageNode *backgroundImageNode;
@property (strong, nonatomic) ASNetworkImageNode *animalImageNode;
@property (strong, nonatomic) ASTextNode *animalNameTextNode;

@property (strong, nonatomic) ASTextNode *animalDescriptionTextNode;

@end

@implementation CardNode

- (instancetype)initWithAnimal:(RainforestCardInfo *)animalInfo;
{
    if (!(self = [super init])) {
        return nil;
    }
    
    self.animalInfo = animalInfo;
    
    self.backgroundColor = [UIColor lightGrayColor];
    self.clipsToBounds = YES;
    
    self.backgroundImageNode       = [[ASImageNode alloc] init];
    self.animalImageNode           = [[ASNetworkImageNode alloc] init];
    self.animalNameTextNode        = [[ASTextNode alloc] init];
    self.animalDescriptionTextNode = [[ASTextNode alloc] init];

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
    
    [self addSubnode:self.backgroundImageNode];
    [self addSubnode:self.animalImageNode];
    [self addSubnode:self.animalNameTextNode];
    [self addSubnode:self.animalDescriptionTextNode];
    
    return self;
}

- (void)didLoad
{
    [super didLoad];
    
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    [self.animalNameTextNode measure:constrainedSize];
    [self.animalDescriptionTextNode measure:CGSizeMake(constrainedSize.width - 32, screenSize.height * (1.0/3.0) - 32)];
    
    return [UIScreen mainScreen].bounds.size;
}

- (void)layout
{
    [super layout];
    
    self.animalImageNode.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * (2.0/3.0));
    
    self.animalNameTextNode.bounds = CGRectMake(0, 0, self.animalNameTextNode.calculatedSize.width, self.animalNameTextNode.calculatedSize.height);
    self.animalNameTextNode.position = CGPointMake(16 + self.animalNameTextNode.calculatedSize.width/2.0, self.animalImageNode.calculatedSize.height + self.animalNameTextNode.calculatedSize.height/2.0 + 8);
    
    self.animalDescriptionTextNode.frame = CGRectMake(16, self.bounds.size.height * (2.0/3.0) + 16, self.animalDescriptionTextNode.calculatedSize.width, self.animalDescriptionTextNode.calculatedSize.height);
    self.backgroundImageNode.frame = self.bounds;
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
