//
//  NetworkLogger.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/13/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import "NetworkLogger.h"
#import "State.h"

@implementation NetworkLogger
static NetworkLogger * _me = nil;
static NSString * server = @"http://catmouse.calit2.uci.edu/power_logger/";

+ (instancetype)defaultLogger
{
    @synchronized(self)
    {
        if (!_me) {
            _me = [[self alloc] init];
        }
        return _me;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setManager:[[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:server]]];
    }
    return self;
}

- (NSString *)transitionMessageWithCurrentState: (NSString *)currentState
                             AndTransitionState: (NSString *)transitionState
{
    NSString * transition = [NSString stringWithFormat:@"Transition from: %@ to: %@", currentState, transitionState];
    
    return transition;
}

- (void)logToServerTime:(NSString *)time
                  State:(NSString *)state
             Transition:(NSString *)transition
{
    NSDictionary * data = @{@"time": time,
                            @"state": state,
                            @"transition" : transition,
                            @"macaddress" : [[State defaultState]getMacaddress]
                            };
    [[self manager] POST:@"log.php" parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


@end
