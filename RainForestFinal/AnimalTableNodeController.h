
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface AnimalTableNodeController : ASViewController

@property (strong, nonatomic) ASTableNode *tableNode;
@property (assign, nonatomic) NSInteger index;

- (instancetype)initWithAnimals:(NSArray *)animals;
@end
