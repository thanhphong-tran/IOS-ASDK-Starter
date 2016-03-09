
#import <UIKit/UIKit.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class RainforestCardInfo;

@interface CardNode : ASCellNode
@property (nonatomic, strong) RainforestCardInfo *animalInfo;
@end
