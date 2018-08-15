//
//  HeroinChainRequestAgent.m
//  HeroinNetWorking
//
//  Created by Benson on 2018/8/15.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "HeroinChainRequestAgent.h"
#import "HeroinChainRequest.h"

@interface HeroinChainRequestAgent()

@property (strong, nonatomic) NSMutableArray<HeroinChainRequest *> *requestArray;

@end

@implementation HeroinChainRequestAgent

+ (HeroinChainRequestAgent *)sharedAgent {
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

- (void)addChainRequest:(HeroinChainRequest *)request {
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeChainRequest:(HeroinChainRequest *)request {
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}

@end
