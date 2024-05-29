//
//  Card.h
//  Matchismo
//
//  Created by Yeliena Khaletska on 28.05.2024.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (NSUInteger)match:(NSArray<Card *> *)otherCards;

@end

NS_ASSUME_NONNULL_END
