
#import "AppDelegate.h"
#import "AnimalTableNodeController.h"
#import "RainforestCardInfo.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    CGRect windowRect = [[UIScreen mainScreen] bounds];
    
    _window = [[UIWindow alloc] initWithFrame:windowRect];
    
    AnimalTableNodeController *vc = [[AnimalTableNodeController alloc] initWithAnimals:[RainforestCardInfo allAnimals]];
    [_window setRootViewController:vc];
    
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
