//
//  StreamPhotoScreen.h
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StreamPhotoScreen : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
{
    //just the photo view and the photo title
    IBOutlet UIImageView* photoView;
    IBOutlet UILabel* lblTitle;
    IBOutlet UILabel *incorrectAnswerLabel;
    IBOutlet UIButton* selectButton;
    IBOutlet UILabel* timerLabel;
    
    NSTimer *timer;
    }
@property (strong, nonatomic) NSString* ImageNumber;
@property (strong, nonatomic) NSNumber* IdPhoto;
@property (strong, nonatomic) NSString* location;
@property (strong, nonatomic) NSNumber* seconds;
@property (strong, nonatomic) NSString* selectedLocation;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *selectonLabel;
- (IBAction)submitAnswer:(id)sender;
- (IBAction)back:(id)sender;



@end



