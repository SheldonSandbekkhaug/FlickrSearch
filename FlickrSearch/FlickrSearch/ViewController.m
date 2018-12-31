#import "ViewController.h"

#import "FLSDataSource.h"

// TODO: Add prefix to all classes
@interface ViewController () <UICollectionViewDelegateFlowLayout>

@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) FLSDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame
                                       collectionViewLayout:layout];
  [_collectionView registerClass:[UICollectionViewCell class]
      forCellWithReuseIdentifier:FLSCellIdentifier];
  _dataSource = [[FLSDataSource alloc] init];
  _collectionView.dataSource = _dataSource;
  [_collectionView setDelegate:self];
  [_collectionView setBackgroundColor:[UIColor whiteColor]];

  [self.view addSubview:_collectionView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  return CGSizeMake(50, 50);
}

@end
