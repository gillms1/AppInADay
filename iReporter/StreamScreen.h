//
//  StreamScreen.h
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoView.h"

@interface StreamScreen : UIViewController <PhotoViewDelegate,UIAlertViewDelegate> {
    IBOutlet UIBarButtonItem* btnCompose;
    IBOutlet UIBarButtonItem* btnRefresh;
    IBOutlet UIScrollView* listView;
    IBOutlet UILabel* scoreLabel;
    IBOutlet UILabel* timerLabel;
    IBOutlet UIButton* quitButton;
    
    int count;
    NSInteger seconds;
    NSTimer *timer;
}
@property (assign, nonatomic) bool* startTimer;
@property (strong, nonatomic) NSNumber* score;
@property (strong, nonatomic) NSNumber* seconds;
@property (strong, nonatomic) NSString* ImageNumber;
@property (strong, nonatomic) PhotoView* CurrentPhotoView;

//refresh the photo stream
-(IBAction)btnRefreshTapped;
-(IBAction)quitGame;


//set up game
-(void) setupGame;


@end
