//
//  SleepMessageReciever.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 10/29/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import "SleepMessageReciever.h"

@implementation SleepMessageReciever

- (id)init
{
    self = [super init];
    if (self) {
        [self setAsleep:FALSE];
    }
    return self;
}

- (void)receiveSleepMessage:(NSNotification *)message
{
    NSLog(@"received Sleep Message: %@", [message name]);
    [self setAsleep:TRUE];
}

- (void)receiveWakeMessage:(NSNotification *)message
{
    NSLog(@"Reveived Wake Message: %@", [message name]);
    [self setAsleep:FALSE];
}

- (void)initializeObservers
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveSleepMessage:) name: NSWorkspaceWillSleepNotification object:NULL];
    NSLog(@"registered sleeper agent");
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveWakeMessage:) name: NSWorkspaceDidWakeNotification object:NULL];
    NSLog(@"registered waker agent");
}

- (void)awakeFromNib
{
    [self initializeObservers];
}

@end
