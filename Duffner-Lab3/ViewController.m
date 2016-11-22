//
//  ViewController.m
//  Duffner-Lab3
//
//  Created by Eileen on 9/28/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    playerOne = YES;
    computer = NO;
    win = NO;
    p1 = @"Player 1";
    p2 = @"Player 2";
    c = @"Computer";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch(actionSheet.tag){
        case 1:
            if (buttonIndex == 0) {
                computer = YES;
            }
            else if (buttonIndex == 1) {
                computer = NO;
            }
            break;
            
        case 2:
            if (buttonIndex == 2) {
                buttonIndex = arc4random() %2;
            }
            if (buttonIndex == 0) {
                NSLog(@"Player 1, %d", buttonIndex);
            }
            else if (buttonIndex == 1){
                playerOne = NO;
                if(computer){
                    self.playerLabel.text = c;
                    [self playAI];
                }
                else
                    self.playerLabel.text = p2;
                NSLog(@"Player 2, %d", buttonIndex);
            }
            break;
        default:
            break;
    }
}
-(void)winAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: winner message: @"is the Winnner!"     delegate: self cancelButtonTitle: @"Dismiss"otherButtonTitles: nil];
    [alert show];
    win = YES;
}
-(void)drawAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Cat's Game" message: @"Press Rest Game" delegate: self cancelButtonTitle: @"Dismiss"otherButtonTitles: nil];
    [alert show];
}

-(void)changePlayer{
    if(!win){
        if([self win]){
            [self winAlert];
        }
        else if([self draw])
            [self drawAlert];
        
        if(playerOne){
            playerOne = NO;
            if(!computer){
                self.playerLabel.text = p2;
            }
            else{
                self.playerLabel.text = c;
                [self playAI];
            }
        }
        else if(!playerOne){
            playerOne = YES;
            self.playerLabel.text = p1;
        }
        
     
    }
}



- (IBAction)buttonTap:(id)sender {
    UIButton *tapped = (UIButton *)sender;
    if(inPlay){
        if(tapped.currentTitle == nil){
            if(playerOne){
                [tapped setTitle:@"X" forState:UIControlStateNormal];
                [self changePlayer];
            }
            else if (!playerOne){
                [tapped setTitle:@"O" forState:UIControlStateNormal];
                [self changePlayer];
            }
            else if(tapped.currentTitle != nil){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"There is a marker in this box already" delegate: self cancelButtonTitle: @"Dismiss" otherButtonTitles: nil];
                [alert show];
            }
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Invalid Move" message: @"There is already a maker in this spot" delegate: self cancelButtonTitle: @"Dismiss"otherButtonTitles: nil];
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Game not in Play" message: @"Press Play Game" delegate: self cancelButtonTitle: @"Dismiss"otherButtonTitles: nil];
        [alert show];
        
    }
}

- (IBAction)resetBoard:(id)sender {
    NSString  *start = @"Play Game";
    NSString *reset = @"Reset Game";
    UIButton *pushed = (UIButton *)sender;
    if([pushed.currentTitle isEqual: start]){
        inPlay = YES;
        [pushed setTitle: reset forState:UIControlStateNormal];
    }
    else if([pushed.currentTitle isEqual: reset]){
        win = NO;
        playerOne = YES;
        for (UIButton *spot in self.boardSpots){
            [spot setTitle: nil forState:UIControlStateNormal];
        }
    }
    [self chooseStarter];
    [self chooseNumPlayers];
}

-(void)chooseNumPlayers{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Number of Players" message: @"How many players for this game?" delegate: self cancelButtonTitle: nil otherButtonTitles:@"One", @"Two", nil];
    alert.tag = 1;
    [alert show];
}

- (void)chooseStarter{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Start Game" message: @"Who should start this game?" delegate: self cancelButtonTitle: nil otherButtonTitles:@"P1", @"P2", @"Random", nil];
    alert.tag = 2;
    [alert show];
    
}

