//
//  QuizViewController.h
//  Practicing Arrays
//
//  Created by Software Development on 10/17/14.
//  Copyright (c) 2014 ___Allen Perry___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QuizViewController : UIViewController<UIActionSheetDelegate>

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *answers;
@property (strong, nonatomic) IBOutlet UITextView *questionView;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UIButton *answerButton;

@property (nonatomic, assign) NSInteger questionNum;

@property(strong, nonatomic) AVAudioPlayer *correctAnswer;
@property(strong, nonatomic) AVAudioPlayer *wrongAnswer;

@property (strong, nonatomic) IBOutlet UITextView *score;
@property (nonatomic, assign) int correct;
@property (nonatomic, assign) int incorrect;

- (IBAction)answerPressed:(id)sender;
-(void)determineQuestion;
-(void)displayQuestionSet1;
-(void)displayQuestionSet2;
-(void)displayQuestionSet3;
-(void)displayQuestionSet4;
-(void)displayQuestionSet5;
-(void)displayQuestionSet6;



@end
