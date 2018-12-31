#import "FLSPhotoCollectionViewCell.h"

#import "FLSPhoto.h"

@interface FLSPhotoCollectionViewCell ()

@property(nonatomic) UIImageView *imageView;

@end

@implementation FLSPhotoCollectionViewCell

- (instancetype)init {
  return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _imageView = [[UIImageView alloc] init];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_imageView];
    [NSLayoutConstraint activateConstraints:@[
      [self.centerXAnchor constraintEqualToAnchor:_imageView.centerXAnchor],
      [self.centerYAnchor constraintEqualToAnchor:_imageView.centerYAnchor],
      [self.leadingAnchor constraintEqualToAnchor:_imageView.leadingAnchor],
      [self.trailingAnchor constraintEqualToAnchor:_imageView.trailingAnchor],
      [self.topAnchor constraintEqualToAnchor:_imageView.topAnchor],
      [self.bottomAnchor constraintEqualToAnchor:_imageView.bottomAnchor],
    ]];
  }
  return self;
}

- (void)setPhoto:(FLSPhoto *)photo {
  _photo = photo;
  if (!photo || !photo.url.length) {
    return;
  }
  FLSPhoto *oldPhoto = photo;

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:photo.url]];
    if (!data) {
      // TODO: Show an error message
      return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      if (oldPhoto == self->_photo) {
        // Don't add a new image if self->_photo has changed
        self->_imageView.image = [UIImage imageWithData:data];
      }
    });
  });
}

- (void)prepareForReuse {
  _photo = nil;
  _imageView.image = nil;
  [super prepareForReuse];
}

@end
