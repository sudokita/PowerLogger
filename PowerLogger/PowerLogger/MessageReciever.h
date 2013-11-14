//
//  MessageReciever.h
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/12/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageReciever <NSObject>

- (void)initializeObservers;

@end
