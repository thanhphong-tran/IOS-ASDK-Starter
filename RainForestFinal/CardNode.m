
#import "CardNode.h"
#import "Factories.h"
#import "RainforestCardInfo.h"

#import "UIImage+ImageEffects.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@interface CardNode ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *animalImageView;
@property (nonatomic, strong) UILabel *animalNameLabel;

@property (nonatomic, strong) UITextView *animalDescriptionTextView;

@end

@implementation CardNode

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        return nil;
    }
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.animalImageView = [[UIImageView alloc] init];
    self.animalNameLabel = [[UILabel alloc] init];
    self.animalDescriptionTextView = [[UITextView alloc] init];
    
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.animalImageView];
    [self addSubview:self.animalNameLabel];
    [self addSubview:self.animalDescriptionTextView];
    
    self.animalImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.animalDescriptionTextView.scrollEnabled = NO;
    self.animalDescriptionTextView.backgroundColor = [UIColor clearColor];
    
    self.clipsToBounds = YES;
    
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.animalImageView.image = nil;
    self.backgroundImageView.image = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    
    self.animalImageView.frame = CGRectMake(0, 0, size.width, size.height * (2.0/3.0));
    self.animalImageView.clipsToBounds = YES;
    
    __weak CardNode *weakSelf = self;
    [self.animalImageView setImageWithURLRequest:[NSURLRequest requestWithURL:self.animalInfo.imageURL] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        weakSelf.animalImageView.image = image;

        weakSelf.backgroundImageView.image = [image applyBlurWithRadius:30 tintColor:[UIColor colorWithWhite:0.5 alpha:0.3] saturationDeltaFactor:1.8 maskImage:nil];
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    
    self.animalNameLabel.attributedText = [NSAttributedString attributedStringForTitleText:self.animalInfo.name];
    self.animalDescriptionTextView.attributedText = [NSAttributedString attributedStringForDescription:self.animalInfo.animalDescription];
    
    [self.animalNameLabel sizeToFit];
    CGSize nameLabelSize = self.animalNameLabel.bounds.size;
    self.animalNameLabel.center = CGPointMake(16 + nameLabelSize.width/2.0, size.height * (2.0/3.0) - nameLabelSize.height/2.0 - 8);
    
    self.animalDescriptionTextView.frame = CGRectMake(8, size.height * (2.0/3.0) + 8, size.width - 16, size.height * (1.0/3.0) - 16);
    self.backgroundImageView.frame = self.bounds;
}

@end
