//
//  StreamPhotoScreen.m
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "StreamPhotoScreen.h"
#import "API.h"
#import "StreamScreen.h"
#import "MyData.h"


@interface StreamPhotoScreen(){
    NSArray *_pickerData;
    int currentScore;
}
@end

@implementation StreamPhotoScreen

@synthesize IdPhoto;
@synthesize location;
@synthesize selectedLocation;
@synthesize ImageNumber;

-(void)viewDidLoad {
	API* api = [API sharedInstance];
	//load the caption of the selected photo
	[api commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command", IdPhoto,@"IdPhoto", nil] onCompletion:^(NSDictionary *json) {
		//show the text in the label
		NSArray* list = [json objectForKey:@"result"];
		NSDictionary* photo = [list objectAtIndex:0];
		lblTitle.text = [photo objectForKey:@"title"];
        location =[photo objectForKey:@"title"];
	}];
    
    UIView *addStatusBar = [[UIView alloc] init];
    addStatusBar.frame = CGRectMake(0, 0, 1024, 20);
    addStatusBar.backgroundColor = [UIColor whiteColor]; //change this to match your navigation bar
    [self.view addSubview:addStatusBar];
    
	//load the big size photo
	NSURL* imageURL = [api urlForImageWithId:IdPhoto isThumb:NO];
	[photoView setImageWithURL: imageURL];
    
    //add the location selector
    _pickerData = [[NSArray alloc]initWithObjects:@"Ambleside",@"Bala",@"Bracknell Jubilee House",@"Bracknell Taylor House",@"Branch 615 Foregate St",
                   
                   @"Branch 833 Trinity Sq",@"Branch 834 Clifton",@"Brownsea",@"JL Stratford City",
                   
                   @"Leckford",    @"Odney",@"RDC Celestia",    @"RDC Leyland",@" Victoria",nil];
    
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    incorrectAnswerLabel.hidden = YES;
    
    //initialise selector with first element in case user presses select without first using the picker
    selectedLocation = [_pickerData objectAtIndex:0];

}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_pickerData count];
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    // [myTextField setText:[pickerArray objectAtIndex:row]];
    selectedLocation =_pickerData[row];
    
        //[self performSegueWithIdentifier:@"IncrementCount" sender:[NSNumber numberWithInt:pickerView.tag]];
    
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerData objectAtIndex:row];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"IncrementCount" compare: segue.identifier]==NSOrderedSame) {
        
        StreamScreen* streamScreen = segue.destinationViewController;
        
        //currentScore = currentScore + 1;
        streamScreen.score = [NSNumber numberWithInt:currentScore];
    }
    
}

- (IBAction)submitAnswer:(id)sender {
    
    if ([location isEqualToString:selectedLocation]){
        incorrectAnswerLabel.hidden = NO;
        incorrectAnswerLabel.text = @"Correct!";
        incorrectAnswerLabel.textColor = [UIColor greenColor];
        //[MyData sharedInstance].myCount++;
        [[MyData sharedInstance] score:ImageNumber withAnswer:[NSNumber numberWithBool:YES]];

    }else{
        incorrectAnswerLabel.hidden = NO;
        incorrectAnswerLabel.textColor = [UIColor redColor];
        incorrectAnswerLabel.text = [NSString stringWithFormat: @"The photo is from %@", location];
        
        if ([MyData sharedInstance].myCount > 0) {
            //[MyData sharedInstance].myCount--;
            [[MyData sharedInstance] score:ImageNumber withAnswer:[NSNumber numberWithBool:NO]];

        }
    }
    
    
}
- (IBAction)back:(id)sender{
    
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
    


}

@end




