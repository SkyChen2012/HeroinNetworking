//
//  HeroinBatchRequest.m
//  HeroinNetWorking
//
//  Created by Benson on 2018/8/15.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "HeroinBatchRequest.h"
#import "HeroinNetworkPrivate.h"
#import "HeroinBatchRequestAgent.h"
#import "HeroinRequest.h"

@interface HeroinBatchRequest() <HeroinRequestDelegate>

@property (nonatomic) NSInteger finishedCount;

@end

@implementation HeroinBatchRequest

- (instancetype)initWithRequestArray:(NSArray<HeroinRequest *> *)requestArray {
    self = [super init];
    if (self) {
        _requestArray = [requestArray copy];
        _finishedCount = 0;
        for (HeroinRequest * req in _requestArray) {
            if (![req isKindOfClass:[HeroinRequest class]]) {
                HeroinLog(@"Error, request item must be HeroinRequest instance.");
                return nil;
            }
        }
    }
    return self;
}

- (void)start {
    if (_finishedCount > 0) {
        HeroinLog(@"Error! Batch request has already started.");
        return;
    }
    _failedRequest = nil;
    [[HeroinBatchRequestAgent sharedAgent] addBatchRequest:self];
    [self toggleAccessoriesWillStartCallBack];
    for (HeroinRequest * req in _requestArray) {
        req.delegate = self;
        [req clearCompletionBlock];
        [req start];
    }
}

- (void)stop {
    [self toggleAccessoriesWillStopCallBack];
    _delegate = nil;
    [self clearRequest];
    [self toggleAccessoriesDidStopCallBack];
    [[HeroinBatchRequestAgent sharedAgent] removeBatchRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(HeroinBatchRequest *batchRequest))success
                                    failure:(void (^)(HeroinBatchRequest *batchRequest))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(HeroinBatchRequest *batchRequest))success
                              failure:(void (^)(HeroinBatchRequest *batchRequest))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (BOOL)isDataFromCache {
    BOOL result = YES;
    for (HeroinRequest *request in _requestArray) {
        if (!request.isDataFromCache) {
            result = NO;
        }
    }
    return result;
}


- (void)dealloc {
    [self clearRequest];
}

#pragma mark - Network Request Delegate

- (void)requestFinished:(HeroinRequest *)request {
    _finishedCount++;
    if (_finishedCount == _requestArray.count) {
        [self toggleAccessoriesWillStopCallBack];
        if ([_delegate respondsToSelector:@selector(batchRequestFinished:)]) {
            [_delegate batchRequestFinished:self];
        }
        if (_successCompletionBlock) {
            _successCompletionBlock(self);
        }
        [self clearCompletionBlock];
        [self toggleAccessoriesDidStopCallBack];
        [[HeroinBatchRequestAgent sharedAgent] removeBatchRequest:self];
    }
}

- (void)requestFailed:(HeroinRequest *)request {
    _failedRequest = request;
    [self toggleAccessoriesWillStopCallBack];
    // Stop
    for (HeroinRequest *req in _requestArray) {
        [req stop];
    }
    // Callback
    if ([_delegate respondsToSelector:@selector(batchRequestFailed:)]) {
        [_delegate batchRequestFailed:self];
    }
    if (_failureCompletionBlock) {
        _failureCompletionBlock(self);
    }
    // Clear
    [self clearCompletionBlock];
    
    [self toggleAccessoriesDidStopCallBack];
    [[HeroinBatchRequestAgent sharedAgent] removeBatchRequest:self];
}

- (void)clearRequest {
    for (HeroinRequest * req in _requestArray) {
        [req stop];
    }
    [self clearCompletionBlock];
}

#pragma mark - Request Accessoies

- (void)addAccessory:(id<HeroinRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}

@end
