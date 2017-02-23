//
//  FMDBDataAccess.m
//  Chanda
//
//  Created by Mohammad Azam on 10/25/11.
//  Copyright (c) 2011 HighOnCoding. All rights reserved.
//

#import "FMDBDataAccess.h"
#import "AppDelegate.h"

@implementation FMDBDataAccess


-(instancetype)init{
    self = [super init];
    if(self) {
//        self.dbAccess= [FMDBDataAccess new];
    }
    return self;
}

+ (id)sharedManager {
    static FMDatabase *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}

-(BOOL)insertQueryWithDictionary:(NSDictionary *)dic inTable:(NSString *)table
{
    __block BOOL success ;
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(concurrentQueue, ^{
        AppDelegate *delegateObj = [[UIApplication sharedApplication] delegate];
        FMDatabase *db = [FMDatabase databaseWithPath:delegateObj.databasePath];
        [db open];
        
        NSMutableString *insertQ=[[NSMutableString alloc] init];;
        NSArray *keys=[[NSArray alloc] initWithArray:[dic allKeys]];
        NSArray *values=[[NSArray alloc] initWithArray:[dic allValues]];
        [insertQ appendString:[NSString stringWithFormat: @"insert into %@(",table ]];
        for (int i=0; i<[keys count]; i++) {
            if(i==([keys count]-1))
            {
                [insertQ appendString:[NSString stringWithFormat: @" %@ ",[keys objectAtIndex:i] ]];
            }
            else{
                [insertQ appendString:[NSString stringWithFormat: @" %@ , ",[keys objectAtIndex:i] ]];
            }
        }
        [insertQ appendString:@") values ("];
        for (int i=0; i<[values count]; i++) {
            if(i==([values count]-1))
            {
                [insertQ appendString:[NSString stringWithFormat: @" '%@' ",[values objectAtIndex:i] ]];
            }
            else{
                [insertQ appendString:[NSString stringWithFormat: @" '%@' , ",[values objectAtIndex:i] ]];
            }
        }
        [insertQ appendString:@");"];
        
        success =  [db executeUpdate:insertQ,nil];
        [db close];
        
        
    });
    
    //NSLog(@"%@",insertQ);
    
    return success;
}
- (BOOL)updateQueryWithDictionary:(NSString *)table withAttribute:(NSDictionary *)attribute withSQLCondition:(NSString *)condition
{
    
    AppDelegate *delegateObj = [[UIApplication sharedApplication] delegate];
    FMDatabase *db = [FMDatabase databaseWithPath:delegateObj.databasePath];
    [db open];
    __block BOOL updateResult = NO;
    if ([db open]) {
        NSArray *allValues = [attribute allValues];
        NSMutableString *prefixBindString = [[NSMutableString alloc] init];
        [prefixBindString appendFormat:@"update %@ set ",table];
        
        for (int i = 0; i != [[attribute allKeys] count]; ++ i) {
            NSString *keyString = [[attribute allKeys] objectAtIndex:i];
            [prefixBindString appendFormat:@"%@=? ",keyString];
            if (i != [[attribute allKeys] count] - 1) {
                [prefixBindString appendString:@","];
            } else {
                [prefixBindString appendString:[self realForString:condition]];
            }
        }
        updateResult = [db executeUpdate:prefixBindString withArgumentsInArray:allValues];
        if (!updateResult) {
            NSLog(@"%s,error:%@",__PRETTY_FUNCTION__,db.lastErrorMessage);
        }
        if (![db close]) {
            NSLog(@"数据库关闭失败:%@",[db lastErrorMessage]);
        }
    }
    return updateResult;
}
- (NSString *)realForString:(NSString *)value
{
    if (!value || [value isKindOfClass:[NSNull class]]) {
        return @"";
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",value];
    } else {
        return value;
    }
}
-(BOOL)deleteQueryWithTable: (NSString *)table{
    AppDelegate *delegateObj = [[UIApplication sharedApplication] delegate];
    FMDatabase *db = [FMDatabase databaseWithPath:delegateObj.databasePath];
    [db open];
    
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM %@",table];
    BOOL success=[db executeUpdate:deleteQuery,nil];
    if(success){
        // Success
        success=true;
    }
    [db close];
    return success;
}
-(BOOL)deleteQueryWithTable :(NSString *)tableName andWithWhereCondition:(NSString *) where
{
    __block BOOL success ;
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(concurrentQueue, ^{
        AppDelegate *delegateObj = [[UIApplication sharedApplication] delegate];
        FMDatabase *db = [FMDatabase databaseWithPath:delegateObj.databasePath];;
        [db open];
        NSString *query=[NSString stringWithFormat:@"DELETE FROM %@ where %@",tableName, where];
        success=[db executeUpdate:query,nil];
        if(success){
            // Success
            success=true;
        }
        [db close];
    });
    return success;
}



@end
