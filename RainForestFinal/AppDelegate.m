
#import "AppDelegate.h"
#import "ViewController.h"
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    CGRect windowRect = [[UIScreen mainScreen] bounds];
    
    _window = [[UIWindow alloc] initWithFrame:windowRect];
    
//    ViewController *vc = [[ViewController alloc] init];
    AnimalTableNodeController *vc = [[AnimalTableNodeController alloc] initWithAnimals:[RainforestCardInfo reptileCards]];
    [_window setRootViewController:vc];
    
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
