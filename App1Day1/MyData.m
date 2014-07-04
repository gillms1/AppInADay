//
//  MyData.m
//  App1Day1
//
//  Created by Manprit Gill on 03/07/2014.
//  Copyright (c) 2014 Marin Todorov. All rights reserved.
//

#import "MyData.h"

@implementation MyData

@synthesize myCount;

+(MyData*) sharedInstance {
    
    static MyData *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc]init];
    });
    
    return instance;
    
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.myCount = 0;
    }
    return self;
}


@end

