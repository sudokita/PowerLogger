//
//  NetworkLogger.h
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/13/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface NetworkLogger : NSObject

@property(strong, nonatomic) AFHTTPRequestOperationManager * manager;

+ (instancetype)defaultLogger;
- (NSString *)transitionMessageWithCurrentState: (NSString *)currentState
                             AndTransitionState: (NSString *)transitionState;
- (void)logToServerTime: (NSString *)time State: (NSString *)state Transition: (NSString *)transition;

@end
