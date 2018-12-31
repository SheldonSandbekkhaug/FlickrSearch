#import "ViewController.h"

#import "FLSDataSource.h"
#import "FLSPhotoCollectionViewCell.h"

static const CGFloat kMargin = 10;

// TODO: Add prefix to all classes
@interface ViewController ()

@property(nonatomic) UITextField *searchBox;
@property(nonatomic) UICollectionView *collectionView;
@property(nonatomic) FLSDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIView *topBar = [[UIView alloc] init];
  topBar.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:topBar];
  [NSLayoutConstraint activateConstraints:@[
    [topBar.heightAnchor constraintEqualToConstant:80],
    [topBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [topBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [topBar.topAnchor constraintEqualToAnchor:self.view.topAnchor
                                     constant:[self safeAreaInsets].top]
  ]];

  UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
  searchButton.translatesAutoresizingMaskIntoConstraints = NO;
  [topBar addSubview:searchButton];

  // TODO: Tap "Enter" to search (UITextFieldDelegate textFieldShouldReturn)
  _searchBox = [[UITextField alloc] init];
  _searchBox.translatesAutoresizingMaskIntoConstraints = NO;
  [topBar addSubview:_searchBox];
  [NSLayoutConstraint activateConstraints:@[
    [_searchBox.leadingAnchor constraintEqualToAnchor:topBar.leadingAnchor constant:kMargin],
    [_searchBox.topAnchor constraintEqualToAnchor:topBar.topAnchor constant:kMargin],
    [_searchBox.bottomAnchor constraintEqualToAnchor:topBar.bottomAnchor constant:-kMargin],
    [_searchBox.trailingAnchor constraintEqualToAnchor:searchButton.leadingAnchor
                                              constant:-kMargin],
  ]];
  _searchBox.placeholder = @"Type to search";
  _searchBox.borderStyle = UITextBorderStyleLine;

  [searchButton setTitle:@"Search" forState:UIControlStateNormal];  // TODO: Internationalize
  searchButton.backgroundColor = [UIColor blueColor];
  [NSLayoutConstraint activateConstraints:@[
    [searchButton.widthAnchor constraintEqualToConstant:90],
    [searchButton.trailingAnchor constraintEqualToAnchor:topBar.trailingAnchor constant:-kMargin],
    [searchButton.topAnchor constraintEqualToAnchor:topBar.topAnchor constant:kMargin],
    [searchButton.bottomAnchor constraintEqualToAnchor:topBar.bottomAnchor constant:-kMargin],
  ]];
  [searchButton addTarget:self
                   action:@selector(startSearch)
         forControlEvents:UIControlEventTouchUpInside];

  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  [_collectionView registerClass:[FLSPhotoCollectionViewCell class]
      forCellWithReuseIdentifier:FLSCellIdentifier];
  _dataSource = [[FLSDataSource alloc] init];
  _dataSource.collectionView = _collectionView;
  _collectionView.dataSource = _dataSource;
  _collectionView.delegate = _dataSource;
  [_collectionView setBackgroundColor:[UIColor whiteColor]];

  [self.view addSubview:_collectionView];
  _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
  [NSLayoutConstraint activateConstraints:@[
    [_collectionView.topAnchor constraintEqualToAnchor:topBar.bottomAnchor],
    [_collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [_collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [_collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
  ]];
}

- (void)startSearch {
  [_dataSource showPicturesWithQuery:_searchBox.text];
}

- (UIEdgeInsets)safeAreaInsets {
  static CGFloat kStatusBarHeight = 20;

  if (@available(iOS 11.0, *)) {
    UIWindow *window = nil;
    id appDelegate = UIApplication.sharedApplication.delegate;
    if ([appDelegate respondsToSelector:@selector(window)]) {
      window = [appDelegate window];
    } else {
      window = UIApplication.sharedApplication.keyWindow;
    }
    UIEdgeInsets safeAreaInsets = window.safeAreaInsets;
    CGFloat top = MAX(safeAreaInsets.top, kStatusBarHeight);
    return UIEdgeInsetsMake(top, safeAreaInsets.right, safeAreaInsets.bottom, safeAreaInsets.left);
  }

  return UIEdgeInsetsMake(kStatusBarHeight, 0, 0, 0);
}

// TODO: Handle screen rotation

@end
