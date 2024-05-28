//
//  PlayingCard.h
//  Matchismo
//
//  Created by Yeliena Khaletska on 28.05.2024.
//

@import Foundation;
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end

NS_ASSUME_NONNULL_END
