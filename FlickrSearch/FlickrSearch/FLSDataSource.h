#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const FLSCellIdentifier;

/** Handles content for the main collection view. */
@interface FLSDataSource : NSObject <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, weak) UICollectionView *collectionView;

- (void)showPicturesWithQuery:(NSString *)query;

@end

NS_ASSUME_NONNULL_END
