
#import "ViewController.h"
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ViewController ()<ASPagerNodeDataSource>
@property (strong, nonatomic) ASPagerNode *pagerNode;

@property (strong, nonatomic) NSArray<NSMutableArray<RainforestCardInfo *> *> *animals;
@end

@implementation ViewController

#pragma mark - Lifecycle

- (instancetype)init
{
    if (!(self = [super init])) { return nil; }
    
    self.animals = @[[RainforestCardInfo birdCards].mutableCopy, [RainforestCardInfo mammalCards].mutableCopy, [RainforestCardInfo reptileCards].mutableCopy];
    
    self.pagerNode = [[ASPagerNode alloc] init];
    self.pagerNode.backgroundColor = [UIColor blackColor];
    self.pagerNode.dataSource = self;
    
    return self;
}

#pragma mark - UIViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.pagerNode.frame = self.view.bounds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubnode:self.pagerNode];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - ASPagerNode Datasource

- (NSInteger)numberOfPagesInPagerNode:(ASPagerNode *)pagerNode
{
    return self.animals.count;
}

- (ASCellNodeBlock)pagerNode:(ASPagerNode *)pagerNode nodeBlockAtIndex:(NSInteger)index
{
    CGSize pagerNodeSize = pagerNode.bounds.size;
    NSMutableArray *animals = self.animals[index];

    return ^{
        ASCellNode *node = [[ASCellNode alloc] initWithViewControllerBlock:^UIViewController * _Nonnull{
            AnimalTableNodeController *tableNodeController = [[AnimalTableNodeController alloc] initWithAnimals:animals];
            return tableNodeController;
        } didLoadBlock:nil];
        node.backgroundColor = [UIColor colorWithRed:150.0/255.0 green:100.0/255.0 blue:10.0/255.0 alpha:1.0];
        node.preferredFrameSize = pagerNodeSize;
        return node;
    };
}

@end
