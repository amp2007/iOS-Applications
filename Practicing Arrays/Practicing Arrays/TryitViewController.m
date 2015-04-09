//
//  TryitViewController.m
//  Practicing Arrays
//
//  Created by Software Development on 10/17/14.
//  Copyright (c) 2014 ___Allen Perry___. All rights reserved.
//

#import "TryitViewController.h"

@interface TryitViewController ()

@end

@implementation TryitViewController
@synthesize dragObject;
@synthesize touchOffset;
@synthesize homePosition;
@synthesize questionNum;
@synthesize l1;
@synthesize l2;
@synthesize l3;
@synthesize l4;
@synthesize correct;
@synthesize incorrect;
@synthesize score;

//Locates which label is being touched by the user
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.dragObject = nil;
    if ([touches count] == 1)
    {
        // one finger
        CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
        for (UILabel *iView in self.view.subviews)
        {
            if ([iView isMemberOfClass:[UILabel class]])
            {
                if (touchPoint.x > iView.frame.origin.x &&
                    touchPoint.x < iView.frame.origin.x + iView.frame.size.width &&
                    touchPoint.y > iView.frame.origin.y &&
                    touchPoint.y < iView.frame.origin.y + iView.frame.size.height)
                {
                    self.dragObject = iView;
                    self.touchOffset = CGPointMake(touchPoint.x - iView.frame.origin.x,
                                                   touchPoint.y - iView.frame.origin.y);
                    self.homePosition = CGPointMake(iView.frame.origin.x,
                                                    iView.frame.origin.y);
                    [self.view bringSubviewToFront:self.dragObject];
                }
            }
        }
    }
}

//Adjusts the label to follow the touch of the user
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    CGRect newDragObjectFrame = CGRectMake(touchPoint.x - touchOffset.x,
                                           touchPoint.y - touchOffset.y,
                                           self.dragObject.frame.size.width,
                                           self.dragObject.frame.size.height);
    self.dragObject.frame = newDragObjectFrame;
}

//Determines where the label is when user lifts finger
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    if (touchPoint.x > self.dropTarget.frame.origin.x &&
        touchPoint.x < self.dropTarget.frame.origin.x + self.dropTarget.frame.size.width &&
        touchPoint.y > self.dropTarget.frame.origin.y &&
        touchPoint.y < self.dropTarget.frame.origin.y + self.dropTarget.frame.size.height )
    {
        self.dropTarget.text = self.dragObject.text;
    }
    
    if (touchPoint.x > self.dropTarget2.frame.origin.x &&
        touchPoint.x < self.dropTarget2.frame.origin.x + self.dropTarget2.frame.size.width &&
        touchPoint.y > self.dropTarget2.frame.origin.y &&
        touchPoint.y < self.dropTarget2.frame.origin.y + self.dropTarget2.frame.size.height )
    {
        self.dropTarget2.text = self.dragObject.text;        
    }
    
    if (touchPoint.x > self.dropTarget3.frame.origin.x &&
        touchPoint.x < self.dropTarget3.frame.origin.x + self.dropTarget3.frame.size.width &&
        touchPoint.y > self.dropTarget3.frame.origin.y &&
        touchPoint.y < self.dropTarget3.frame.origin.y + self.dropTarget3.frame.size.height )
    {
        self.dropTarget3.text = self.dragObject.text;
    }
    
    if (touchPoint.x > self.dropTarget4.frame.origin.x &&
        touchPoint.x < self.dropTarget4.frame.origin.x + self.dropTarget4.frame.size.width &&
        touchPoint.y > self.dropTarget4.frame.origin.y &&
        touchPoint.y < self.dropTarget4.frame.origin.y + self.dropTarget4.frame.size.height )
    {
        self.dropTarget4.text = self.dragObject.text;
    }
    self.dragObject.frame = CGRectMake(self.homePosition.x, self.homePosition.y,
                                       self.dragObject.frame.size.width,
                                       self.dragObject.frame.size.height);
    self.dragObject = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Runs determineQuestion method to determine which question is displayed when view is loaded
