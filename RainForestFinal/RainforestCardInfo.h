
#import <Foundation/Foundation.h>

@interface RainforestCardInfo : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *animalDescription;
@property (strong, nonatomic) NSURL *imageURL;

+ (NSArray *)birdCards;
+ (NSArray *)mammalCards;
+ (NSArray *)reptileCards;

+ (NSArray *)allAnimals;

@end
