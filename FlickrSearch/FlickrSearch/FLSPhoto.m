#import "FLSPhoto.h"

@implementation FLSPhoto

- (instancetype)initWithURL:(NSString *)url {
  self = [super init];
  if (self) {
    _url = url;
  }

  return self;
}

@end