//Creates the alerts for right and wrong answers submitted
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self determineQuestion];
    if(questionNum >= 0 && questionNum <= 3)
    {
        [self displayQuestionSet1];
    }
    else if(questionNum >= 4 && questionNum <= 7)
    {
        [self displayQuestionSet2];
    }
    else if(questionNum >= 8 && questionNum <= 13)
    {
        [self displayQuestionSet3];
    }
    else if(questionNum >= 14 && questionNum <= 19)
    {
        [self displayQuestionSet4];
    }
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"GameshowBellDing1" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    _correctAnswer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    if(error)
    {
        NSLog(@"Error in audioPlayer: %@",[error localizedDescription]);
    }
    else
    {
        [_correctAnswer prepareToPlay];
    }
    NSBundle *mainBundle2 = [NSBundle mainBundle];
    NSString *filePath2 = [mainBundle2 pathForResource:@"Buzzer1-2" ofType:@"mp3"];
    NSURL *url2 = [NSURL fileURLWithPath:filePath2];
    NSError *error2;
    _wrongAnswer = [[AVAudioPlayer alloc]initWithContentsOfURL:url2 error:&error2];
    if(error)
    {
        NSLog(@"Error in audioPlayer: %@",[error localizedDescription]);
    }
    else
    {
        [_wrongAnswer prepareToPlay];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Random number choosen between 0-19, used to determine question to display
-(void)determineQuestion
{
    questionNum = arc4random_uniform(20);
}

//First set of questions that is selected if random number generated is between 0-3
//Also hides or displays textfield drop targets depending on how many are needed for the question
-(void)displayQuestionSet1
{
    if(questionNum == 0)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt1Answers" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 1)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt2Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 2)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt3Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
        _dropTarget.hidden = true;
        _dropTarget3.hidden = true;
        _dropTarget4.hidden = true;
        _equalLabel.hidden = true;
    }
    else if(questionNum == 3)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt4Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
        _dropTarget.hidden = true;
        _dropTarget3.hidden = true;
        _dropTarget4.hidden = true;
        _equalLabel.hidden = true;
    }
}

//Second set of questions that is selected if random number generated is between 4-7
//Also hides or displays textfield drop targets depending on how many are needed for the question
-(void)displayQuestionSet2
{
    if(questionNum == 4)
    {
        _dropTarget.hidden = true;
        _dropTarget4.hidden = true;
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt5Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 5)
    {
        _dropTarget.hidden = true;
        _dropTarget4.hidden = true;
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt6Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 6)
    {
        _equalLabel.hidden = true;
        _dropTarget4.hidden = true;
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt7Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 7)
    {
        _equalLabel.hidden = true;
        _dropTarget4.hidden = true;
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt8Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
}

//Third set of questions that is selected if random number generated is between 8-13
//Also hides or displays textfield drop targets depending on how many are needed for the question
-(void)displayQuestionSet3
{
    if(questionNum == 8)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt9Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 9)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt10Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 10)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt18Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 11)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt11Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
        _dropTarget.hidden = true;
        _dropTarget3.hidden = true;
        _dropTarget4.hidden = true;
        _equalLabel.hidden = true;
    }
    else if(questionNum == 12)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt12Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
        _dropTarget.hidden = true;
        _dropTarget3.hidden = true;
        _dropTarget4.hidden = true;
        _equalLabel.hidden = true;
    }
    else if(questionNum == 13)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt19Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
        _dropTarget.hidden = true;
        _dropTarget3.hidden = true;
        _dropTarget4.hidden = true;
        _equalLabel.hidden = true;
    }
}

