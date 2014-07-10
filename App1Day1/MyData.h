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

//Only increment the score if the image has not been guessed before
//@property(nonatomic, assign) NSMutableArray* imageGuessed;
@property(nonatomic, strong) NSMutableDictionary* imageGuessed;

//record if the image was guessed correctly;
//@property(nonatomic, assign) NSMutableArray* imageGuessedCorrectly;
@property(nonatomic, strong) NSMutableDictionary* imageGuessedCorrectly;



//-(void) initialiseGuessesAndScores;
-(void) score: (NSString*)imageNumber withAnswer: (bool)isCorrect;
-(bool) imageWasGuessed : (NSString*)imageNumber;
-(bool) imageWasGuessedCorrectly : (NSString*)imageNumber;
-(bool) isGameOver;
-(void) clearScores;
@end
