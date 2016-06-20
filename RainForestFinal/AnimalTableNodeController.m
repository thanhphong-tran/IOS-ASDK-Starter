
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"
#import "CardCell.h"

static NSString *kCellReuseIdentifier = @"CellReuseIdentifier";

@interface AnimalTableNodeController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *animals;
@end

@implementation AnimalTableNodeController

- (instancetype)initWithAnimals:(NSArray *)animals
{
    if (!(self = [super init])) { return nil; }
    
    self.animals = animals.mutableCopy;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[CardCell class] forCellReuseIdentifier:kCellReuseIdentifier];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
        
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark ASTableNode DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.animalInfo = self.animals[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animals.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.height;
}

#pragma mark ASTableNode Delegate



#pragma mark Helpers

//- (void)retrieveNextPageWithCompletion:(void (^)(NSArray *))block
//{
//    NSArray *moreAnimals = [[NSArray alloc] initWithArray:[self.animals subarrayWithRange:NSMakeRange(0, 5)] copyItems:NO];
//    
//    //it's important that this block is run on the main thread
//    dispatch_async(dispatch_get_main_queue(), ^{
//        block(moreAnimals);
//    });
//}
//
//- (void)insertNewRowsInTableView:(NSArray *)newAnimals
//{
//    NSInteger section = 0;
//    NSMutableArray *indexPaths = [NSMutableArray array];
//    
//    NSUInteger newTotalNumberOfPhotos = self.animals.count + newAnimals.count;
//    for (NSUInteger row = self.animals.count; row < newTotalNumberOfPhotos; row++) {
//        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
//        [indexPaths addObject:path];
//    }
//    
//    [self.animals addObjectsFromArray:newAnimals];
//    [self.tableNode.view insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
//}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end

