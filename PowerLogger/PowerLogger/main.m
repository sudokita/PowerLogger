//
//  main.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 10/29/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SleepMessageReciever.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        SleepMessageReciever * smr = [[SleepMessageReciever alloc] init];
        
        [smr initializeObservers];
        
        while (TRUE) {
            
        }
        
        NSLog(@"Went to sleep");
        // insert code here...
       // NSLog(@"Hello, World!");
        
    }
    return 0;
}

