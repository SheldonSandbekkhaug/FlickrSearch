#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** Represents a photo and its metadata. */
@interface FLSPhoto : NSObject

/** URL of the image. */
@property(nonatomic, readonly) NSString *url;

// TODO: Use width and height
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

- (instancetype)initWithURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
