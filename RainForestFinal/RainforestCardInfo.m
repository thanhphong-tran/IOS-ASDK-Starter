
#import "RainforestCardInfo.h"

NSString const* BIRD_BASE_URL = @"http://www.raywenderlich.com/downloads/Progressive_Images/Birds";
NSString const* MAMMAL_BASE_URL = @"http://www.raywenderlich.com/downloads/Progressive_Images/Mammals";
NSString const* REPTILE_BASE_URL = @"http://www.raywenderlich.com/downloads/Progressive_Images/Reptiles";

@implementation RainforestCardInfo

+ (NSArray *)birdCards;
{
    NSDictionary *parrotData     = @{@"name": @"Parrot", @"imageURL": [NSString stringWithFormat:@"%@/blueHeadedParrot.jpg", BIRD_BASE_URL], @"animalDescription": @""};
    NSDictionary *harpyEagleData = @{@"name": @"Harpy Eagle", @"imageURL": [NSString stringWithFormat:@"%@/HarpyEagle.jpg", BIRD_BASE_URL], @"animalDescription": @""};
    NSDictionary *loveBirdData   = @{@"name": @"Love Bird", @"imageURL": [NSString stringWithFormat:@"%@/LoveBird.jpg", BIRD_BASE_URL], @"animalDescription": @""};
    NSDictionary *macawBirdData  = @{@"name": @"Macaw", @"imageURL": [NSString stringWithFormat:@"%@/Macaw.jpg", BIRD_BASE_URL], @"animalDescription": @""};
    NSDictionary *mergusDuckData = @{@"name": @"Mergus Duck", @"imageURL": [NSString stringWithFormat:@"%@/MergusDuck.jpg", BIRD_BASE_URL], @"animalDescription": @""};
    
    RainforestCardInfo *parrotInfo     = [[self alloc] initWithDictionary:parrotData];
    RainforestCardInfo *harpyEagleInfo = [[self alloc] initWithDictionary:harpyEagleData];
    RainforestCardInfo *loveBirdInfo   = [[self alloc] initWithDictionary:loveBirdData];
    RainforestCardInfo *macawInfo      = [[self alloc] initWithDictionary:macawBirdData];
    RainforestCardInfo *mergusDuckInfo = [[self alloc] initWithDictionary:mergusDuckData];
    
    return @[parrotInfo, harpyEagleInfo, loveBirdInfo, macawInfo, mergusDuckInfo];
}

+ (NSArray *)mammalCards
{
    NSDictionary *jaguarData = @{@"name": @"Jaguar", @"imageURL": [NSString stringWithFormat:@"%@/Jaguar.jpg", MAMMAL_BASE_URL], @"animalDescription": @""};
    NSDictionary *margayCatData = @{@"name": @"Margay Cat", @"imageURL": [NSString stringWithFormat:@"%@/MargayCat.jpg", MAMMAL_BASE_URL], @"animalDescription": @""};
    NSDictionary *monkeyData = @{@"name": @"Monkey", @"imageURL": [NSString stringWithFormat:@"%@/monkey.jpg", MAMMAL_BASE_URL], @"animalDescription": @""};
    NSDictionary *northernTamanduaData  = @{@"name": @"Northern Tamandua", @"imageURL": [NSString stringWithFormat:@"%@/northernTamandua.jpg", MAMMAL_BASE_URL], @"animalDescription": @""};
    NSDictionary *slothData = @{@"name": @"Sloth", @"imageURL": [NSString stringWithFormat:@"%@/sloth.jpg", MAMMAL_BASE_URL], @"animalDescription": @""};
    
    RainforestCardInfo *jaguarInfo           = [[self alloc] initWithDictionary:jaguarData];
    RainforestCardInfo *margayCatInfo        = [[self alloc] initWithDictionary:margayCatData];
    RainforestCardInfo *monkeyInfo           = [[self alloc] initWithDictionary:monkeyData];
    RainforestCardInfo *northernTamanduaInfo = [[self alloc] initWithDictionary:northernTamanduaData];
    RainforestCardInfo *slothInfo            = [[self alloc] initWithDictionary:slothData];
    
    return @[jaguarInfo, margayCatInfo, monkeyInfo, northernTamanduaInfo, slothInfo];
}

+ (NSArray *)reptileCards;
{
    NSDictionary *alligatorData = @{@"name": @"Parrot", @"imageURL": [NSString stringWithFormat:@"%@/Alligator.jpg", REPTILE_BASE_URL], @"animalDescription": @""};
    NSDictionary *beardedDragonData = @{@"name": @"Harpy Eagle", @"imageURL": [NSString stringWithFormat:@"%@/BeardedDragon.jpg", REPTILE_BASE_URL], @"animalDescription": @""};
    NSDictionary *komodoDragonData   = @{@"name": @"Love Bird", @"imageURL": [NSString stringWithFormat:@"%@/KomodoDragon.jpg", REPTILE_BASE_URL], @"animalDescription": @""};
    NSDictionary *spectacledCaimanData  = @{@"name": @"Macaw", @"imageURL": [NSString stringWithFormat:@"%@/SpectacledDragon.jpg", REPTILE_BASE_URL], @"animalDescription": @""};
    NSDictionary *tRexData = @{@"name": @"T-Rex", @"imageURL": [NSString stringWithFormat:@"%@/TRex.jpg", REPTILE_BASE_URL], @"animalDescription": @""};
    
    RainforestCardInfo *alligatorInfo     = [[self alloc] initWithDictionary:alligatorData];
    RainforestCardInfo *beardedDragonInfo = [[self alloc] initWithDictionary:beardedDragonData];
    RainforestCardInfo *komodoDragonInfo   = [[self alloc] initWithDictionary:komodoDragonData];
    RainforestCardInfo *spectacledCaimanInfo      = [[self alloc] initWithDictionary:spectacledCaimanData];
    RainforestCardInfo *tRexInfo = [[self alloc] initWithDictionary:tRexData];
    
    return @[alligatorInfo, beardedDragonInfo, komodoDragonInfo, spectacledCaimanInfo, tRexInfo];
}

- (instancetype)initWithDictionary:(NSDictionary *)animalData
{
    if (!(self = [super init])) {
        return nil;
    }
    
    self.name = animalData[@"name"];
    self.animalDescription = animalData[@"animalDescription"];
    self.imageURL = [NSURL URLWithString:animalData[@"imageURL"]];
    
    return self;
}

@end
