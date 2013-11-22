//
//  ScreenSleepMessageReceiver.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/13/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "ScreenSleepMessageReceiver.h"
#import "State.h"
#import "NetworkLogger.h"

@implementation ScreenSleepMessageReceiver

- (void)receiveScreenSleep:(NSNotification *)message
{
    NSString * time = [[State defaultState] currentTime];
    NSString * state = @"DISPLAY_SLEEP";
    NSString * transition = [[NetworkLogger defaultLogger] transitionMessageWithCurrentState:[[State defaultState] displayState]AndTransitionState: state];
    [[State defaultState] setDisplayState:state];
    [[NetworkLogger defaultLogger] logToServerTime:time State:state Transition:transition];
    
}

- (void)receiveScreenWake: (NSNotification *)message
{
    NSString * time = [[State defaultState] currentTime];
    NSString * state = @"DISPLAY_WAKE";
    NSString * transition = [[NetworkLogger defaultLogger] transitionMessageWithCurrentState:[[State defaultState] displayState]AndTransitionState: state];
    [[State defaultState] setDisplayState:state];
    [[NetworkLogger defaultLogger] logToServerTime:time State:state Transition:transition];
}

- (void)initializeObservers
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveScreenSleep:) name: NSWorkspaceScreensDidSleepNotification object:nil];
    NSLog(@"registered screen sleep agent");
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveScreenWake:) name:NSWorkspaceScreensDidWakeNotification object:nil];
    NSLog(@"registered screen wake agent");
}

@end
