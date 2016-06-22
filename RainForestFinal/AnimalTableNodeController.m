
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface AnimalTableNodeController ()<ASTableDataSource, ASTableDelegate>
@property (strong, nonatomic) NSMutableArray<RainforestCardInfo *> *animals;
@end

@implementation AnimalTableNodeController

#pragma mark - Lifecycle

- (instancetype)initWithAnimals:(NSMutableArray<RainforestCardInfo *> *)animals
{
    ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];

    if (!(self = [super initWithNode:tableNode])) { return nil; }

    self.animals = animals;
    
    self.node.dataSource = self;
    self.node.delegate = self;
    
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    self.node.view.leadingScreensForBatching = 1.0;  // overriding default of 2.0
}


#pragma mark - ASTableDelegate

- (void)tableView:(ASTableView *)tableView willBeginBatchFetchWithContext:(ASBatchContext *)context
{
    //1
    [self nextPageWithCompletion:^(NSArray *animals) {
        //2
        [self insertNewRowsInTableView:animals];
        
        //3
        [context completeBatchFetching:YES];
    }];
}

- (BOOL)shouldBatchFetchForTableView:(ASTableView *)tableView
{
    return YES;
}

#pragma mark - ASTableDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RainforestCardInfo *animal = self.animals[indexPath.row];
    CGSize tableViewSize = tableView.bounds.size;
    
    return ^{
        CardNode *node = [[CardNode alloc] initWithAnimal:animal];
        
        node.preferredFrameSize = tableViewSize;
        node.name = [NSString stringWithFormat:@"cell %ld", (long)indexPath.row];

        return node;
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animals.count;
}

#pragma mark - Helpers

- (void)nextPageWithCompletion:(void (^)(NSArray *))block
{
    NSArray *moreAnimals = [[NSArray alloc] initWithArray:[self.animals subarrayWithRange:NSMakeRange(0, 5)] copyItems:NO];
    
    //it's important that this block is run on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        block(moreAnimals);
    });
}

- (void)insertNewRowsInTableView:(NSArray *)newAnimals
{
    NSInteger section = 0;
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    NSUInteger newTotalNumberOfPhotos = self.animals.count + newAnimals.count;
    for (NSUInteger row = self.animals.count; row < newTotalNumberOfPhotos; row++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
        [indexPaths addObject:path];
    }
    
    [self.animals addObjectsFromArray:newAnimals];
    [self.node.view insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

@end
