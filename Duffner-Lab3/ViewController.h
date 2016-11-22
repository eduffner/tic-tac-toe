//
//  ViewController.h
//  Duffner-Lab3
//
//  Created by Eileen on 9/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController{
    BOOL playerOne;
    BOOL computer;
    BOOL inPlay;
    BOOL win;
    NSString * winner;
    NSString *p1;
    NSString *p2;
    NSString *c;
}
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *boardSpots;
@property (weak, nonatomic) IBOutlet UIButton *spotOne;
@property (weak, nonatomic) IBOutlet UIButton *spotTwo;
@property (weak, nonatomic) IBOutlet UIButton *spotThree;
@property (weak, nonatomic) IBOutlet UIButton *spotFour;
@property (weak, nonatomic) IBOutlet UIButton *spotFive;
@property (weak, nonatomic) IBOutlet UIButton *spotSix;
@property (weak, nonatomic) IBOutlet UIButton *spotSeven;
@property (weak, nonatomic) IBOutlet UIButton *spotEight;
@property (weak, nonatomic) IBOutlet UIButton *spotNine;

@property (weak, nonatomic) IBOutlet UILabel *playerLabel;

- (IBAction)buttonTap:(id)sender;
- (IBAction)resetBoard:(id)sender;
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)chooseNumPlayers;
- (void)chooseStarter;
- (void)changePlayer;
- (void)playAI;
- (void)singleMove:(NSString *)string;
- (BOOL)win;
- (BOOL)draw;
- (BOOL)fullBoard;
- (void)winAlert;
- (void)drawAlert;
@end

