//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Yeliena Khaletska on 29.05.2024.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray<Card *> *cards;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray<Card *> *)cards
{
    if(_cards == nil) {
        _cards = [NSMutableArray<Card *> new];
    }
    return _cards;
}

- (instancetype)initWithCardCounts:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];

    if (self != nil) {
        for (int i = 0; i < count; i += 1) {
            Card *card = [deck drawRandomCard];
            if (card != nil) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }

    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];

    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other card
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    NSInteger matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (instancetype)init
{
    return nil;
}

@end
