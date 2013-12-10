//
//  SleepMessageReciever.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 10/29/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import "SleepMessageReciever.h"
#import "FileLogger.h"
#import "State.h"
#import "NetworkLogger.h"

@implementation SleepMessageReciever

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)receiveSleepMessage:(NSNotification *)message
{
    NSString * time = [[State defaultState] currentTime];
    NSString * state = @"SLEEP";
    NSString * transition = [[NetworkLogger defaultLogger] transitionMessageWithCurrentState:[[State defaultState] computerState]AndTransitionState: state];
    [[State defaultState] setComputerState:state];
    
    [[NetworkLogger defaultLogger] logToServerTime:time State:state Transition:transition];
    
}

- (void)receiveWakeMessage:(NSNotification *)message
{
    NSString * time = [[State defaultState] currentTime];
    NSString * state = @"WAKE";
    NSString * transition = [[NetworkLogger defaultLogger] transitionMessageWithCurrentState:[[State defaultState] computerState]AndTransitionState: state];
    [[State defaultState] setComputerState:state];
    [[NetworkLogger defaultLogger] logToServerTime:time State:state Transition:transition];
}

- (void)initializeObservers
{
     [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveSleepMessage:) name: NSWorkspaceWillSleepNotification object:nil];
    NSLog(@"registered sleeper agent");
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveWakeMessage:) name: NSWorkspaceDidWakeNotification object:nil];
    NSLog(@"registered waker agent");
}

@end
