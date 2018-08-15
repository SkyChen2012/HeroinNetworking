//
//  HeroinChainRequestAgent.h
//  HeroinNetWorking
//
//  Created by Benson on 2018/8/15.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HeroinChainRequest;

///  HeroinChainRequestAgent handles chain request management. It keeps track of all
///  the chain requests.
@interface HeroinChainRequestAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

///  Get the shared chain request agent.
+ (HeroinChainRequestAgent *)sharedAgent;

///  Add a chain request.
- (void)addChainRequest:(HeroinChainRequest *)request;

///  Remove a previously added chain request.
- (void)removeChainRequest:(HeroinChainRequest *)request;

@end

NS_ASSUME_NONNULL_END
