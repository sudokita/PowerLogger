//
//  FileLogger.h
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 10/30/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileLogger : NSObject
@property(strong, nonatomic) NSDateFormatter * formatter;

+ (instancetype)defaultLogger;

- (void)logEvent: (NSString *)eventData;

@end
