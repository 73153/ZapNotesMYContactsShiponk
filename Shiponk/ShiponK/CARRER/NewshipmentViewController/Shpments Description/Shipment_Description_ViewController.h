
typedef enum {
    Accept,
    Pickup,
    Deliver
} BidAmount;

#import <UIKit/UIKit.h>
#import "Shipment_Bidder_TableViewCell.h"
#import <MapKit/MapKit.h>

@interface Shipment_Description_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

{
    
        NSMutableArray *imgArray;
        NSMutableArray *nameArray;
    
}
//- (IBAction)btn_Accept_act:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *shipmentCollectionView;
- (IBAction)btn_Accept_Action:(id)sender;

@property BidAmount typeBidAmount;

@property (strong, nonatomic) IBOutlet MKMapView *MapView;

@property (nonatomic, retain) MKPolyline *routeLine;
@property (nonatomic, retain) MKPolylineView *routeLineView;
-(void)LoadMapRoute;

@property (strong, nonatomic) IBOutlet UIView *GooglemapView;

//


@property (strong, nonatomic) IBOutlet UITableView *tbl_shipment_description_out;
@property (strong, nonatomic) IBOutlet UIScrollView *scrllView;

- (IBAction)btn_back_act:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view_NoBiddiesFound;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *img_Title_View;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UITextView *txt_Desc_View;
@property (strong, nonatomic) IBOutlet UILabel *lbl_movingto;
@property (strong, nonatomic) IBOutlet UILabel *lbl_movingfrom;
@property (strong, nonatomic) IBOutlet UIView *view_detail_shipmnt;

@property (strong, nonatomic)NSString *statusTob;

@property (strong,nonatomic) NSMutableArray *shipmentfromcityArray;
@property (nonatomic,strong)NSDictionary *shipmentDic;
@property (strong,nonatomic)NSMutableArray *shipmentTocityArray,*shipmentImageArray,*shipmentDateArray,*shipMovetoLat,*shipMoveFromLat,*shipMovetoLong,*shipMoveFromLong;

@property (strong, nonatomic) IBOutlet UILabel *lbl_amount;
@property (strong, nonatomic) IBOutlet UILabel *noiteam;

@property(strong,nonatomic) NSString *ShipmentidStr;

//Shipment Bids Declarations

@property (strong,nonatomic) NSDictionary *shipmentBidDict,*shipmentBidListDict;
@end
