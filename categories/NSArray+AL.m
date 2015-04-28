//
//  NSArray+AL.m
//  nebulist
//
//  Created by Andrew Lister on 3/16/13.
//  Copyright (c) 2013 plasticcube. All rights reserved.
//

#import "NSArray+AL.h"

@implementation NSArray (AL)


- (NSArray *)map:(MapBlock)mapBlock {
    
    NSAssert(mapBlock, @"Cannot have nil block");
    
    if (mapBlock) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
        
        for (id object in self) {
            
            id res = mapBlock(object);
            
            if (res) {
                [array addObject:res];
            }
            else {
                NSAssert(res, @"Not handling nil in map.");
            }
        }
        
        return array.copy;
    }
    
    return nil;
}


- (NSArray *)mapRemoveNils:(MapBlock)mapBlock {
    
    NSAssert(mapBlock, @"Cannot have nil block");
    
    if (mapBlock) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
        
        for (id object in self) {
            
            id res = mapBlock(object);
            
            if (res) {
                [array addObject:res];
            }
        }
        
        return array.copy;
    }
    
    return nil;
}


- (NSArray *)concurrentMap:(MapBlock)mapBlock
{    
    NSAssert(mapBlock, @"Cannot have nil block");
    
    if (mapBlock) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
        
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        NSLock *arrayLock = [[NSLock alloc] init];
        
        for(id object in self){
            
            dispatch_group_async(group, queue, ^{
                id res = mapBlock(object);
                
                if (res) {
                    [arrayLock lock];
                    [array addObject:res];
                    [arrayLock unlock];
                }
                else {
                    NSAssert(res, @"Not handling nil in map.");
                }
            });
        }
        
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        return array.copy;
    }
    
    return nil;
}


- (NSArray *)filter:(FilterBlock)filterBlock
{
    NSAssert(filterBlock, @"Cannot have nil block");
    
    if (filterBlock) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
        
        for (id object in self) {
            if (filterBlock(object)) {
                [array addObject:object];
            }
        }
        
        return array.copy;
    }

    return nil;
}


@end
