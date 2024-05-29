//
//  Card.m
//  Matchismo
//
//  Created by Yeliena Khaletska on 28.05.2024.
//

#import "Card.h"

@implementation Card

- (NSUInteger)match:(NSArray<NSString *> *)otherCards
{
    NSUInteger score = 0;

    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }

    return score;
}

@end
