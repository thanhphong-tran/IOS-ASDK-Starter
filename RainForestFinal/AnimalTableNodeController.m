
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"

#import <ASDisplayKit/ASDisplayKit.h>

static NSString *kCellReuseIdentifier = @"CellReuseIdentifier";

@interface AnimalTableNodeController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) astable *tableView;
@property (nonatomic, strong) NSArray *animals;
@end

@implementation AnimalTableNodeController

- (instancetype)initWithAnimals:(NSArray *)animals
{
    if (!(self = [super init])) { return nil; }
    
    self.animals = animals;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[CardNode class] forCellReuseIdentifier:kCellReuseIdentifier];
    
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
    CardNode *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    
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

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
