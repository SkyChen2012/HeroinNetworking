//
//  HeroinNetworking.h
//  HeroinNetWorking
//
//  Created by Benson on 2018/8/15.
//  Copyright © 2018年 Benson. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef _HeroinNETWORK_
#define _HeroinNETWORK_

#if __has_include(<HeroinNetwork/HeroinNetwork.h>)

FOUNDATION_EXPORT double HeroinNetworkVersionNumber;
FOUNDATION_EXPORT const unsigned char HeroinNetworkVersionString[];

#import <HeroinNetwork/HeroinRequest.h>
#import <HeroinNetwork/HeroinBaseRequest.h>
#import <HeroinNetwork/HeroinNetworkAgent.h>
#import <HeroinNetwork/HeroinBatchRequest.h>
#import <HeroinNetwork/HeroinBatchRequestAgent.h>
#import <HeroinNetwork/HeroinChainRequest.h>
#import <HeroinNetwork/HeroinChainRequestAgent.h>
#import <HeroinNetwork/HeroinNetworkConfig.h>

#else

#import "HeroinRequest.h"
#import "HeroinBaseRequest.h"
#import "HeroinNetworkAgent.h"
#import "HeroinBatchRequest.h"
#import "HeroinBatchRequestAgent.h"
#import "HeroinChainRequest.h"
#import "HeroinChainRequestAgent.h"
#import "HeroinNetworkConfig.h"

#endif /* __has_include */

#endif /* _HeroinNETWORK_ */

