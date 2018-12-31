#import "FLSFlickrClient.h"

#import "FLSPhoto.h"

static NSString *const kFlickrURL =
    @"https://api.flickr.com/services/rest/"
    @"?method=flickr.photos.search&api_key=675894853ae8ec6c242fa4c077bcf4a0&text=%@&extras=url_s&"
    @"format=json&nojsoncallback=1";

@implementation FLSFlickrClient

- (instancetype)initWithDelegate:(id<FLSFlickrClientDelegate>)delegate {
  self = [super init];
  if (self) {
    _delegate = delegate;
  }
  return self;
}

- (void)fetchWithQuery:(NSString *)query {
  NSError *error;
  NSString *url_string = [NSString stringWithFormat:kFlickrURL, query];
  NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_string]];
  NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                              options:kNilOptions
                                                                error:&error];
  NSArray<NSDictionary *> *photos = json[@"photos"][@"photo"];

  NSMutableArray<FLSPhoto *> *searchResults = [NSMutableArray array];
  for (NSDictionary *photoJson in photos) {
    NSString *url = photoJson[@"url_s"];
    FLSPhoto *photo = [[FLSPhoto alloc] initWithURL:url];
    photo.width = [photoJson[@"width_s"] doubleValue];
    photo.height = [photoJson[@"height_s"] doubleValue];
    [searchResults addObject:photo];
  }

  [_delegate didReceiveSearchResults:searchResults];
}

@end
