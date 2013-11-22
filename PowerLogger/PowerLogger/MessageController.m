//
//  MessageController.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/21/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import "MessageController.h"

@implementation MessageController

- (id)init
{
    self = [super init];
    if (self) {
        [self setSmr:[[SleepMessageReciever alloc] init]];
        [self setSdmr:[[ShutdownMessageReceiver alloc] init]];
        [self setSsmr:[[ScreenSleepMessageReceiver alloc] init]];
    }
    return self;
}

- (void)registerMessageObservers
{
    [[self smr] initializeObservers];
    [[self sdmr] initializeObservers];
    [[self ssmr] initializeObservers];
   
}

@end
