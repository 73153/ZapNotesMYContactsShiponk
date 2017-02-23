//
//  MapRoute.m
//  ShiponK
//
//  Created by ronakj on 6/1/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "MapRoute.h"

@implementation MapRoute
@synthesize coordinate,title,image,subtitle;
- (id)initWithLocation:(CLLocationCoordinate2D)coord
{
    
    self = [super init];
    if (self) {
        coordinate = coord;
        
    }
    return self;
}
@end
