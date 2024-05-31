//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Yeliena Khaletska on 29.05.2024.
//

@import Foundation;
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    CardMatchingGameModeTwoCards,
    CardMatchingGameModeThreeCards,
    CardMatchingGameModeFourCards,
} CardMatchingGameMode;

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *statusOfGame;
- (instancetype)initWithCardCounts:(NSUInteger)count usingDeck:(Deck*)deck withMode:(CardMatchingGameMode)mode NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
