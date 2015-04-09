//
//  QuizViewController.m
//  Practicing Arrays
//
//  Created by Software Development on 10/17/14.
//  Copyright (c) 2014 ___Allen Perry___. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@end

@implementation QuizViewController
@synthesize button;
@synthesize questionNum;
@synthesize answerButton;
@synthesize correct;
@synthesize incorrect;
@synthesize score;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Runs the determineQuestion method to determine which question is displayed when view is loaded
//Creates the alerts for right and wrong answers submitted
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self determineQuestion];
    if (questionNum >= 0 && questionNum <= 4)
    {
        [self displayQuestionSet1];
    }
    if(questionNum >= 5 && questionNum <= 9)
    {
        [self displayQuestionSet2];
    }
    if(questionNum >= 10 && questionNum <= 14)
    {
        [self displayQuestionSet3];
    }
    if(questionNum >= 15 && questionNum <= 19)
    {
        [self displayQuestionSet4];
    }
    if (questionNum >= 20 && questionNum <= 24)
    {
        [self displayQuestionSet5];
    }
    if(questionNum >= 25 && questionNum <= 29)
    {
        [self displayQuestionSet6];
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

//Random number choosen between 0-29, used to determine question to display
-(void)determineQuestion
{
    questionNum = arc4random_uniform(30);
}

//First set of questions that is selected if random number generated is between 0-4
//Also hides or displays textfield drop targets depending on how many are needed for the question
-(void)displayQuestionSet1
{
    if(questionNum == 0)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion1" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 1)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion2" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 2)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion3" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 3)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion4" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 4)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion5" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
}

//Second set of questions that is selected if random number generated is between 5-9
//Also hides or displays textfield drop targets depending on how many are needed for the question
-(void)displayQuestionSet2
{
    if(questionNum == 5)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion6" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 6)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion7" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 7)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion8" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 8)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion9" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 9)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion10" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
}

//Third set of questions that is selected if random number generated is between 10-14
//Also hides or displays textfield drop targets depending on how many are needed for the question
-(void)displayQuestionSet3
{
    if(questionNum == 10)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion11" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 11)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion12" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 12)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion13" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 13)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion14" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 14)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion15" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
}

//Fourth set of questions that is selected if random number generated is between 15-19
//Also hides or displays textfield drop targets depending on how many are needed for the question
-(void)displayQuestionSet4
{
    if(questionNum == 15)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion16" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 16)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion17" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 17)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion18" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 18)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion19" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 19)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion20" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
}

//Fifth set of questions that is selected if random number generated is between 20-24
//Also hides or displays textfield drop targets depending on how many are needed for the question
-(void)displayQuestionSet5
{
    if(questionNum == 20)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion21" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 21)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion22" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 22)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion23" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 23)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion24" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 24)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion25" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
}

//Sixth set of questions that is selected if random number generated is between 25-29
//Also hides or displays textfield drop targets depending on how many are needed for the question
-(void)displayQuestionSet6
{
    if(questionNum == 25)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion26" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 26)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion27" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 27)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion28" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 28)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion29" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
    else if(questionNum == 29)
    {
        NSCharacterSet *lineSeparator = [NSCharacterSet newlineCharacterSet];
        NSString *lines = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"QuizQuestion30" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        NSArray *words = [lines componentsSeparatedByCharactersInSet:lineSeparator];
        int count = 1;
        _questionView.text = [NSString stringWithFormat:@" %@ ", [words objectAtIndex:0]];
        for (int counter = 0; counter < [_answers count]; counter++)
        {
            button = [_answers objectAtIndex:counter];
            [button setTitle:[words objectAtIndex:count] forState:UIControlStateNormal];
            count++;
        }
    }
}

