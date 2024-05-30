//
//  PlayingCard.m
//  Matchismo
//
//  Created by Yeliena Khaletska on 28.05.2024.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSUInteger)match:(NSArray<Card *> *)otherCards
{
    NSMutableArray<PlayingCard *> *playingCards = [NSMutableArray arrayWithObject: self];
    for (Card *card in otherCards) {
        [playingCards addObject:(PlayingCard *)card];
    }

    NSUInteger score = 0;
    NSUInteger cardsCount = playingCards.count;

    for (int i = 0; i < cardsCount; i += 1) {
        for (int j = i + 1; j < cardsCount; j += 1) {
            if ([playingCards[i].suit isEqualToString:playingCards[j].suit]) {
                score += 1;
            }
            if (playingCards[i].rank == playingCards[j].rank) {
                score += 4;
            }
        }
    }

    if (cardsCount == 3) {
        if ([playingCards[0].suit isEqualToString:playingCards[1].suit] &&
            [playingCards[0].suit isEqualToString:playingCards[2].suit]) {
            score += 3;
        }
        if (playingCards[0].rank == playingCards[1].rank &&
            playingCards[0].rank == playingCards[2].rank) {
            score += 12;
        }

    }
    else if (cardsCount == 4) {
        if ([playingCards[0].suit isEqualToString:playingCards[1].suit] &&
            [playingCards[0].suit isEqualToString:playingCards[2].suit] &&
            [playingCards[0].suit isEqualToString:playingCards[3].suit]) {
            score += 4;
        }
        if (playingCards[0].rank == playingCards[1].rank &&
            playingCards[0].rank == playingCards[2].rank &&
            playingCards[0].rank == playingCards[3].rank) {
            score += 16;
        }
    }

    return score;
}

- (NSString *)contents
{
    NSArray<NSString *> *rankStrings = [PlayingCard rankStrings];
    if (self.rank > [PlayingCard maxRank]) {
        return @"";
    }

    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray<NSString *> *)validSuits
{
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray<NSString *> *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
