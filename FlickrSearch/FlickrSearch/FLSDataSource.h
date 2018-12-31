#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* const FLSCellIdentifier;

@interface FLSDataSource : NSObject <UICollectionViewDataSource>

- (void)showPicturesWithQuery:(NSString*)query;

@end

NS_ASSUME_NONNULL_END