//Checks for the correct answer for the question and alerts user if correct or wrong
- (IBAction)answerPressed:(UIButton*)sender
{
    button = sender;
    //Checks the correct answer based off what button is selected and what the correct answer is for that question.
    //first checks what the current value of questionNum and then what button is pressed
    //Only uses the if portion if correct button is pressed with the corresponding value of questionNum
    if ( ([[button currentTitle] isEqualToString:@"d. array"] && questionNum == 0) || ([[button currentTitle] isEqualToString:@"d. new int[6]"] && questionNum == 1) || ([[button currentTitle] isEqualToString:@"a. int[]"] && questionNum == 2) || ([[button currentTitle] isEqualToString:@"a. int[] intData = new int[6];"] && questionNum == 3) || ([[button currentTitle] isEqualToString:@"d. a fixed value that depends on the element type"] && questionNum == 4) || ([[button currentTitle] isEqualToString:@"b. int[] odd = { 1, 3, 5, 7, 9 };"] && questionNum == 5) || ([[button currentTitle] isEqualToString:@"b. 0 <= i && i < data.length"] && questionNum == 6) || ([[button currentTitle] isEqualToString:@"d. 7"] && questionNum == 7) || ([[button currentTitle] isEqualToString:@"b. bounds error"] && questionNum == 8) || ([[button currentTitle] isEqualToString:@"b. System.out.println(square[2]);"] && questionNum == 9) || ([[button currentTitle] isEqualToString:@"b. for(int i = 0; i < arrayOfInts.length; i++) System.out.print(arrayOfInts[i] + “ ”);"] && questionNum == 10) || ([[button currentTitle] isEqualToString:@"a. The array referenced by data has not been initialized"] && questionNum == 11) ||([[button currentTitle] isEqualToString:@"b. None due to a null pointer exception."] && questionNum == 12) || ([[button currentTitle] isEqualToString:@"d. Sally"] && questionNum == 13) || ([[button currentTitle] isEqualToString:@"b. their length is fixed"] && questionNum == 14) || ([[button currentTitle] isEqualToString:@"d. all are valid"] && questionNum == 15) || ([[button currentTitle] isEqualToString:@"b. int size = customers.length;"] && questionNum == 16) || ([[button currentTitle] isEqualToString:@"c. 4"] && questionNum == 17) || ([[button currentTitle] isEqualToString:@"a. 0"] && questionNum == 18) || ([[button currentTitle] isEqualToString:@"c. error because index is out of range"] && questionNum == 19) || ([[button currentTitle] isEqualToString:@"c. Allie"] && questionNum == 20) || ([[button currentTitle] isEqualToString:@"c. 1-8 "] && questionNum == 21) || ([[button currentTitle] isEqualToString:@"a. 2-9"] && questionNum == 22) || ([[button currentTitle] isEqualToString:@"c. 12"] && questionNum == 23) || ([[button currentTitle] isEqualToString:@"c. 0"] && questionNum == 24) || ([[button currentTitle] isEqualToString:@"a. variable = name[i];"] && questionNum == 25) || ([[button currentTitle] isEqualToString:@"b. 0"] && questionNum == 26) || ([[button currentTitle] isEqualToString:@"b. Length of array can be changed after creation of array"] && questionNum == 27) || ([[button currentTitle] isEqualToString:@"d. Color[] palette = new Color[6];"] && questionNum == 28) || ([[button currentTitle] isEqualToString:@"c. 7"] && questionNum == 29) )
    {
        correct++;
        [_correctAnswer play];
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Correct! Try another question?" delegate:self cancelButtonTitle:@"" destructiveButtonTitle:@"Yes!" otherButtonTitles:@"No way!", nil];
        [actionSheet showInView:self.view];
        score.text = @" ";
        NSString *msg = [NSString stringWithFormat:@"Correct: %d \n Incorrect: %d ", correct, incorrect];
        score.text = [score.text stringByAppendingString:msg];
        [score setFont:[UIFont systemFontOfSize:21]];
    }
    else
    {
        incorrect++;
        [_wrongAnswer play];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect!" message:@"Please try again!" delegate:nil cancelButtonTitle:@"Yes. I Will" otherButtonTitles: nil];
        [alert show];
        score.text = @" ";
        NSString *msg = [NSString stringWithFormat:@"Correct: %d \n Incorrect: %d ", correct, incorrect];
        score.text = [score.text stringByAppendingString:msg];
        [score setFont:[UIFont systemFontOfSize:21]];
    }
}

//Alert that displays after user has successfully answered a question
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == [actionSheet destructiveButtonIndex])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Next question" message:@"You requested another question" delegate:nil cancelButtonTitle:@"Yes. That's right" otherButtonTitles: nil];
        [alert show];
        [self determineQuestion];
        if (questionNum >= 0 && questionNum <= 4)
        {
            [self displayQuestionSet1];
        }
        if(questionNum >= 5 && questionNum <= 9)
        {
            [self displayQuestionSet2];
        }
        if(questionNum >= 10 && questionNum <= 14)
        {
            [self displayQuestionSet3];
        }
        if(questionNum >= 15 && questionNum <= 19)
        {
            [self displayQuestionSet4];
        }
        if (questionNum >= 20 && questionNum <= 24)
        {
            [self displayQuestionSet5];
        }
        if(questionNum >= 25 && questionNum <= 29)
        {
            [self displayQuestionSet6];
        }
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Next question" message:@"You don't want to learn more" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alert show];
    }
}
@end
