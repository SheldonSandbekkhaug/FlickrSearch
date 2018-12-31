#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* const FLSCellIdentifier;

@interface FLSDataSource : NSObject <UICollectionViewDataSource>

@property(nonatomic, weak) UICollectionView* collectionView;

- (void)showPicturesWithQuery:(NSString*)query;

@end

NS_ASSUME_NONNULL_END
