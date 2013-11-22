//
//  MessageController.h
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/21/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SleepMessageReciever.h"
#import "ShutdownMessageReceiver.h"
#import "ScreenSleepMessageReceiver.h"

@interface MessageController : NSObject
@property (strong, nonatomic) SleepMessageReciever * smr;
@property (strong, nonatomic) ShutdownMessageReceiver * sdmr;
@property(strong, nonatomic) ScreenSleepMessageReceiver * ssmr;

- (void)registerMessageObservers;

@end
