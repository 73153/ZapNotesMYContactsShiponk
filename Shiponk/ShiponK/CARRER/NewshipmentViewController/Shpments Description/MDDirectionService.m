//
//  MDDirectionService.m
//  MapsDirections
//
//  Created by Mano Marks on 4/8/13.
//  Copyright (c) 2013 Google. All rights reserved.
//

#import "MDDirectionService.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"[self.ticketTarget performSelector: self.ticketAction withObject: self afterDelay:1.0];
#pragma clang diagnostic pop
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation MDDirectionService{
  @private
  BOOL _sensor;
  BOOL _alternatives;
  NSURL *_directionsURL;
  NSArray *_waypoints;
}

static NSString *kMDDirectionsURL = @"http://maps.googleapis.com/maps/api/directions/json?";

- (void)setDirectionsQuery:(NSDictionary *)query withSelector:(SEL)selector
              withDelegate:(id)delegate{
  NSArray *waypoints = [query objectForKey:@"waypoints"];
  NSString *origin = [waypoints objectAtIndex:0];
  int waypointCount = [waypoints count];
  int destinationPos = waypointCount -1;
  NSString *destination = [waypoints objectAtIndex:destinationPos];
  NSString *sensor = [query objectForKey:@"sensor"];
  NSMutableString *url =
  [NSMutableString stringWithFormat:@"%@&origin=%@&destination=%@&sensor=%@",
   kMDDirectionsURL,origin,destination, sensor];
  if(waypointCount>2) {
    [url appendString:@"&waypoints=optimize:true"];
    int wpCount = waypointCount-2;
    for(int i=1;i<wpCount;i++){
      [url appendString: @"|"];
      [url appendString:[waypoints objectAtIndex:i]];
    }
  }
    url = [url
           stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    _directionsURL = [NSURL URLWithString:url];
  [self retrieveDirections:selector withDelegate:delegate];
}
- (void)retrieveDirections:(SEL)selector withDelegate:(id)delegate{
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSData* data =
//        [NSData dataWithContentsOfURL:_directionsURL];
        
        NSError* error = nil;
        NSData* data = [NSData dataWithContentsOfURL:_directionsURL options:NSDataReadingUncached error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            
        } else {
            NSLog(@"Data has loaded successfully.");
        }
        
      [self fetchedData:data withSelector:selector withDelegate:delegate];
    });
}

- (void)fetchedData:(NSData *)data
       withSelector:(SEL)selector
       withDelegate:(id)delegate{
  
    
    
  NSError* error;
  NSDictionary *json = [NSJSONSerialization
                        JSONObjectWithData:data
                                   options:kNilOptions
                                     error:&error];
 // [delegate performSelector:selector withObject:json];
    SuppressPerformSelectorLeakWarning([delegate performSelector:selector
                                                      withObject:json
                                                      afterDelay:1.0]);
//    [delegate performSelector:selector
//               withObject:json
//               afterDelay:3.0];
}

@end
