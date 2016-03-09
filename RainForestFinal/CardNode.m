
#import "CardNode.h"
#import "Factories.h"
#import "RainforestCardInfo.h"

#import "UIImage+ImageEffects.h"
//#import "AnimalInfo.h"

@interface CardNode ()

@property (nonatomic, strong) ASImageNode *backgroundImageNode;
@property (nonatomic, strong) ASNetworkImageNode *animalImageNode;
@property (nonatomic, strong) ASTextNode *animalNameTextNode;

@property (nonatomic, strong) ASTextNode *animalDescriptionTextNode;

@end

@implementation CardNode

- (instancetype)initWithAnimal:(RainforestCardInfo *)animalInfo;
{
    if (!(self = [super init])) {
        return nil;
    }
    
    self.animalInfo = animalInfo;
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.backgroundImageNode       = [[ASImageNode alloc] init];
    self.animalImageNode           = [[ASNetworkImageNode alloc] init];
    self.animalNameTextNode        = [[ASTextNode alloc] init];
    self.animalDescriptionTextNode = [[ASTextNode alloc] init];
    
    [self addSubnode:self.backgroundImageNode];
    [self addSubnode:self.animalImageNode];
    [self addSubnode:self.animalNameTextNode];
    [self addSubnode:self.animalDescriptionTextNode];
    
    self.animalImageNode.contentMode = UIViewContentModeScaleAspectFill;
    
    self.animalDescriptionTextNode.backgroundColor = [UIColor clearColor];
    
    self.clipsToBounds = YES;
    
    return self;
}

- (void)didLoad
{
    [super didLoad];
    
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
    CGSize size = self.bounds.size;
    
    self.animalImageNode.frame = CGRectMake(0, 0, size.width, size.height * (2.0/3.0));
    self.animalImageNode.clipsToBounds = YES;
    
//    __weak CardNode *weakSelf = self;
    self.animalImageNode.image = [UIImage imageNamed:@"parrot"];
    
    self.animalNameTextNode.attributedString = [NSAttributedString attributedStringForTitleText:self.animalInfo.name];
    self.animalDescriptionTextNode.attributedString = [NSAttributedString attributedStringForDescription:self.animalInfo.animalDescription];
    
    [self.animalNameTextNode measure:CGSizeMake(size.width, size.height * (2.0/3.0))];
    self.animalNameTextNode.bounds = CGRectMake(0, 0, self.animalNameTextNode.calculatedSize.width, self.animalNameTextNode.calculatedSize.height);
    self.animalNameTextNode.position = CGPointMake(16 + self.animalNameTextNode.bounds.size.width/2.0, self.animalImageNode.bounds.size.height + self.animalNameTextNode.bounds.size.height/2.0 + 8);
    
    self.animalDescriptionTextNode.frame = CGRectMake(8, size.height * (2.0/3.0) + 8, size.width - 16, size.height * (1.0/3.0) - 16);
    self.backgroundImageNode.frame = self.bounds;
    
    return [UIScreen mainScreen].bounds.size;
}

@end
