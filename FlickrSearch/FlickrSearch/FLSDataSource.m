#import "FLSDataSource.h"

NSString *const FLSCellIdentifier = @"FLSCellIdentifier";

@implementation FLSDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  UICollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:FLSCellIdentifier
                                                forIndexPath:indexPath];

  // TODO: Load in images
  cell.backgroundColor = [UIColor blueColor];
  return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  // TODO: Use real data
  return 150;
}

@end
