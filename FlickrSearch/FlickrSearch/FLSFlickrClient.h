#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FLSPhoto;

@protocol FLSFlickrClientDelegate

- (void)didReceiveSearchResults:(NSMutableArray<FLSPhoto *> *)results;

@end

/** Fetches data from the Flickr API. */
@interface FLSFlickrClient : NSObject

@property(nonatomic, weak, readonly) id<FLSFlickrClientDelegate> delegate;

- (instancetype)initWithDelegate:(id<FLSFlickrClientDelegate>)delegate NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)fetchWithQuery:(NSString *)query;

@end

NS_ASSUME_NONNULL_END
