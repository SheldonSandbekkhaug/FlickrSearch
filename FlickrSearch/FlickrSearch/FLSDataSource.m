#import "FLSDataSource.h"

#import "FLSFlickrClient.h"

NSString *const FLSCellIdentifier = @"FLSCellIdentifier";

@interface FLSDataSource () <FLSFlickrClientDelegate>

@property(nonatomic) FLSFlickrClient *client;

@end

@implementation FLSDataSource

- (void)showPicturesWithQuery:(NSString *)query {
  if (!_client) {
    _client = [[FLSFlickrClient alloc] initWithDelegate:self];
  }

  [_client fetchWithQuery:query];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  UICollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:FLSCellIdentifier
                                                forIndexPath:indexPath];

  // TODO: Load in images
  // TODO: Add image cache
  cell.backgroundColor = [UIColor blueColor];
  return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  // TODO: Use real data
  return 150;
}

- (void)didReceiveSearchResults:(NSMutableArray<FLSPhoto *> *)results {
  // TODO: Handle search results
}

@end
