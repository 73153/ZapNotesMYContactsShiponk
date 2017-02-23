//
//  FMDBDataAccess.h
//  Chanda
//
//  Created by Mohammad Azam on 10/25/11.
//  Copyright (c) 2011 HighOnCoding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h" 
#import "FMDBDataAccess.h"
#import "FMResultSet.h" 
#import "Utility.h" 

@interface FMDBDataAccess : NSObject
{
    
}
@property FMDBDataAccess *dbAccess;
+ (id)sharedManager;
-(BOOL)deleteQueryWithTable :(NSString *)tableName andWithWhereCondition:(NSString *) where;
-(BOOL)insertQueryWithDictionary:(NSDictionary *)dic inTable:(NSString *)table;
- (BOOL)updateQueryWithDictionary:(NSString *)table withAttribute:(NSDictionary *)attribute withSQLCondition:(NSString *)condition;
-(BOOL)deleteQueryWithTable: (NSString *)table;
@end
