//
//  StreamPhotoScreen.m
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "StreamPhotoScreen.h"
#import "API.h"


@interface StreamPhotoScreen(){
    NSArray *_pickerData;

}
@end

@implementation StreamPhotoScreen

@synthesize IdPhoto;
@synthesize location;

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
	//load the big size photo
	NSURL* imageURL = [api urlForImageWithId:IdPhoto isThumb:NO];
	[photoView setImageWithURL: imageURL];
    
    //add the location selector
    _pickerData = [[NSArray alloc]initWithObjects:@"Ambleside",
                   @"Bala",@"Odney",@"Ambleside",@"JL Victoria", nil];
    
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    correctAnswerLabel.hidden = YES;
    incorrectAnswerLabel.hidden = YES;

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

    if ([location isEqualToString:_pickerData[row]]){
        correctAnswerLabel.hidden = NO;
        
    }else{
        incorrectAnswerLabel.hidden = NO;
        incorrectAnswerLabel.text = @"The photos is from %d",_pickerData[row];
    }
    
    
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerData objectAtIndex:row];
}


@end




