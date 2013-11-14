//
//  FileLogger.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 10/30/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import "FileLogger.h"

@implementation FileLogger

static NSString * path = @"Users/taylor/Documents/Logs/power_logger.txt";
static FileLogger * _me = nil;

+ (instancetype)defaultLogger
{
    @synchronized(self)
    {
        if (!_me) {
            _me = [[self alloc] init];
        }
        return _me;
    }
}


- (id)init
{
    self = [super init];
    if (self) {
        [self setFormatter:[[NSDateFormatter alloc] init]];
        
        [[self formatter] setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    }
    return self;
}

- (void)logEvent:(NSString *)eventData
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
        [[NSFileManager defaultManager] createFileAtPath:path
                                                contents:nil
                                              attributes:nil];
    }
    
    NSDate * current = [NSDate date];
    NSString * dateString = [[self formatter] stringFromDate:current];
    NSString * dataPoint = [NSString stringWithFormat:@"%@\t%@\n", dateString, eventData];
    [dataPoint writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
