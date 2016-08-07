/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "CardNode.h"
#import "Factories.h"
#import "RainforestCardInfo.h"
#import "GradientNode.h"

#import "UIImage+ImageEffects.h"

@interface CardNode ()
@property (strong, nonatomic) RainforestCardInfo *animalInfo;
@property (strong, nonatomic) ASImageNode *backgroundImageNode;
@property (strong, nonatomic) ASNetworkImageNode *animalImageNode;
@property (strong, nonatomic) ASTextNode *animalNameTextNode;
@property (strong, nonatomic) ASTextNode *animalDescriptionTextNode;
@property (strong, nonatomic) GradientNode *gradientNode;
@end

@interface CardNode (ASNetworkImageNodeDelegate)<ASNetworkImageNodeDelegate>
@end


@implementation CardNode

#pragma mark - Lifecycle

- (instancetype)initWithAnimal:(RainforestCardInfo *)animalInfo; {
  if (!(self = [super init])) { return nil; }

  _animalInfo = animalInfo;

  self.backgroundColor = [UIColor lightGrayColor];
  self.clipsToBounds = YES;

  _backgroundImageNode = [[ASImageNode alloc] init];
  _animalImageNode = [[ASNetworkImageNode alloc] init];
  _animalNameTextNode = [[ASTextNode alloc] init];
  _animalDescriptionTextNode = [[ASTextNode alloc] init];
  _gradientNode = [[GradientNode alloc] init];

  //Animal Image
  _animalImageNode.URL = self.animalInfo.imageURL;
  _animalImageNode.clipsToBounds = YES;
  _animalImageNode.delegate = self;
  _animalImageNode.placeholderFadeDuration = 0.15;
  _animalImageNode.contentMode = UIViewContentModeScaleAspectFill;

  //Animal Name
  _animalNameTextNode.attributedString = [NSAttributedString attributedStringForTitleText:self.animalInfo.name];

  //Animal Description
  _animalDescriptionTextNode.attributedString = [NSAttributedString attributedStringForDescription:self.animalInfo.animalDescription];
  _animalDescriptionTextNode.truncationAttributedString = [NSAttributedString attributedStringForDescription:@"…"];
  _animalDescriptionTextNode.backgroundColor = [UIColor clearColor];

  //Background Image
  _backgroundImageNode.placeholderFadeDuration = 0.15;
  _backgroundImageNode.imageModificationBlock = ^(UIImage *image) {
    UIColor *tintColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    UIImage *newImage = [image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
    return newImage ?: image;
  };

  //Gradient Node
  _gradientNode.layerBacked = YES;
  _gradientNode.opaque = NO;

  [self addSubnode:self.backgroundImageNode];
  [self addSubnode:self.animalImageNode];
  [self addSubnode:self.gradientNode];

  [self addSubnode:self.animalNameTextNode];
  [self addSubnode:self.animalDescriptionTextNode];

  return self;
}

#pragma mark - Node Layout

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {

  // Main Image Ratio
  CGFloat ratio = (self.preferredFrameSize.height * (2.0/3.0))/self.preferredFrameSize.width;
  ASRatioLayoutSpec *imageRatioSpec =
  [ASRatioLayoutSpec ratioLayoutSpecWithRatio:ratio
                                        child:self.animalImageNode];
  // Overlay Gradient over Main Image
  ASOverlayLayoutSpec *gradientOverlaySpec =
  [ASOverlayLayoutSpec overlayLayoutSpecWithChild:imageRatioSpec
                                          overlay:self.gradientNode];
  // Inset Name
  ASInsetLayoutSpec *nameInsetSpec =
  [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 16.0, 8.0, 0.0)
                                         child:self.animalNameTextNode];
  // Name Stack
  ASStackLayoutSpec *imageVerticalStackSpec =
  [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                          spacing:0 justifyContent:ASStackLayoutJustifyContentEnd
                                       alignItems:ASStackLayoutAlignItemsStart
                                         children:@[nameInsetSpec]];

  // Overlay Name Stack over MainImage+Gradient
  ASOverlayLayoutSpec *titleOverlaySpec =
  [ASOverlayLayoutSpec overlayLayoutSpecWithChild:gradientOverlaySpec
                                          overlay:imageVerticalStackSpec];

  // Inset Description
  ASInsetLayoutSpec *descriptionTextInsetSpec =
  [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(16.0, 28.0, 12.0, 28.0)
                                         child:self.animalDescriptionTextNode];

  // Description Sizing
  self.animalDescriptionTextNode.preferredFrameSize = CGSizeMake(self.preferredFrameSize.width,
                                                                 self.preferredFrameSize.height * (1.0 / 3.0));
  CGFloat height = [UIScreen mainScreen].bounds.size.height / 3.0;

  ASRelativeSize heightRelativeSize = ASRelativeSizeMake(ASRelativeDimensionMake(ASRelativeDimensionTypePercent, 1.0),
                                                         ASRelativeDimensionMake(ASRelativeDimensionTypePoints, height));

  descriptionTextInsetSpec.sizeRange = ASRelativeSizeRangeMake(heightRelativeSize, heightRelativeSize);


  // Description Text Static
  ASStaticLayoutSpec *staticLayoutSpec =
  [ASStaticLayoutSpec staticLayoutSpecWithChildren:@[descriptionTextInsetSpec]];



  // Title/Description Stack
  ASStackLayoutSpec *verticalStackSpec =
  [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                          spacing:0
                                   justifyContent:ASStackLayoutJustifyContentStart
                                       alignItems:ASStackLayoutAlignItemsStart
                                         children:@[titleOverlaySpec,
                                                    staticLayoutSpec]];

  // Background Blurred Image
  ASBackgroundLayoutSpec *backgroundLayoutSpec =
  [ASBackgroundLayoutSpec backgroundLayoutSpecWithChild:verticalStackSpec
                                             background:self.backgroundImageNode];

  return backgroundLayoutSpec;
}

@end

#pragma mark - ASNetworkImageNodeDelegate

@implementation CardNode (ASNetworkImageNodeDelegate)

- (void)imageNode:(ASNetworkImageNode *)imageNode didFailWithError:(NSError *)error {
  NSLog(@"Image failed to load with error: \n%@", error);
}

- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image {
  self.backgroundImageNode.image = image;
}

@end
