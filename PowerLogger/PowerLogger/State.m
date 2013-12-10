//
//  State.m
//  PowerLogger
//
//  Created by Taylor Kisor-Smith on 11/21/13.
//  Copyright (c) 2013 Taylor Kisor-Smith. All rights reserved.
//

#import "State.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <mach/host_info.h>
#import <mach/mach_host.h>
#import <mach/task_info.h>
#import <mach/task.h>

@implementation State
static State * _me = nil;

+ (instancetype)defaultState
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
        [self setComputerState:@"WAKE"];
        [self setDisplayState:@"DISPLAY_WAKE"];
    }
    return self;
}

- (NSDictionary *)getCurrentMemoryUsage
{
    //double unit = 1024 * 1024;
    
    int mib[6];
    mib[0] = CTL_HW;
    mib[1] = HW_PAGESIZE;
    
    int pagesize;
    size_t length;
    length = sizeof (pagesize);
    if (sysctl (mib, 2, &pagesize, &length, NULL, 0) < 0)
    {
        fprintf (stderr, "getting page size");
    }
    
    mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
    
    vm_statistics_data_t vmstat;
    if (host_statistics (mach_host_self (), HOST_VM_INFO, (host_info_t) &vmstat, &count) != KERN_SUCCESS)
    {
        fprintf (stderr, "Failed to get VM statistics.");
    }
    
    double total = vmstat.wire_count + vmstat.active_count + vmstat.inactive_count + vmstat.free_count;
    double total_used = vmstat.wire_count + vmstat.active_count + vmstat.inactive_count;
    double wired = vmstat.wire_count; /// total;
    double active = vmstat.active_count; // total;
    double inactive = vmstat.inactive_count; // total;
    double free = vmstat.free_count; // total;
    
    NSLog(@"Total: %f\tWired: %f\tActive: %f\tInactive: %f\tFree: %f",total, wired, active, inactive, free);
    
    
    task_basic_info_64_data_t info;
    unsigned size = sizeof (info);
    task_info (mach_task_self (), TASK_BASIC_INFO_64, (task_info_t) &info, &size);
    
    NSDictionary * memoryData = @{
                                  @"total"      : [self convertToMB:total pagesize:pagesize],
                                  @"total_used" : [self convertToMB:total_used pagesize:pagesize],
                                  @"wired"      : [self convertToMB:wired pagesize:pagesize],
                                  @"active"     : [self convertToMB:active pagesize:pagesize],
                                  @"inactive"   : [self convertToMB:inactive pagesize:pagesize],
                                  @"free"       : [self convertToMB:free pagesize:pagesize]
                                };
    return memoryData;
  /*  NSLog(@"%@", memoryData);
    
    return [NSString stringWithFormat: @"% 3.1f MB\n% 3.1f MB\n% 3.1f MB", vmstat.free_count * pagesize / unit, (vmstat.free_count + vmstat.inactive_count) * pagesize / unit, info.resident_size / unit];*/
    
}

- (NSNumber *)convertToMB: (double)size pagesize:(double)pagesize
{
    double unit = 1024 * 1024;
    return [NSNumber numberWithDouble:(size * pagesize / unit)];
}

- (NSString *)getMacaddress
{
    if (!self.macaddress) {
        int                 mgmtInfoBase[6];
        char                *msgBuffer = NULL;
        size_t              length;
        unsigned char       macAddress[6];
        struct if_msghdr    *interfaceMsgStruct;
        struct sockaddr_dl  *socketStruct;
        NSString            *errorFlag = NULL;
        
        // Setup the management Information Base (mib)
        mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
        mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
        mgmtInfoBase[2] = 0;
        mgmtInfoBase[3] = AF_LINK;        // Request link layer information
        mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
        
        // With all configured interfaces requested, get handle index
        if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
            errorFlag = @"if_nametoindex failure";
        else
        {
            // Get the size of the data available (store in len)
            if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
                errorFlag = @"sysctl mgmtInfoBase failure";
            else
            {
                // Alloc memory based on above call
                if ((msgBuffer = malloc(length)) == NULL)
                    errorFlag = @"buffer allocation failure";
                else
                {
                    // Get system information, store in buffer
                    if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                        errorFlag = @"sysctl msgBuffer failure";
                }
            }
        }
        
        // Befor going any further...
        if (errorFlag != NULL)
        {
            NSLog(@"Error: %@", errorFlag);
            return errorFlag;
        }
        
        // Map msgbuffer to interface message structure
        interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
        
        // Map to link-level socket structure
        socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
        
        // Copy link layer address data in socket structure to an array
        memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
        
        // Read from char array into a string object, into traditional Mac address format
        NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", 
                                      macAddress[0], macAddress[1], macAddress[2], 
                                      macAddress[3], macAddress[4], macAddress[5]];
        NSLog(@"Mac Address: %@", macAddressString);
        
        // Release the buffer memory
        free(msgBuffer);
        
        [self setMacaddress:macAddressString];
        
    }
    return [self macaddress];
}

- (NSString *)currentTime
{
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    return dateString;
}

@end
