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
@property (nonatomic) NSUInteger gameMode;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
- (instancetype)initWithCardCounts:(NSUInteger)count usingDeck:(Deck *)deck withMode:(NSUInteger)mode
{
    self = [super init];

    if (self == nil) {
        return self;
    }

    _gameMode = mode;
    _cards = [NSMutableArray new];

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

    return self;
}

- (NSString *)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSString *textForUserAction = @"";
    NSMutableString *listOfOtherCards = [[NSMutableString alloc] initWithString:@""];

    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other cards
            // finding all the _gameMode NSUInteger 3cards that are chosen
            NSMutableArray<Card *> *otherChosenCards = [NSMutableArray<Card *> new];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [listOfOtherCards appendFormat:@"%@ ", otherCard.contents];
                    [otherChosenCards addObject:otherCard];
                }
            }

            // checking if enough cards are chosen
            if (otherChosenCards.count == self.gameMode) {
                NSInteger matchScore = [card match:otherChosenCards];
                if (matchScore > 0) {
                    self.score += matchScore * MATCH_BONUS;
                    textForUserAction = [NSString stringWithFormat:@"Matched %@and %@ for %ld points.", listOfOtherCards, card.contents, (long)(matchScore + MATCH_BONUS)];
                    card.matched = YES;
                    for (Card *otherChosenCard in otherChosenCards) {
                        otherChosenCard.matched = YES;
                    }
                }
                else {
                    self.score -= MISMATCH_PENALTY;
                    textForUserAction = [NSString stringWithFormat:@"%@and %@ don't match! %d point penalty!", listOfOtherCards, card.contents, MISMATCH_PENALTY];
                    for (Card *otherChosenCard in otherChosenCards) {
                        otherChosenCard.chosen = NO;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            textForUserAction = textForUserAction.length ? textForUserAction : [NSString stringWithFormat:@"-%d for flipping %@.", COST_TO_CHOOSE, card.contents];
            card.chosen = YES;
        }
    }

    return textForUserAction;
}

- (Card *)cardAtIndex:(NSUInteger)index 
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (instancetype)init
{
    return nil;
}

@end