//Fourth set of questions that is selected if random number generated is between 14-19
//Also hides or displays textfield drop targets depending on how many are needed for the question
-(void)displayQuestionSet4
{
    if(questionNum == 14)
    {
        _dropTarget.hidden = true;
        _dropTarget4.hidden = true;
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt13Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 15)
    {
        _dropTarget.hidden = true;
        _dropTarget4.hidden = true;
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt14Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 16)
    {
        _dropTarget.hidden = true;
        _dropTarget4.hidden = true;
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt20Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 17)
    {
        _equalLabel.hidden = true;
        _dropTarget4.hidden = true;
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt15Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 18)
    {
        _equalLabel.hidden = true;
        _dropTarget4.hidden = true;
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt16Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
    else if(questionNum == 19)
    {
        _equalLabel.hidden = true;
        _dropTarget4.hidden = true;
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *answers = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TryIt17Answer" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [answers componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_labels count]; counter++)
        {
            dragObject = [_labels objectAtIndex: counter];
            dragObject.text = [NSString stringWithFormat:@" %@ ",[words objectAtIndex: count]];
            count++;
        }
    }
}



//Checks for the correct answer for the questions in the first set
-(void)determineCorrectAnswersForFirstSet
{
    //Depending on which question is displayed (based off of questionNum) the labels to check for answer are determined first
    if(questionNum == 0)
    {
        l1 = [_labels objectAtIndex:10];
        l2 = [_labels objectAtIndex:7];
        l3 = [_labels objectAtIndex:9];
        l4 = [_labels objectAtIndex:4];
        if ([_dropTarget.text isEqualToString: l1.text] && [_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text] && [_dropTarget4.text isEqualToString: l4.text] )
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 1)
    {
        l1 = [_labels objectAtIndex:8];
        l2 = [_labels objectAtIndex:1];
        l3 = [_labels objectAtIndex:4];
        l4 = [_labels objectAtIndex:3];
        if ([_dropTarget.text isEqualToString: l1.text] && [_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text] && [_dropTarget4.text isEqualToString: l4.text] )
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 2)
    {
        l1 = [_labels objectAtIndex:6];
        if ([_dropTarget2.text isEqualToString: l1.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 3)
    {
         l1 = [_labels objectAtIndex:10];
        if ([_dropTarget2.text isEqualToString: l1.text] )
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    
}

//Checks for the correct answer for the questions in the second set
-(void)determineCorrectAnswersForSecondSet
{
    //Depending on which question is displayed (based off of questionNum) the labels to check for answer are determined first
    if(questionNum == 4)
    {
        l1 = [_labels objectAtIndex:3];
        l2 = [_labels objectAtIndex:6];
        if ([_dropTarget2.text isEqualToString: l1.text] && [_dropTarget3.text isEqualToString: l2.text] )
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 5)
    {
        l2 = [_labels objectAtIndex:9];
        l3 = [_labels objectAtIndex:1];
        if ([_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 6)
    {
        l1 = [_labels objectAtIndex:4];
        l2 = [_labels objectAtIndex:1];
        l3 = [_labels objectAtIndex:8];
        if ([_dropTarget.text isEqualToString:l1.text] && [_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 7)
    {
        l1 = [_labels objectAtIndex:0];
        l2 = [_labels objectAtIndex:9];
        l3 = [_labels objectAtIndex:4];
        if ([_dropTarget.text isEqualToString:l1.text] && [_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
}

//Checks for the correct answer for the questions in the third set
-(void)determineCorrectAnswersForThirdSet
{
    //Depending on which question is displayed (based off of questionNum) the labels to check for answer are determined first
    if(questionNum == 8)
    {
        l1 = [_labels objectAtIndex:0];
        l2 = [_labels objectAtIndex:8];
        l3 = [_labels objectAtIndex:6];
        l4 = [_labels objectAtIndex:4];
        if ([_dropTarget.text isEqualToString: l1.text] && [_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text] && [_dropTarget4.text isEqualToString: l4.text] )
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 9)
    {
        l1 = [_labels objectAtIndex:10];
        l2 = [_labels objectAtIndex:6];
        l3 = [_labels objectAtIndex:2];
        l4 = [_labels objectAtIndex:0];
        if ([_dropTarget.text isEqualToString: l1.text] && [_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text] && [_dropTarget4.text isEqualToString: l4.text] )
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 10)
    {
        l1 = [_labels objectAtIndex:5];
        l2 = [_labels objectAtIndex:7];
        l3 = [_labels objectAtIndex:6];
        l4 = [_labels objectAtIndex:9];
        if ([_dropTarget.text isEqualToString: l1.text] && [_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text] && [_dropTarget4.text isEqualToString: l4.text] )
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 11)
    {
        l1 = [_labels objectAtIndex:9];
        if ([_dropTarget2.text isEqualToString: l1.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 12)
    {
        l1 = [_labels objectAtIndex:6];
        if ([_dropTarget2.text isEqualToString: l1.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 13)
    {
        l1 = [_labels objectAtIndex:5];
        if ([_dropTarget2.text isEqualToString: l1.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
}

//Checks for the correct answer for the questions in the fourth set
-(void)determineCorrectAnswersForFourthSet
{
    //Depending on which question is displayed (based off of questionNum) the labels to check for answer are determined first
    if(questionNum == 14)
    {
        l1 = [_labels objectAtIndex:1];
        l2 = [_labels objectAtIndex:5];
        if ([_dropTarget2.text isEqualToString: l1.text] && [_dropTarget3.text isEqualToString: l2.text] )
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 15)
    {
        l2 = [_labels objectAtIndex:6];
        l3 = [_labels objectAtIndex:2];
        if ([_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 16)
    {
        l2 = [_labels objectAtIndex:0];
        l3 = [_labels objectAtIndex:4];
        if ([_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 17)
    {
        l1 = [_labels objectAtIndex:2];
        l2 = [_labels objectAtIndex:6];
        l3 = [_labels objectAtIndex:10];
        if ([_dropTarget.text isEqualToString:l1.text] && [_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 18)
    {
        l1 = [_labels objectAtIndex:3];
        l2 = [_labels objectAtIndex:1];
        l3 = [_labels objectAtIndex:8];
        if ([_dropTarget.text isEqualToString:l1.text] && [_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
    else if(questionNum == 19)
    {
        l1 = [_labels objectAtIndex:7];
        l2 = [_labels objectAtIndex:9];
        l3 = [_labels objectAtIndex:0];
        if ([_dropTarget.text isEqualToString:l1.text] && [_dropTarget2.text isEqualToString: l2.text] && [_dropTarget3.text isEqualToString: l3.text])
        {
            correct++;
            [_correctAnswer play];
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another example?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
            [actionSheet showInView:self.view];
        }
        else
        {
            incorrect++;
            [_wrongAnswer play];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
            [alert show];
        }
    }
}

//Is called when the user decides to skip the current example and received another one
- (IBAction)skipExample:(id)sender
{
    _dropTarget.hidden = false;
    _dropTarget2.hidden = false;
    _dropTarget3.hidden = false;
    _dropTarget4.hidden = false;
    _equalLabel.hidden = false;
    _dropTarget.text = @" ";
    _dropTarget2.text = @" ";
    _dropTarget3.text = @" ";
    _dropTarget4.text = @" ";
    [self viewDidLoad];
}

//Determines which answer key is to be checked when user presses submit
- (IBAction)submitAnswer:(id)sender
{
    //First, determine which answer key to use depending on questionNum
    if (questionNum >= 0 && questionNum <= 3)
    {
        [self determineCorrectAnswersForFirstSet];
    }
    else if(questionNum >= 4 && questionNum <= 7)
    {
        [self determineCorrectAnswersForSecondSet];
    }
    else if(questionNum >= 8 && questionNum <= 13)
    {
        [self determineCorrectAnswersForThirdSet];
    }
    else if(questionNum >= 14 && questionNum <= 19)
    {
        [self determineCorrectAnswersForFourthSet];
    }
    
    //Update the users score
    score.text = @" ";
    NSString *msg = [NSString stringWithFormat:@"Correct: %d \n Incorrect: %d ", correct, incorrect];
    score.text = [score.text stringByAppendingString:msg];
    [score setFont:[UIFont systemFontOfSize:21]];
  
    
}

//Alert that displays after user has successfully answered a question and decided whether they want another example or not
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [actionSheet destructiveButtonIndex])
    {
        _dropTarget.hidden = false;
        _dropTarget2.hidden = false;
        _dropTarget3.hidden = false;
        _dropTarget4.hidden = false;
        _equalLabel.hidden = false;
        _dropTarget.text = @" ";
        _dropTarget2.text = @" ";
        _dropTarget3.text = @" ";
        _dropTarget4.text = @" ";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Next example" message:@"You requested another example" delegate:nil cancelButtonTitle:@"Yes. That's right" otherButtonTitles: nil];
        [alert show];
        //Determine the next question to be displayed
        [self determineQuestion];
        if (questionNum >= 0 && questionNum <= 3)
        {
            [self displayQuestionSet1];
        }
        if(questionNum >= 4 && questionNum <= 7)
        {
            [self displayQuestionSet2];
        }
        if(questionNum >= 8 && questionNum <= 13)
        {
            [self displayQuestionSet3];
        }
        if(questionNum >= 14 && questionNum <= 19)
        {
            [self displayQuestionSet4];
        }
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Next example" message:@"You don't want to learn more" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alert show];
    }
}
@end
