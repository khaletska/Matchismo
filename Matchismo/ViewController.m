//
//  ViewController.m
//  Matchismo
//
//  Created by Yeliena Khaletska on 27.05.2024.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray<UIButton *> *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UILabel *userActionsLabel;
@end

@implementation ViewController

- (CardMatchingGame *)game
{
    if (_game == nil) {
        _game = [[CardMatchingGame alloc] initWithCardCounts:[self.cardButtons count] usingDeck:[self createDeck] withMode:self.gameModeSegmentedControl.selectedSegmentIndex + 1];
        self.gameModeSegmentedControl.enabled = NO;
        self.restartButton.enabled = YES;
    }
    return _game;
}

- (Deck *)createDeck
{
    return [PlayingCardDeck new];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    self.userActionsLabel.text = [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];

}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];

        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchRestartButton {
    self.game = nil;
    self.gameModeSegmentedControl.enabled = YES;
    self.restartButton.enabled = NO;
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    self.scoreLabel.text = @"Score: 0";
    self.userActionsLabel.text = @"";
}

@end
