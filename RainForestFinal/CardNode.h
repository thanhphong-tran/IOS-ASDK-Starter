
#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class RainforestCardInfo;

@interface CardNode : ASCellNode

- (instancetype)initWithAnimal:(RainforestCardInfo *)animalInfo;

@property (nonatomic, strong) RainforestCardInfo *animalInfo;
@end
