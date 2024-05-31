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
@property (weak, nonatomic) IBOutlet UILabel *statusOfGameLabel;
@end

@implementation ViewController

- (void)createNewGame
{
    self.game = [[CardMatchingGame alloc] initWithCardCounts:self.cardButtons.count
                                                   usingDeck:[self createDeck]
                                                    withMode:self.gameModeSegmentedControl.selectedSegmentIndex];
}

- (Deck *)createDeck
{
    return [PlayingCardDeck new];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if (![self isGameEnabled]) {
        [self createNewGame];
    }

    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];

}

- (void)updateUI
{
    [self updateCards];
    [self updateGameModeSegmentedControl];
    [self updateRestartButton];
    [self updateScoreLabel];
    [self updateGameStatusLabel];
}

- (void)updateCards
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];

        cardButton.enabled = !card.isMatched;
    }
}

- (void)updateGameStatusLabel
{
    self.statusOfGameLabel.text = self.game.statusOfGame;
}

- (void)updateGameModeSegmentedControl
{
    self.gameModeSegmentedControl.enabled = ![self isGameEnabled];
}

- (void)updateRestartButton
{
    self.restartButton.enabled = [self isGameEnabled];
}

- (void)updateScoreLabel
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (BOOL)isGameEnabled
{
    return self.game != nil;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)touchRestartButton
{
    self.game = nil;
    [self updateUI];
}

@end
