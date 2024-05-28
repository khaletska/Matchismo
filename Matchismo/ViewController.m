//
//  ViewController.m
//  Matchismo
//
//  Created by Yeliena Khaletska on 27.05.2024.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSUInteger flipCount;
@property (nonatomic) PlayingCardDeck *playingCardsDeck;
@end

@implementation ViewController

- (PlayingCardDeck *)playingCardsDeck
{
    if (!_playingCardsDeck) _playingCardsDeck =  [PlayingCardDeck new];
    return _playingCardsDeck;
}

- (void)setFlipCount:(NSUInteger)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat: @"Flips: %lu", self.flipCount];
    NSLog(@"flipCount = %lu", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSString *label = [self.playingCardsDeck drawRandomCard].contents;
    if ([sender.currentTitle length] || ![label length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:label forState:UIControlStateNormal];
    }

    self.flipCount += 1;
}

@end
