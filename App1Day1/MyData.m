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
@synthesize imageGuessed;
@synthesize imageGuessedCorrectly;


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


-(void) score: (NSString*)imageNumber withAnswer: (bool)isCorrect{
    if (imageGuessed == nil){
        imageGuessed = [[NSMutableDictionary alloc]init];
        imageGuessedCorrectly = [[NSMutableDictionary alloc]init];

    }
    
     if ([imageGuessed objectForKey:imageNumber]==nil){
        if (isCorrect == YES){
            myCount++;
        }else{
            myCount--;
        }
        [imageGuessed setObject:[NSNumber numberWithBool:isCorrect] forKey: imageNumber];
        [imageGuessedCorrectly setObject:[NSNumber numberWithBool:isCorrect] forKey: imageNumber];
    }

}


/*
-(void) initialiseGuessesAndScores{
    imageGuessed = [NSMutableArray array];
    imageGuessedCorrectly =[NSMutableArray array];
    for (int i = 0; i < 10; i++){
        [imageGuessed arrayByAddingObject:[NSNumber numberWithBool:NO]];
        [imageGuessedCorrectly arrayByAddingObject:[NSNumber numberWithBool:NO]];
       
    }
}




-(void) score: (int)imageNumber withAnswer: (bool)isCorrect{
     if (isCorrect == YES){
        if([[imageGuessed objectAtIndex:imageNumber] boolValue]==NO)
        {
            myCount ++;
            [imageGuessedCorrectly replaceObjectAtIndex:imageNumber withObject:[NSNumber numberWithBool:YES]] ;
        }
    }else{
        if([[imageGuessed objectAtIndex:imageNumber] boolValue]==NO)
        {
            myCount --;
            [imageGuessedCorrectly replaceObjectAtIndex:imageNumber withObject:[NSNumber numberWithBool:NO]] ;
        }
    }
    [imageGuessed replaceObjectAtIndex:imageNumber withObject:[NSNumber numberWithBool:YES]];
}
*/



@end

