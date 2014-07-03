//
//  GameUtilities.m
//  iReporter
//
//  Created by Ben & Sara Parry on 27/06/2014.
//  Copyright (c) 2014 Marin Todorov. All rights reserved.
//

#import "GameUtilities.h"

@implementation GameUtilities
-(NSMutableArray *) getRandomIntList:(NSNumber *)M : (NSNumber *)N{
#define M 10
#define N 100
    
    unsigned char is_used[N] = { 0 }; /* flags */
    int in, im;
    NSMutableArray *result = [NSMutableArray array];
    
    im = 0;
    
    for (in = N - M; in < N && im < M; ++in) {
        int r = rand() % (in + 1); /* generate a random number 'r' */
        
        if (is_used[r])
        /* we already have 'r' */
            r = in; /* use 'in' instead of the generated number */
        
        assert(!is_used[r]);
        //vektor[im++] = r + 1; /* +1 since your range begins from 1 */
        [result addObject:[NSNumber numberWithInt:r+1]];
        
        is_used[r] = 1;
    }
    
    assert(im == M);
    return result;
}

@end
