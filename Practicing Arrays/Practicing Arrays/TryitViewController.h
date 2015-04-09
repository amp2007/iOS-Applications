//
//  TryitViewController.h
//  Practicing Arrays
//
//  Created by Software Development on 10/17/14.
//  Copyright (c) 2014 ___Allen Perry___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TryitViewController : UIViewController<UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UITextField *dropTarget;
@property (strong, nonatomic) IBOutlet UITextField *dropTarget2;
@property (strong, nonatomic) IBOutlet UITextField *dropTarget3;
@property (strong, nonatomic) IBOutlet UITextField *dropTarget4;

@property (strong, nonatomic) IBOutlet UITextView *questionView;

@property (nonatomic, strong) UILabel *dragObject;

@property (strong, nonatomic) IBOutlet UITextField *equalLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;

@property (nonatomic, assign) CGPoint touchOffset;
@property (nonatomic, assign) CGPoint homePosition;
@property (nonatomic, assign) NSInteger questionNum;

@property(strong, nonatomic) AVAudioPlayer *correctAnswer;
@property(strong, nonatomic) AVAudioPlayer *wrongAnswer;

@property (nonatomic, assign) UILabel *l1;
@property (nonatomic, assign) UILabel *l2;
@property (nonatomic, assign) UILabel *l3;
@property (nonatomic, assign) UILabel *l4;

@property (strong, nonatomic) IBOutlet UITextView *score;
@property (nonatomic, assign) int correct;
@property (nonatomic, assign) int incorrect;

- (IBAction)skipExample:(id)sender;
- (IBAction)submitAnswer:(id)sender;
-(void)determineQuestion;
-(void)displayQuestionSet1;
-(void)displayQuestionSet2;
-(void)displayQuestionSet3;
-(void)displayQuestionSet4;
-(void)determineCorrectAnswersForFirstSet;
-(void)determineCorrectAnswersForSecondSet;
-(void)determineCorrectAnswersForThirdSet;
-(void)determineCorrectAnswersForFourthSet;
@end
