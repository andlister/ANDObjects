//
//  NSArray+AL.h
//
//  Created by Andrew Lister on 3/16/13.
//  Copyright (c) 2013 plasticcube. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^MapBlock)(id object);
typedef BOOL (^FilterBlock)(id object);


@interface NSArray (AL)

- (NSArray *)map:(MapBlock)mapBlock;
- (NSArray *)mapRemoveNils:(MapBlock)mapBlock;
- (NSArray *)filter:(FilterBlock)filterBlock;
- (NSArray *)concurrentMap:(MapBlock)mapBlock;


@end
