//
//  State.h
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/21/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface State : NSObject

@property(strong, nonatomic) NSString * macaddress;
@property(strong, nonatomic) NSString * computerState;
@property(strong, nonatomic) NSString * displayState;


+ (instancetype)defaultState;
- (NSString *)getMacaddress;

- (NSString *)currentTime;

@end
