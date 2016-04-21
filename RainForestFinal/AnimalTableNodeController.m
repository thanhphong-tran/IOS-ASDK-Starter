
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"

@interface AnimalTableNodeController ()<ASTableDataSource, ASTableDelegate>
@property (strong, nonatomic) NSMutableArray *animals;
@end

@implementation AnimalTableNodeController

- (instancetype)initWithAnimals:(NSMutableArray *)animals
{
    ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];

    if (!(self = [super initWithNode:tableNode])) { return nil; }

    self.animals = animals;
    
    self.tableNode = tableNode;
    self.tableNode.dataSource = self;
    self.tableNode.delegate = self;
    
    self.tableNode.view.leadingScreensForBatching = 1.0;  // overriding default of 2.0
    
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableNode.frame = [UIScreen mainScreen].bounds;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark ASTableNode Delegate
- (void)tableView:(ASTableView *)tableView willBeginBatchFetchWithContext:(ASBatchContext *)context
{
    [self nextPageWithCompletion:^(NSArray *animals) {
        [self insertNewRowsInTableView:animals];
        
        [context completeBatchFetching:YES];
    }];
}

- (BOOL)shouldBatchFetchForTableView:(ASTableView *)tableView
{
    return YES;
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

#pragma mark Helpers
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
    [self.tableNode.view insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

@end
