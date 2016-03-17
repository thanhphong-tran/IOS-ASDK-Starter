
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"

@interface AnimalTableNodeController ()<ASTableDataSource>
@property (strong, nonatomic) NSArray *animals;
@end

@implementation AnimalTableNodeController

- (instancetype)initWithAnimals:(NSArray *)animals
{
    ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];

    if (!(self = [super initWithNode:tableNode])) { return nil; }

    self.animals = animals;
    
    self.tableNode = tableNode;
    self.tableNode.dataSource = self;
    
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

@end
