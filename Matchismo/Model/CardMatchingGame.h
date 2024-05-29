//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Yeliena Khaletska on 29.05.2024.
//

@import Foundation;
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCounts:(NSUInteger)count usingDeck:(Deck*)deck NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSInteger score;

@end

NS_ASSUME_NONNULL_END
