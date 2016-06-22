#import <AsyncDisplayKit/AsyncDisplayKit.h>

@class RainforestCardInfo;

@interface AnimalTableNodeController : ASViewController<ASTableNode *>

- (instancetype)initWithAnimals:(NSMutableArray<RainforestCardInfo *> *)animals;

@end
