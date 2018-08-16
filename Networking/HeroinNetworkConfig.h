//
//  HeroinNetworkConfig.h
//  HeroinNetWorking
//
//  Created by Benson on 2018/8/15.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#else
#import "AFNetworking.h"
#endif


NS_ASSUME_NONNULL_BEGIN

@class HeroinBaseRequest;
@class AFSecurityPolicy;

///  HeroinUrlFilterProtocol can be used to append common parameters to requests before sending them.
@protocol HeroinUrlFilterProtocol <NSObject>
///  Preprocess request URL before actually sending them.
///
///  @param originUrl request's origin URL, which is returned by `requestUrl`
///  @param request   request itself
///
///  @return A new url which will be used as a new `requestUrl`
- (NSString *)filterUrl:(NSString *)originUrl withRequest:(HeroinBaseRequest *)request;
@end

///  HeroinCacheDirPathFilterProtocol can be used to append common path components when caching response results
@protocol HeroinCacheDirPathFilterProtocol <NSObject>
///  Preprocess cache path before actually saving them.
///
///  @param originPath original base cache path, which is generated in `HeroinRequest` class.
///  @param request    request itself
///
///  @return A new path which will be used as base path when caching.
- (NSString *)filterCacheDirPath:(NSString *)originPath withRequest:(HeroinBaseRequest *)request;
@end

///  HeroinNetworkConfig stored global network-related configurations, which will be used in `HeroinNetworkAgent`
///  to form and filter requests, as well as caching response.
@interface HeroinNetworkConfig : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

///  Return a shared config object.
+ (HeroinNetworkConfig *)sharedConfig;

///  Request base URL, such as "http://www.yuantiku.com". Default is empty string.
@property (nonatomic, strong) NSString *baseUrl;
///  Request CDN URL. Default is empty string.
@property (nonatomic, strong) NSString *cdnUrl;
///  URL filters. See also `HeroinUrlFilterProtocol`.
@property (nonatomic, strong, readonly) NSArray<id<HeroinUrlFilterProtocol>> *urlFilters;
///  Cache path filters. See also `HeroinCacheDirPathFilterProtocol`.
@property (nonatomic, strong, readonly) NSArray<id<HeroinCacheDirPathFilterProtocol>> *cacheDirPathFilters;
///  Security policy will be used by AFNetworking. See also `AFSecurityPolicy`.
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;
///  Whether to log debug info. Default is NO;
@property (nonatomic) BOOL debugLogEnabled;
///  SessionConfiguration will be used to initialize AFHTTPSessionManager. Default is nil.
@property (nonatomic, strong) NSURLSessionConfiguration* sessionConfiguration;

///  Add a new URL filter.
- (void)addUrlFilter:(id<HeroinUrlFilterProtocol>)filter;
///  Remove all URL filters.
- (void)clearUrlFilter;
///  Add a new cache path filter
- (void)addCacheDirPathFilter:(id<HeroinCacheDirPathFilterProtocol>)filter;
///  Clear all cache path filters.
- (void)clearCacheDirPathFilter;

@end

NS_ASSUME_NONNULL_END
