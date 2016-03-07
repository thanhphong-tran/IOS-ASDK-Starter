
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"

@interface AnimalTableNodeController ()<ASTableDataSource>
@property (nonatomic) ASDisplayNode *theNode;

@property (nonatomic) ASTableNode *tableNode;
@property (nonatomic) NSArray *animals;
@end

@implementation AnimalTableNodeController

- (instancetype)initWithAnimals:(NSArray *)animals
{
//    self.theNode = [[ASDisplayNode alloc] init];
//    self.theNode.backgroundColor = [self randomColor];
    ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];

    if (!(self = [super initWithNode:tableNode])) { return nil; }
    
    self.tableNode = tableNode;
    
    self.animals = animals;
    
    self.tableNode.dataSource = self;
    
//    [self.node addSubnode:self.tableNode];
    
    return self;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGSize size = [UIScreen mainScreen].bounds.size;

    self.theNode.frame = CGRectMake(0, 0, size.width, size.height);

    self.tableNode.frame = self.node.frame;
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
    ASCellNode *node = [[ASCellNode alloc] init];
    node.backgroundColor = [UIColor greenColor];
    node.preferredFrameSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
    
    return ^{
        return node;
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.animals.count;
}

- (UIColor *)randomColor;
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
}

@end
