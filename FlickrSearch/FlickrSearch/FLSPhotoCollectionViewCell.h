#import <UIKit/UIKit.h>

@class FLSPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface FLSPhotoCollectionViewCell : UICollectionViewCell

@property(nonatomic) FLSPhoto *photo;

// TODO: Investigate whether we need initWithCoder
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
