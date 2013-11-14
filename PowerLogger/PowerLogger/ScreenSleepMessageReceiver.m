//
//  ScreenSleepMessageReceiver.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/13/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "ScreenSleepMessageReceiver.h"

@implementation ScreenSleepMessageReceiver

- (void)receiveScreenSleep:(NSNotification *)message
{
    NSLog(@"Retrieved Screen sleep message: %@", [message name]);
    
}

- (void)receiveScreenWake: (NSNotification *)message
{
    NSLog(@"Retrieved Screen wake message: %@", [message name]);
}

- (void)initializeObservers
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveScreenSleep:) name: NSWorkspaceScreensDidSleepNotification object:nil];
    NSLog(@"registered screen sleep agent");
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveScreenWake:) name:NSWorkspaceScreensDidWakeNotification object:nil];
    NSLog(@"registered screen wake agent");
}

@end
