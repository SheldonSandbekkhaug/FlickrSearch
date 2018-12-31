#import "FLSFlickrClient.h"

#import "FLSPhoto.h"

static NSString *const kFlickrURL =
    @"https://api.flickr.com/services/rest/"
    @"?method=flickr.photos.search&api_key=675894853ae8ec6c242fa4c077bcf4a0&text=%@&extras=url_s&"
    @"format=json&nojsoncallback=1&page=%@";

@implementation FLSFlickrClient

- (instancetype)initWithDelegate:(id<FLSFlickrClientDelegate>)delegate {
  self = [super init];
  if (self) {
    _delegate = delegate;
  }
  return self;
}

- (void)fetchWithQuery:(NSString *)query {
  [self fetchWithQuery:query page:1];
}

- (void)fetchWithQuery:(NSString *)query page:(int)page {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSString *pageString = [NSString stringWithFormat:@"%d", page];
    NSString *urlString = [NSString stringWithFormat:kFlickrURL, query, pageString];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    NSError *error;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                options:kNilOptions
                                                                  error:&error];
    if (error) {
      // TODO: Show error message
      return;
    }

    NSArray<NSDictionary *> *photos = json[@"photos"][@"photo"];

    NSMutableArray<FLSPhoto *> *searchResults = [NSMutableArray array];
    for (NSDictionary *photoJson in photos) {
      NSString *url = photoJson[@"url_s"];
      FLSPhoto *photo = [[FLSPhoto alloc] initWithURL:url];
      photo.width = [photoJson[@"width_s"] doubleValue];
      photo.height = [photoJson[@"height_s"] doubleValue];
      [searchResults addObject:photo];
    }

    [self->_delegate didReceiveSearchResults:searchResults];
  });
}

@end
