
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"

@interface AnimalTableNodeController ()<ASTableDataSource>
@property (strong, nonatomic) ASTableNode *tableNode;
@property (strong, nonatomic) NSArray *animals;
@end

@implementation AnimalTableNodeController

- (instancetype)initWithAnimals:(NSArray *)animals
{
    ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];

    if (!(self = [super initWithNode:tableNode])) { return nil; }
    
    self.tableNode = tableNode;
    
    self.animals = animals;
    
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
    return ^{
        CardNode *node = [[CardNode alloc] initWithAnimal:self.animals[indexPath.row]];
        
        node.preferredFrameSize = [UIScreen mainScreen].bounds.size;

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
