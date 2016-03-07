
#import <Foundation/Foundation.h>

@interface RainforestCardInfo : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *animalDescription;
@property (nonatomic) NSURL *imageURL;

+ (NSArray *)birdCards;
+ (NSArray *)mammalCards;
+ (NSArray *)reptileCards;

@end
