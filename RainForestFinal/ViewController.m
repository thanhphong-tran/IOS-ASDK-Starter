
#import "ViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"

@interface ViewController ()<ASPagerNodeDataSource>
@property (nonatomic) ASPagerNode *pagerNode;
@end

@implementation ViewController

- (instancetype)init
{
    if (!(self = [super init])) { return nil; }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.pagerNode = [[ASPagerNode alloc] init];
    self.pagerNode.backgroundColor = [UIColor purpleColor];
    
    [self.pagerNode setDataSource:self];
    
    [self.view addSubnode:self.pagerNode];
    
    return self;
}

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

#pragma mark ASPagerNode Datasource

- (ASCellNodeBlock)pagerNode:(ASPagerNode *)pagerNode nodeBlockAtIndex:(NSInteger)index
{
    CGSize pagerNodeSize = pagerNode.bounds.size;
    ASCellNode *node = [[ASCellNode alloc] initWithViewControllerBlock:^UIViewController * _Nonnull{
        return [[AnimalTableNodeController alloc] initWithAnimals:[RainforestCardInfo birdCards]];
    } didLoadBlock:nil];
    
    node.backgroundColor = [UIColor colorWithRed:150.0/255.0 green:100.0/255.0 blue:10.0/255.0 alpha:1.0];
    node.preferredFrameSize = pagerNodeSize;
    
    return ^{
        return node;
    };
}

- (NSInteger)numberOfPagesInPagerNode:(ASPagerNode *)pagerNode
{
    return 3;
}

@end
