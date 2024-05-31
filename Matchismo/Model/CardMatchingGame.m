//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Yeliena Khaletska on 29.05.2024.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *statusOfGame;
@property (nonatomic, strong) NSMutableArray<Card *> *cards;
@property (nonatomic) CardMatchingGameMode gameMode;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (instancetype)initWithCardCounts:(NSUInteger)count usingDeck:(Deck *)deck withMode:(CardMatchingGameMode)mode
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

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];

    if (card.isMatched) {
        return;
    }

    if (card.isChosen) {
        card.chosen = NO;
        self.statusOfGame = [NSString stringWithFormat:@"%@ flipped back", card.contents];
        return;
    }
    // match against other cards
    // finding all the cards that are chosen
    NSArray<Card *> *otherChosenCards = [self getChosenCards];

    // checking if enough cards are chosen
    if (otherChosenCards.count == [CardMatchingGame amountOfCardsBasedOnMode:self.gameMode]) {
        NSInteger matchScore = [card match:otherChosenCards];
        if (matchScore > 0) {
            [CardMatchingGame markAsMatchedCards:[otherChosenCards arrayByAddingObject:card]];
            self.score += matchScore + MATCH_BONUS;
            self.statusOfGame = [NSString stringWithFormat:@"Matched %@ and %@ for %ld!",
                                 [CardMatchingGame descriptionForCards:otherChosenCards],
                                 card.contents,
                                 (matchScore + MATCH_BONUS)];
        }
        else {
            [CardMatchingGame flipBackCards:otherChosenCards];
            self.score -= MISMATCH_PENALTY;
            self.statusOfGame = [NSString stringWithFormat:@"%@ and %@ did not match, %d penalty 😭",
                                 [CardMatchingGame descriptionForCards:otherChosenCards],
                                 card.contents,
                                 MISMATCH_PENALTY];
        }
    }
    else {
        self.statusOfGame = card.contents;
    }

    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
}

- (NSArray<Card *> *)getChosenCards
{
    NSMutableArray<Card *> *chosenCards = [NSMutableArray new];
    for (Card *card in self.cards) {
        if (card.isChosen && !card.isMatched) {
            [chosenCards addObject:card];
        }
    }

    return chosenCards;
}

+ (void)markAsMatchedCards:(NSArray<Card *> *)cards
{
    for (Card *card in cards) {
        card.matched = YES;
    }
}

+ (void)flipBackCards:(NSArray<Card *> *)cards
{
    for (Card *card in cards) {
        card.chosen = NO;
    }
}

+ (NSString *)descriptionForCards:(NSArray<Card *> *)cards
{
    NSMutableString *description = [NSMutableString string];

    for (Card *card in cards) {
        if (description.length == 0) {
            [description appendString:card.contents];
        }
        else {
            [description appendString:@", "];
            [description appendString:card.contents];
        }
    }

    return description;
}

+ (NSUInteger)amountOfCardsBasedOnMode:(CardMatchingGameMode)mode
{
    return mode + 1;
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
