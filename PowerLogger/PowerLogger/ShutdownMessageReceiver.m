//
//  ShutdownMessageReceiver.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/12/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import "ShutdownMessageReceiver.h"
#import <AppKit/AppKit.h>
#import "State.h"
#import "NetworkLogger.h"

@implementation ShutdownMessageReceiver 

- (void)receiveShutDown:(NSNotification *)message
{
    NSString * time = [[State defaultState] currentTime];
    NSString * state = @"SHUTDOWN";
    NSString * transition = [[NetworkLogger defaultLogger] transitionMessageWithCurrentState:[[State defaultState] computerState]AndTransitionState: state];
    [[State defaultState] setComputerState:state];
    [[NetworkLogger defaultLogger] logToServerTime:time State:state Transition:transition];
}

- (void)initializeObservers
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveShutDown:) name: NSWorkspaceWillPowerOffNotification object:nil];
    NSLog(@"registered shutdown agent");
    
}


@end
