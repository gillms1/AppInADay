//
//  MyData.h
//  App1Day1
//
//  Created by Manprit Gill on 03/07/2014.
//  Copyright (c) 2014 Marin Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyData : NSObject

+(MyData*) sharedInstance;

@property(nonatomic, assign) int myCount;



@end
