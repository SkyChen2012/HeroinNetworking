//
//  HeroinBatchRequestAgent.m
//  HeroinNetWorking
//
//  Created by Benson on 2018/8/15.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "HeroinBatchRequestAgent.h"
#import "HeroinBatchRequest.h"

@interface HeroinBatchRequestAgent()

@property (strong, nonatomic) NSMutableArray<HeroinBatchRequest *> *requestArray;

@end

@implementation HeroinBatchRequestAgent

+ (HeroinBatchRequestAgent *)sharedAgent {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)addBatchRequest:(HeroinBatchRequest *)request {
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeBatchRequest:(HeroinBatchRequest *)request {
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}

@end
