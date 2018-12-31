#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** Represents a photo and its metadata. */
@interface FLSPhoto : NSObject

/** URL of the image. */
@property(nonatomic, readonly) NSString *url;

/** Width of the image. */
@property(nonatomic) CGFloat width;

/** Height of the image. */
@property(nonatomic) CGFloat height;

- (instancetype)initWithURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
