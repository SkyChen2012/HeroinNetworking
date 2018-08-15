//
//  HeroinNetworkAgent.h
//  HeroinNetWorking
//
//  Created by Benson on 2018/8/15.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HeroinBaseRequest;

///  HeroinNetworkAgent is the underlying class that handles actual request generation,
///  serialization and response handling.
@interface HeroinNetworkAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

///  Get the shared agent.
+ (HeroinNetworkAgent *)sharedAgent;

///  Add request to session and start it.
- (void)addRequest:(HeroinBaseRequest *)request;

///  Cancel a request that was previously added.
- (void)cancelRequest:(HeroinBaseRequest *)request;

///  Cancel all requests that were previously added.
- (void)cancelAllRequests;

///  Return the constructed URL of request.
///
///  @param request The request to parse. Should not be nil.
///
///  @return The result URL.
- (NSString *)buildRequestUrl:(HeroinBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
