//
//  main.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 10/29/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageController.h"
#import "State.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
       MessageController * controller = [[MessageController alloc] init];
        
        [controller registerMessageObservers];
        [[NSRunLoop currentRunLoop] run];
        
      // NSString * mem = [[State defaultState] getCurrentMemoryUsage];
        
      //  NSLog(@"Current memory: %@", mem);
    }
    return 0;
}

