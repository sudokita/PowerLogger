//
//  NetworkLogger.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/13/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import "NetworkLogger.h"

@implementation NetworkLogger
static NetworkLogger * _me = nil;

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




@end
