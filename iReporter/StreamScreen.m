//
//  StreamScreen.m
//  iReporter
//
//  Created by Marin Todorov on 10/02/2012.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import "StreamScreen.h"
#import "API.h"
#import "PhotoView.h"
#import "StreamPhotoScreen.h"
#import "MyData.h"

@interface StreamScreen(private)


@property(strong, nonatomic) MyData *myData;
-(void)refreshStream;
-(void)showStream:(NSArray*)stream;
@end

@implementation StreamScreen

@synthesize score;
@synthesize ImageNumber;
@synthesize CurrentPhotoView;
@synthesize startTimer;

#pragma mark - View lifecycle

-(void)viewDidLoad {
 
    [super viewDidLoad];
    self.navigationItem.title = @"Partner Place Puzzle";
    self.navigationItem.rightBarButtonItem = btnCompose;
    self.navigationItem.leftBarButtonItem = btnRefresh;
	//show the photo stream
    //self.myData = [[MyData alloc]init];
    //[MyData init];
    
    int *scoreInt = [scoreLabel.text intValue];
    scoreInt++;
    

    //NSString *newCountString = [scoreNumber stringValue];
    [MyData sharedInstance].myCount=0;
    
    scoreLabel.text = [NSString stringWithFormat:@"%i", [MyData sharedInstance].myCount];
    scoreLabel.textColor = [UIColor greenColor];
    
    //add to include status bar to avoid overlapping
    UIView *addStatusBar = [[UIView alloc] init];
    addStatusBar.frame = CGRectMake(0, 0, 1024, 20);
    addStatusBar.backgroundColor = [UIColor whiteColor]; //change this to match your navigation bar
    [self.view addSubview:addStatusBar];
   
    
    /*MyData *myData = [MyData alloc];
    
    [myData init];
    int thiscount = [myData.myCount intValue];
    
    NSLog(@"%d",  thiscount);*/
    [self setupGame];
    startTimer = YES;
    
   
}
-(void) viewWillAppear:(BOOL)animated{
  int temp = [MyData sharedInstance].myCount;
    NSString*  tempS = [NSString stringWithFormat:@"%d", temp];
    scoreLabel.text = tempS;
    bool b1=[[MyData sharedInstance] imageWasGuessed:ImageNumber];
    bool b2 = [[MyData sharedInstance] imageWasGuessedCorrectly:ImageNumber];
    [CurrentPhotoView setBorder:b1 andGuessedCorrectly:b2];
    if([[MyData sharedInstance] isGameOver]==YES){
   
        //we don't want a pop up from the timer too..
        if (timer != nil) {
        [timer invalidate];
        }
        
        NSString *scoreDesc = [self scoreDesc:(int)[MyData sharedInstance].myCount];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Game Over!"
        message:[NSString stringWithFormat: @"You scored %i points %@\n",[MyData sharedInstance].myCount,scoreDesc]
                                delegate:self  cancelButtonTitle:@"Play Again" otherButtonTitles:@"Quit",nil];
        [alert show];

        
        
        }
}
-(void) viewDidAppear:(BOOL)animated{
    if (startTimer){
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(subtractTime) userInfo:nil repeats:YES];
        startTimer = NO;
        
    }


}

-(void) setupGame{
    //show label
    [[MyData sharedInstance] clearScores];
    //get new images
    [self refreshStream];
    //reset score
    scoreLabel.text = 0;
    seconds = 90;
    //set up timer label
    timerLabel.text =[NSString stringWithFormat:@"%i",seconds];
    //start the timer
    //timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(subtractTime) userInfo:nil repeats:YES];
}

