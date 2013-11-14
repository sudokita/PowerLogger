//
//  SleepMessageReciever.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 10/29/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import "SleepMessageReciever.h"
#import "FileLogger.h"

@implementation SleepMessageReciever



- (void)receiveSleepMessage:(NSNotification *)message
{
    NSLog(@"received Sleep Message: %@", [message name]);
    [[FileLogger defaultLogger] logEvent:@"SLEEP"];
}

- (void)receiveWakeMessage:(NSNotification *)message
{
    NSLog(@"Reveived Wake Message: %@", [message name]);
    [[FileLogger defaultLogger] logEvent:@"AWAKE"];
}

- (void)initializeObservers
{
     [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveSleepMessage:) name: NSWorkspaceWillSleepNotification object:nil];
    NSLog(@"registered sleeper agent");
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveWakeMessage:) name: NSWorkspaceDidWakeNotification object:nil];
    NSLog(@"registered waker agent");
}

@end
