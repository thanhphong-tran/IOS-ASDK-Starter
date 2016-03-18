
#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

@class RainforestCardInfo;

@interface CardNode : ASCellNode

- (instancetype)initWithAnimal:(RainforestCardInfo *)animalInfo;

@property (strong, nonatomic) RainforestCardInfo *animalInfo;
@end