-(void) subtractTime{
    seconds --;
    timerLabel.text =[NSString stringWithFormat:@"%i",seconds];
    if (seconds ==0){
        [timer invalidate];
        
        NSString *scoreDesc = [self scoreDesc:(int)[MyData sharedInstance].myCount];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Time is up!"
                                                        message:[NSString stringWithFormat: @"You scored %i points %@\n",[MyData sharedInstance].myCount,scoreDesc]
    delegate:self
    cancelButtonTitle:@"Play Again"
    otherButtonTitles:@"Quit",nil];
        [alert show];
       
    }
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==[alertView cancelButtonIndex]){
        NSLog(@"Button %i was clicked",buttonIndex );
         [self setupGame];
        //timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(subtractTime) userInfo:nil repeats:YES];
        startTimer = YES;
    
    }else{
        [self quit];
    }
   
}
-(NSString*)scoreDesc:(int) score{
    NSString *msgText;
    switch( [MyData sharedInstance].myCount ){
        case 0:msgText=@"Try again?";break;
        case 1:msgText=@"Try again?";break;
        case 2:msgText=@"Try again?";break;
        case 3:msgText=@"OK";break;
        case 4:msgText=@"Nice try";break;
        case 5:msgText=@"Not bad";break;
        case 6:msgText=@"Great!";break;
        case 7:msgText=@"Nice job!";break;
        case 8:msgText=@"Awesome!";break;
        case 9:msgText=@"Fantastic!";break;
        case 10:msgText=@"Perfect!";break;

    }
    return msgText;
    
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)btnRefreshTapped {
	[self refreshStream];
}

-(void)refreshStream {
    //just call the "stream" command from the web API
    [[API sharedInstance] commandWithParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"stream", @"command", nil] onCompletion:^(NSDictionary *json) {
		//got stream
		[self showStream:[json objectForKey:@"result"]];
	}];
}

-(void)showStream:(NSArray*)stream {
    
    stream =[self filterArray:stream];
    
    // 1 remove old photos
    for (UIView* view in listView.subviews) {
        [view removeFromSuperview];
    }
    // 2 add new photo views
    for (int i=0;i<[stream count];i++) {
        NSDictionary* photo = [stream objectAtIndex:i];
        PhotoView* photoView = [[PhotoView alloc] initWithIndex:i andData:photo];
        photoView.delegate = self;
        [listView addSubview: photoView];
    }    
    // 3 update scroll list's height
    int listHeight = ([stream count]/3 + 1)*(kThumbSide+kPadding);
    [listView setContentSize:CGSizeMake(320, listHeight)];
    [listView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
}

-(NSArray*)filterArray:(NSArray*)arr
{
    NSMutableArray *filteredImages = [[NSMutableArray alloc]init];
    NSMutableArray *allImagesArray = [[NSMutableArray alloc]initWithArray:arr];
    
    while ([allImagesArray count]>0 && [filteredImages count]<10) {
        //Ben 05.07.2014 Remove hang on display of random photos - The array starts at 0 , not 1
        NSInteger index = [self getRandomNumberBetween:0 maxNumber:[allImagesArray count]-1];

        [filteredImages addObject:[allImagesArray objectAtIndex:index]];
        [allImagesArray removeObjectAtIndex:index];
    }
    
    return filteredImages;
}

- (NSInteger)getRandomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random() % (max - min + 1);
}

-(void)didSelectPhoto:(PhotoView*)sender {
    //photo selected - show it full screen
    CurrentPhotoView = sender;
    ImageNumber = [sender ImageNumber];
    [self performSegueWithIdentifier:@"ShowPhoto" sender:[NSNumber numberWithInt:sender.tag]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"ShowPhoto" compare: segue.identifier]==NSOrderedSame) {
        StreamPhotoScreen* streamPhotoScreen = segue.destinationViewController;
        streamPhotoScreen.IdPhoto = sender;
        streamPhotoScreen.ImageNumber =ImageNumber;
        streamPhotoScreen.seconds = [NSNumber numberWithInt:seconds];
      }
}
-(IBAction)quitGame{
    [self quit];


}
-(void) quit{
    if (timer != nil){
        [timer invalidate];
    }
    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil];
    
}

@end
