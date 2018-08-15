//
//  HeroinBatchRequestAgent.h
//  HeroinNetWorking
//
//  Created by Benson on 2018/8/15.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HeroinBatchRequest;

///  HeroinBatchRequestAgent handles batch request management. It keeps track of all
///  the batch requests.
@interface HeroinBatchRequestAgent : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

///  Get the shared batch request agent.
+ (HeroinBatchRequestAgent *)sharedAgent;

///  Add a batch request.
- (void)addBatchRequest:(HeroinBatchRequest *)request;

///  Remove a previously added batch request.
- (void)removeBatchRequest:(HeroinBatchRequest *)request;

@end

NS_ASSUME_NONNULL_END