- (void)singleMove:(NSString *)string{
    //winning move
    NSString *oh = @"O";
    if( [self.spotOne.currentTitle isEqual:string]){
        
        if([self.spotOne.currentTitle isEqual: self.spotTwo.currentTitle] && !(self.spotThree.currentTitle)){
            [self.spotThree setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotOne.currentTitle isEqual: self.spotFour.currentTitle] && !(self.spotSeven.currentTitle)){
            [self.spotSeven setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotOne.currentTitle isEqual: self.spotFive.currentTitle]&& !(self.spotNine.currentTitle)){
            [self.spotNine setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotOne.currentTitle isEqual: self.spotNine.currentTitle]&& !(self.spotFive.currentTitle)){
            [self.spotFive setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotOne.currentTitle isEqual: self.spotSeven.currentTitle]&& !(self.spotFour.currentTitle)){
            [self.spotFour setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotOne.currentTitle isEqual: self.spotThree.currentTitle]&& !(self.spotTwo.currentTitle)){
            [self.spotTwo setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
    }
    else if( [self.spotTwo.currentTitle isEqual:string]){
        
        if([self.spotTwo.currentTitle isEqual: self.spotThree.currentTitle]&& !(self.spotOne.currentTitle)){
            [self.spotOne setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotTwo.currentTitle isEqual: self.spotFive.currentTitle]&& !(self.spotEight.currentTitle)){
            [self.spotEight setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotTwo.currentTitle isEqual: self.spotEight.currentTitle]&& !(self.spotNine.currentTitle)){
            [self.spotFive setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
    }
    else if( [self.spotThree.currentTitle isEqual:string]){
        
        if([self.spotThree.currentTitle isEqual: self.spotFive.currentTitle]&& !(self.spotSeven.currentTitle)){
            [self.spotSeven setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotThree.currentTitle isEqual: self.spotSeven.currentTitle]&& !(self.spotFive.currentTitle)){
            [self.spotFive setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotThree.currentTitle isEqual: self.spotSix.currentTitle]&& !(self.spotNine.currentTitle)){
            [self.spotNine setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotThree.currentTitle isEqual: self.spotNine.currentTitle]&& !(self.spotSix.currentTitle)){
            [self.spotSix setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        
    }
    else if( [self.spotFour.currentTitle isEqual:string]){
        
        if([self.spotFour.currentTitle isEqual: self.spotFive.currentTitle]&& !(self.spotSix.currentTitle)){
            [self.spotSix setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotFour.currentTitle isEqual: self.spotSeven.currentTitle]&& !(self.spotOne.currentTitle)){
            [self.spotOne setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotFour.currentTitle isEqual: self.spotSix.currentTitle]&& !(self.spotFive.currentTitle)){
            [self.spotFive setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        
    }
    else if( [self.spotFour.currentTitle isEqual:string]){
        
        if([self.spotFour.currentTitle isEqual: self.spotFive.currentTitle]&& !(self.spotSix.currentTitle)){
            [self.spotSix setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotFour.currentTitle isEqual: self.spotSeven.currentTitle]&& !(self.spotOne.currentTitle)){
            [self.spotOne setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotFour.currentTitle isEqual: self.spotSix.currentTitle]&& !(self.spotFive.currentTitle)){
            [self.spotFive setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        
    }
    else if( [self.spotFive.currentTitle isEqual:string]){
        
        if([self.spotFive.currentTitle isEqual: self.spotNine.currentTitle]&& !(self.spotOne.currentTitle)){
            [self.spotOne setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotFive.currentTitle isEqual: self.spotSeven.currentTitle]&& !(self.spotThree.currentTitle)){
            [self.spotThree setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotFive.currentTitle isEqual: self.spotSix.currentTitle]&& !(self.spotFour.currentTitle)){
            [self.spotFour setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        else if([self.spotFive.currentTitle isEqual: self.spotEight.currentTitle]&& !(self.spotTwo.currentTitle)){
            [self.spotTwo setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        
    }
    else if( [self.spotSix.currentTitle isEqual:string]){
        
        if([self.spotSix.currentTitle isEqual: self.spotNine.currentTitle]&& !(self.spotThree.currentTitle)){
            [self.spotThree setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
    }
    else if( [self.spotSeven.currentTitle isEqual:string]){
        
        if([self.spotSeven.currentTitle isEqual: self.spotNine.currentTitle]&& !(self.spotEight.currentTitle)){
            [self.spotEight setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
        
        if([self.spotSeven.currentTitle isEqual: self.spotEight.currentTitle]&& !(self.spotNine.currentTitle)){
            [self.spotNine setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
    }
    else if( [self.spotEight.currentTitle isEqual:string]){
        
        if([self.spotEight.currentTitle isEqual: self.spotNine.currentTitle]&& !(self.spotSeven.currentTitle)){
            [self.spotSeven setTitle: oh forState:UIControlStateNormal];
            [self changePlayer];
        }
    }
}

- (void)playAI{
    if(!win){
        [self singleMove:@"O"];
        if(!playerOne){
            [self singleMove:@"X"];
        }
        if(!playerOne){
            NSArray *buttonArray = [[NSArray alloc] initWithObjects:self.spotFive, self.spotOne, self.spotThree, self.spotSeven, self.spotNine, self.spotTwo, self.spotFour, self.spotSix, self.spotEight,  nil];
            for(int i = 0; i<[self.boardSpots count]; i++) {
                if(!playerOne){
                    UIButton *b = [buttonArray objectAtIndex:i];
                    if (!b.currentTitle){
                        [b setTitle: @"O" forState:UIControlStateNormal];
                        [self changePlayer];
                    }
                }
            }
            
            
        }
    }
    
}

- (BOOL)win{
    win = YES;
    //horizontal
    if( [self.spotOne.currentTitle isEqual: self.spotTwo.currentTitle] &&
       [self.spotTwo.currentTitle isEqual: self.spotThree.currentTitle] &&
       (self.spotOne.currentTitle)){
        if ([self.spotOne.currentTitle isEqual: @"O"]){
            if(!computer){
                winner = p2;
            }
            else {
                winner = c;
            }
        }
        else {
            winner = p1;
        }
        return YES;
    }
    if( [self.spotFour.currentTitle isEqual: self.spotFive.currentTitle] &&
       [self.spotFive.currentTitle isEqual: self.spotSix.currentTitle] &&
       (self.spotFour.currentTitle)){
        if ([self.spotFour.currentTitle isEqual: @"O"]){
            if(!computer){
                winner = p2;
            }
            else{
                winner = c;
            }
        }
        else {
            winner = p1;
        }
        return YES;
    }
    if( [self.spotSeven.currentTitle isEqual: self.spotEight.currentTitle] &&
       [self.spotEight.currentTitle isEqual: self.spotNine.currentTitle] &&
       (self.spotSeven.currentTitle)){
        if ([self.spotSeven.currentTitle isEqual: @"O"]){
            if(!computer){
                winner = p2;
            }
            else
                winner = c;
        }
        else {
            winner = p1;
        }
        return YES;
    }
    //vertical
    if( [self.spotOne.currentTitle isEqual: self.spotFour.currentTitle] &&
       [self.spotFour.currentTitle isEqual: self.spotSeven.currentTitle] &&
       (self.spotOne.currentTitle)){
        if ([self.spotOne.currentTitle isEqual: @"O"]){
            if(!computer){
                winner = p2;
            }
            else
                winner = c;
        }
        else {
            winner = p1;
        }
        return YES;
    }
    if( [self.spotTwo.currentTitle isEqual: self.spotFive.currentTitle] &&
       [self.spotFive.currentTitle isEqual: self.spotEight.currentTitle] &&
       (self.spotTwo.currentTitle)){
        if ([self.spotTwo.currentTitle isEqual: @"O"]){
            if(!computer){
                winner = p2;
            }
            else
                winner = c;
        }
        else {
            winner = p1;
        }
        return YES;
    }
    if( [self.spotThree.currentTitle isEqual: self.spotSix.currentTitle] &&
       [self.spotSix.currentTitle isEqual: self.spotNine.currentTitle] &&
       (self.spotThree.currentTitle))
        return YES;
    if ([self.spotThree.currentTitle isEqual: @"O"]){
        if(!computer){
            winner = p2;
        }
        else
            winner = c;
    }
    else {
        winner = p1;
    }
    //diags
    if( [self.spotOne.currentTitle isEqual: self.spotFive.currentTitle] &&
       [self.spotFive.currentTitle isEqual: self.spotNine.currentTitle] &&
       (self.spotOne.currentTitle)){
        if ([self.spotOne.currentTitle isEqual: @"O"]){
            if(!computer){
                winner = p2;
            }
            else
                winner = c;
        }
        else {
            winner = p1;
        }
        return YES;
    }
    if( [self.spotThree.currentTitle isEqual: self.spotFive.currentTitle] &&
       [self.spotFive.currentTitle isEqual: self.spotSeven.currentTitle] &&
       (self.spotThree.currentTitle)){
        
        if ([self.spotThree.currentTitle isEqual: @"O"]){
            if(!computer){
                winner = p2;
            }
            else
                winner = c;
        }
        else {
            winner = p1;
        }
        return YES;
    }
    else
        win = NO;
    return NO;
}

- (BOOL)fullBoard {
    for(UIButton *spot in self.boardSpots){
        if(!(spot.currentTitle))
            return NO;
    }
    return YES;
}

- (BOOL)draw{
    if(![self win] && [self fullBoard]){
        return YES;
    }
    return NO;
    
}

@end
