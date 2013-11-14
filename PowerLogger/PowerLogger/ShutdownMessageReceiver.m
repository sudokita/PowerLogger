//
//  ShutdownMessageReceiver.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/12/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import "ShutdownMessageReceiver.h"
#import <AppKit/AppKit.h>

#import "FileLogger.h"

@implementation ShutdownMessageReceiver 

- (void)receiveShutDown:(NSNotification *)message
{
    NSLog(@"Retrieved Shutdown message: %@", [message name]);
    [[FileLogger defaultLogger] logEvent:@"Shutdown"];
}

- (void)initializeObservers
{
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(receiveShutDown:) name: NSWorkspaceWillPowerOffNotification object:nil];
    NSLog(@"registered shutdown agent");
    
}


@end
