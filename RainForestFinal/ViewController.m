
#import "ViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"

@interface ViewController ()<ASPagerNodeDataSource, ASTableDataSource>
@property (strong, nonatomic) ASPagerNode *pagerNode;

@property (strong, nonatomic) NSArray *animals;
@end

@implementation ViewController

- (instancetype)init
{
    if (!(self = [super init])) { return nil; }
    
    self.animals = [RainforestCardInfo allAnimals];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.pagerNode = [[ASPagerNode alloc] init];
    self.pagerNode.backgroundColor = [UIColor blackColor];
    
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
    __weak ViewController *weakSelf = self;
    
    ASCellNode *node = [[ASCellNode alloc] initWithViewControllerBlock:^UIViewController * _Nonnull{
        AnimalTableNodeController *tableNodeController = [[AnimalTableNodeController alloc] initWithAnimals:[RainforestCardInfo allAnimals]];
        tableNodeController.tableNode.dataSource = weakSelf;
        return tableNodeController;
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

#pragma mark ASTableNode DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RainforestCardInfo *animal = self.animals[indexPath.row];
    
    return ^{
        CardNode *node = [[CardNode alloc] initWithAnimal:animal];
        
        node.preferredFrameSize = [UIScreen mainScreen].bounds.size;
        
        return node;
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.animals.count;
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
