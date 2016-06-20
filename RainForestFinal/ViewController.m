
#import "ViewController.h"
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"
#import "CardNode.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ViewController ()<ASPagerDataSource>
@property (strong, nonatomic) ASPagerNode *pagerNode;

@property (strong, nonatomic) NSArray *animals;
@end

@implementation ViewController

- (instancetype)init
{
    if (!(self = [super init])) { return nil; }
    
    self.animals = @[[RainforestCardInfo birdCards], [RainforestCardInfo mammalCards], [RainforestCardInfo reptileCards]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //Create and user an ASPagerNode Here
    
    
    self.pagerNode.backgroundColor = [UIColor blackColor];
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



- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
