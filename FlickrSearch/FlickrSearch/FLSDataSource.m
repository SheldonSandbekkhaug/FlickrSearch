#import "FLSDataSource.h"

#import "FLSFlickrClient.h"
#import "FLSPhotoCollectionViewCell.h"

NSString *const FLSCellIdentifier = @"FLSCellIdentifier";

@interface FLSDataSource () <FLSFlickrClientDelegate>

/** Client for downloading Flickr search results. */
@property(nonatomic) FLSFlickrClient *client;

/** The photos to be shown in the collection view. */
@property(nonatomic) NSMutableArray<FLSPhoto *> *photos;

@end

@implementation FLSDataSource

- (void)showPicturesWithQuery:(NSString *)query {
  if (!_client) {
    _client = [[FLSFlickrClient alloc] initWithDelegate:self];
  }

  _photos = [NSMutableArray array];

  [_client fetchWithQuery:query];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  FLSPhotoCollectionViewCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:FLSCellIdentifier
                                                forIndexPath:indexPath];

  cell.photo = _photos[indexPath.item];
  // TODO: Add image cache
  return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  // TODO: Add infinite scrolling
  return _photos.count;
}

- (void)didReceiveSearchResults:(NSMutableArray<FLSPhoto *> *)results {
  [_photos addObjectsFromArray:results];
}

@end
