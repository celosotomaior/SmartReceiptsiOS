//
//  Database+Receipts.h
//  SmartReceipts
//
//  Created by Jaanus Siim on 06/05/15.
//  Copyright (c) 2015 Will Baumann. All rights reserved.
//

#import <objc/objc.h>
#import "Database.h"

@class WBReceipt;
@class WBTrip;
@class FMDatabase;

@interface Database (Receipts)

- (BOOL)createReceiptsTable;
- (BOOL)saveReceipt:(WBReceipt *)receipt;
- (BOOL)saveReceipt:(WBReceipt *)receipt usingDatabase:(FMDatabase *)database;
- (NSArray *)allReceiptsForTrip:(WBTrip *)trip descending:(BOOL)desc;
- (NSDecimalNumber *)sumOfReceiptsForTrip:(WBTrip *)trip;
- (NSDecimalNumber *)sumOfReceiptsForTrip:(WBTrip *)trip usingDatabase:(FMDatabase *)database;
- (NSString *)currencyForTripReceipts:(WBTrip *)trip;
- (NSString *)currencyForTripReceipts:(WBTrip *)trip usingDatabase:(FMDatabase *)database;

@end
