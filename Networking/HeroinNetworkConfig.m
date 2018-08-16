//
//  HeroinNetworkConfig.m
//  HeroinNetWorking
//
//  Created by Benson on 2018/8/15.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import "HeroinNetworkConfig.h"
#import "HeroinBaseRequest.h"

@implementation HeroinNetworkConfig{
    
    NSMutableArray<id<HeroinUrlFilterProtocol>> *_urlFilters;
    NSMutableArray<id<HeroinCacheDirPathFilterProtocol>> *_cacheDirPathFilters;
    
}

+ (HeroinNetworkConfig *)sharedConfig{
 
    static id shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _baseUrl = @"";
        _cdnUrl = @"";
        _urlFilters = [NSMutableArray array];
        _cacheDirPathFilters = [NSMutableArray array];
        _securityPolicy = [AFSecurityPolicy defaultPolicy];
        _debugLogEnabled = NO;
    }
    
    return self;
}

- (void)addUrlFilter:(id<HeroinUrlFilterProtocol>)filter{
    [_urlFilters addObject:filter];
}

- (void)clearUrlFilter{
    [_urlFilters removeAllObjects];
}

- (void)addCacheDirPathFilter:(id<HeroinCacheDirPathFilterProtocol>)filter{
    [_cacheDirPathFilters addObject:filter];
}

- (void)clearCacheDirPathFilter{
    [_cacheDirPathFilters removeAllObjects];
}

- (NSArray<id<HeroinUrlFilterProtocol>> *)urlFilters{
    return [_urlFilters copy];
}

- (NSArray<id<HeroinCacheDirPathFilterProtocol>> *)cacheDirPathFilters{
    return [_cacheDirPathFilters copy];
}

#pragma mark - NSObject

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@: %p>{ baseURL: %@ } { cdnURL: %@ }", NSStringFromClass([self class]), self, self.baseUrl, self.cdnUrl];
}

@end
