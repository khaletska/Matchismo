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
    NSUInteger score = 0;

    if (otherCards.count == 1) {
        PlayingCard *otherCard = (PlayingCard *)otherCards.firstObject;
        if([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
        }
        else if (self.rank == otherCard.rank) {
            score = 4;
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
