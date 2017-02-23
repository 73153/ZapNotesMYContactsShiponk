//
//  MapRoute.h
//  ShiponK
//
//  Created by ronakj on 6/1/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MapRoute : NSObject<MKAnnotation>


{
    CLLocationCoordinate2D coordinate;
    
    NSString *title;
    NSString *image;
    NSString *subtitle;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,copy) NSString *subtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;
@end
