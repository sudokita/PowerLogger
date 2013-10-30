//
//  SleepMessageReciever.h
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 10/29/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

// References information and method from:
// https://developer.apple.com/library/mac/qa/qa1340/_index.html
// https://developer.apple.com/library/mac/documentation/macosx/conceptual/bpsystemstartup/Chapters/CreatingLaunchdJobs.html

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface SleepMessageReciever : NSObject
@property(atomic, getter = isAsleep) BOOL asleep;

- (void)receiveSleepMessage: (NSNotification *)message;
- (void)receiveWakeMessage: (NSNotification *)message;
- (void)initializeObservers;

@end
