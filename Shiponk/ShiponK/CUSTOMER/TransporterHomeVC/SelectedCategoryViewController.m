//
//  SelectedCategoryViewController.m
//  ShiponK
//
//  Created by Bhushan on 6/14/16.
//  Copyright © 2016 com.zaptechsolution. All rights reserved.
//

#import "SelectedCategoryViewController.h"
#import "SelectCategoryTableViewCell.h"
#import "category.h"
#import "SectionInfo.h"
#import "appShareManager.h"
#import "TransporterDetailViewController.h"
#import "ApiCall.h"

#define BASE_KEY @"AIzaSyBG2lM5lHV6a0N2_Gk3fUV3Vz8DnI8z_OU"

@interface SelectedCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    appShareManager *objappShareManager;
    
    NSMutableString * resultId;
    TransporterDetailViewController *tras;

    
    int subCategoryCount;
    
    
    BOOL categorybtnclick,moreFiltersbtnClick,othersbtnClick,txtteg,citytblshow,PackingServiceChekbox,UrgentShipmentDeliveryChekBox;
    
    NSString *strpostalcode,*strplaceid;
    
    NSMutableArray  *aryCity,*aryPostalCode;
    
}
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSMutableArray *sectionInfoArray;
@property (nonatomic, strong) NSArray *categoryList;

- (void) setCategoryArray;

@end

@implementation SelectedCategoryViewController
@synthesize categoryList = _categoryList;
@synthesize openSectionIndex;
@synthesize sectionInfoArray;

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.viewCategory.layer.masksToBounds = NO;
    self.viewCategory.layer.shadowOffset = CGSizeMake(5, 5);

    self.viewCategory.layer.shadowOpacity = 0.5;

    
    if(IS_IPHONE4==YES)
    {
     [self.viewCategory setFrame:CGRectMake(self.viewCategory.frame.origin.x, self.viewCategory.frame.origin.y-53,  self.viewCategory.frame.size.width , self.viewCategory.frame.size.height+53)];
    }
    else if (IS_IPHONE6==YES) {
       
        [self.viewCategory setFrame:CGRectMake(self.viewCategory.frame.origin.x, self.viewCategory.frame.origin.y+48,  self.viewCategory.frame.size.width , self.viewCategory.frame.size.height-48)];
    }
    else if(IS_IPHONE6plus==YES)
    {
         [self.viewCategory setFrame:CGRectMake(self.viewCategory.frame.origin.x, self.viewCategory.frame.origin.y+90,  self.viewCategory.frame.size.width , self.viewCategory.frame.size.height-90)];
        
    }

    
    [_scrollViewMain setContentSize:CGSizeMake(_scrollViewMain.frame.size.width, 400)];
    
   
    
    [_PackingServiceChekbox setImage:[UIImage imageNamed:@"Square_Checkbox_Unchecked"] forState:UIControlStateNormal];
    [_UrgentShipmentDeliveryChekBox setImage:[UIImage imageNamed:@"Square_Checkbox_Unchecked"] forState:UIControlStateNormal];

    objappShareManager=[appShareManager sharedManager];
    
     [self setCategoryArray];
    
    
    
        self.tblCategorySelect.sectionHeaderHeight = 45;
        self.tblCategorySelect.sectionFooterHeight = 0;
        self.openSectionIndex = NSNotFound;
    
        self.tblCategorySelect.delegate=self;
        self.tblCategorySelect.dataSource=self;
    

    
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         
                         [_viewCategory setFrame:CGRectMake(_viewCategory.frame.origin.x, _viewCategory.frame.origin.y+_viewCategory.frame.size.height,  _viewCategory.frame.size.width, _viewCategory.frame.size.height)];
                         
                         
                     }
     
                     completion:^(BOOL END){
                         
                     }];

    
  
//    UITapGestureRecognizer *singleFingerTap =
//    [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(tapOut)];
//    [self.viewMain addGestureRecognizer:singleFingerTap];
    

}
//-(void)tapOut
//{
//    
//    [self.view removeFromSuperview];
//    
//    [self removeFromParentViewController];
//    
//    [self didMoveToParentViewController:nil];
//
//    
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.sectionInfoArray = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ((self.sectionInfoArray == nil)|| ([self.sectionInfoArray count] != [self numberOfSectionsInTableView:self.tblCategorySelect])) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (category *cat in self.categoryList) {
            SectionInfo *section = [[SectionInfo alloc] init];
            section.category = cat;
            section.open = NO;
            
            NSNumber *defaultHeight = [NSNumber numberWithInt:44];
            NSInteger count = [[section.category list] count];
            for (NSInteger i= 0; i<count; i++) {
                [section insertObject:defaultHeight inRowHeightsAtIndex:i];
            }
            
            [array addObject:section];
        }
        self.sectionInfoArray = array;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag==200) {
        return 1;
    }
    else{
    return [self.categoryList count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==200) {
        return aryCity.count;

    }
    else
    {
    SectionInfo *array = [self.sectionInfoArray objectAtIndex:section];
    NSInteger rows = [[array.category list] count];
    return (array.open) ? rows : 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView.tag==200) {
        
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [_city_tbl_view dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = [aryCity objectAtIndex:indexPath.row];
        
        return cell;
        
    }
    else
    {
    
    static NSString *CellIdentifier = @"SelectCategoryTableViewCell";
    
    SelectCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SelectCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *strSel=[[[objappShareManager.TransportFlageArray  objectAtIndex:indexPath.section]objectAtIndex:1]objectAtIndex:indexPath.row];
    
    if ([strSel isEqualToString:@"0"])
    {
        [cell.img_CheckBox setImage:[UIImage imageNamed:@"Square_Checkbox_Unchecked"]];
        
    }else{
        [cell.img_CheckBox setImage:[UIImage imageNamed:@"Square_Checkbox_Checked"]];
    }
    
    
    category *categorye = (category *)[self.categoryList objectAtIndex:indexPath.section];
    cell.lblCategory.text = [categorye.list objectAtIndex:indexPath.row];
    return cell;
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    if (tableView.tag==200) {
        return 40;
    }
    else{
        
    SectionInfo *array = [self.sectionInfoArray objectAtIndex:indexPath.section];
    return [[array objectInRowHeightsAtIndex:indexPath.row] floatValue];
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==200) {
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
        UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, view.bounds.size.width, 15)];
        view.backgroundColor=[UIColor colorWithWhite: 0.70 alpha:1];
        lb.text=[NSString stringWithFormat:@" Location"];
        [lb setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [lb setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
        [view addSubview:lb];
    
        
        return view;
    }
    else{
    SectionInfo *array  = [self.sectionInfoArray objectAtIndex:section];
    if (!array.sectionView)
    {
        NSString *title = array.category.name;
        array.sectionView = [[SectionView alloc] initWithFrame:CGRectMake(0, 0, self.tblCategorySelect.bounds.size.width, 45) WithTitle:title Section:section delegate:self andselected:-1];
    }
    return array.sectionView;
    }
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView.tag==200) {
        strplaceid=[aryPostalCode objectAtIndex:indexPath.row];
      //  [self json];
        UITableViewCell *selectedcell=(UITableViewCell *)[self.city_tbl_view cellForRowAtIndexPath:indexPath];
         NSString *cityStr=selectedcell.textLabel.text;
        
        if(txtteg==0)
        {
            
            self.txtMovingFrom.text=[NSString stringWithFormat:@"%@",cityStr];//-%@",cityStr,strpostalcode];
            [self dismissKeyboard];
            
        } if(txtteg==1)
        {
            self.txtMovingTo.text=[NSString stringWithFormat:@"%@",cityStr];//-%@",cityStr,strpostalcode];
            [self dismissKeyboard];
        }
        
        
        
        _city_tbl_view.hidden=YES;
    }
    else
    {
    NSLog(@"%ld  %ld",(long)indexPath.row,(long)indexPath.section);
     subCategoryCount=0;
    
    NSString *strSel=[[[objappShareManager.TransportFlageArray  objectAtIndex:indexPath.section]objectAtIndex:1]objectAtIndex:indexPath.row] ;
    
    if ([strSel isEqualToString:@"0"])
    {
        
        [[[objappShareManager.TransportFlageArray  objectAtIndex:indexPath.section]objectAtIndex:1]replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }else{
        
        [[[objappShareManager.TransportFlageArray  objectAtIndex:indexPath.section]objectAtIndex:1]replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }
    for (int j=0; j< [[[objappShareManager.TransportFlageArray  objectAtIndex:indexPath.section]objectAtIndex:1] count ];j++)
    {
        if ([[[[objappShareManager.TransportFlageArray  objectAtIndex:indexPath.section]objectAtIndex:1]objectAtIndex:j] isEqualToString:@"1"])
        {
          
            subCategoryCount++;
            
        }
        
        
    }
    if (subCategoryCount==[[[objappShareManager.TransportFlageArray  objectAtIndex:indexPath.section]objectAtIndex:1] count ]) {
        
         [[objappShareManager.TransportFlageArray  objectAtIndex:indexPath.section]replaceObjectAtIndex:0 withObject:@"1"];

    }
    else
    {
        [[objappShareManager.TransportFlageArray  objectAtIndex:indexPath.section]replaceObjectAtIndex:0 withObject:@"0"];

    }
    
    SectionInfo *array  = [self.sectionInfoArray objectAtIndex:indexPath.section];
 
        NSString *title = array.category.name;
        array.sectionView = [[SectionView alloc] initWithFrame:CGRectMake(0, 0, self.tblCategorySelect.bounds.size.width, 45) WithTitle:title Section:indexPath.section delegate:self andselected:1];

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_tblCategorySelect reloadData];
        
    }
}

- (void) sectionClosed : (NSInteger) section{
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
    SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.tblCategorySelect numberOfRowsInSection:section];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
        [self.tblCategorySelect deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
}

- (void) sectionOpened : (NSInteger) section
{
    SectionInfo *array = [self.sectionInfoArray objectAtIndex:section];
    
    array.open = YES;
    NSInteger count = [array.category.list count];
    NSMutableArray *indexPathToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i<count;i++)
    {
        [indexPathToInsert addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    NSInteger previousOpenIndex = self.openSectionIndex;
    
    if (previousOpenIndex != NSNotFound)
    {
        SectionInfo *sectionArray = [self.sectionInfoArray objectAtIndex:previousOpenIndex];
        sectionArray.open = NO;
        NSInteger counts = [sectionArray.category.list count];
        [sectionArray.sectionView toggleButtonPressed:FALSE];
        for (NSInteger i = 0; i<counts; i++)
        {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenIndex]];
        }
    }
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenIndex == NSNotFound || section < previousOpenIndex)
    {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else
    {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    [self.tblCategorySelect beginUpdates];
    [self.tblCategorySelect insertRowsAtIndexPaths:indexPathToInsert withRowAnimation:insertAnimation];
    [self.tblCategorySelect deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tblCategorySelect endUpdates];
    self.openSectionIndex = section;
    
}

- (void) setCategoryArray
{
    
    NSArray *mainArray =objappShareManager.CatagoryArr;
    
    NSMutableArray *categoryArray = [[NSMutableArray alloc] initWithCapacity:[mainArray count]];
    for (NSDictionary *dictionary in mainArray) {
        
        
        category *categorye = [[category alloc] init];
        
        categorye.name = [dictionary objectForKey:@"category_title"];
        categorye.list = [[dictionary objectForKey:@"children"]valueForKey:@"category_title"];
        [categoryArray addObject:categorye];
        
        
    }
    self.categoryList = categoryArray;
    
    
}



- (IBAction)btnCategorySubmitAction:(id)sender {
    NSMutableArray *tmpArr=[[NSMutableArray alloc]init];
    
    for (int i=0; i< objappShareManager.CatagoryArr.count; i++) {
        
        
        
        for (int j=0; j< [[[[objappShareManager.CatagoryArr objectAtIndex:i]valueForKey:@"children"]valueForKey:@"category_title"] count ];j++) {
            if ([[[[objappShareManager.TransportFlageArray  objectAtIndex:i]objectAtIndex:1]objectAtIndex:j] isEqualToString:@"1"])
            {
                [tmpArr addObject:[[[[objappShareManager.CatagoryArr objectAtIndex:i]valueForKey:@"children"]objectAtIndex:j] valueForKey:@"id"]];
                
            }
            
            
        }
        
        
        
    }
    
    BOOL fist=YES;
    resultId = [[NSMutableString alloc] init];
    for (NSObject * obj in tmpArr)
    {
        if (fist==YES) {
            [resultId appendString:[NSString stringWithFormat:@"%@",[obj description]]];
            fist=NO;
        }
        else
        {
            [resultId appendString:[NSString stringWithFormat:@",%@",[obj description]]];
        }
    }
    NSLog(@"The concatenated string is %@", resultId);
    
   objappShareManager.SelectedCatagoryDic=[[NSMutableDictionary alloc]init];
    
    if (resultId.length<1) {
       [objappShareManager.SelectedCatagoryDic setValue:nil forKey:@"SubCategoryID"];
    }
    else
    {
        [objappShareManager.SelectedCatagoryDic setValue:[NSString stringWithFormat:@"%@",resultId] forKey:@"SubCategoryID"];
        
    }
    
    if (_txtMovingFrom.text.length<1) {
        
          [objappShareManager.SelectedCatagoryDic setValue:nil forKey:@"move_from"];
        
    }
    else{
        [objappShareManager.SelectedCatagoryDic setValue:[NSString stringWithFormat:@"%@",_txtMovingFrom.text]  forKey:@"move_from"];

    }
    
    if (_txtMovingTo.text.length<1) {
        
        [objappShareManager.SelectedCatagoryDic setValue:nil forKey:@"move_to"];

    }
    else
    {
         [objappShareManager.SelectedCatagoryDic setValue:[NSString stringWithFormat:@"%@",_txtMovingTo.text] forKey:@"move_to"];
        
    }
    
    if (UrgentShipmentDeliveryChekBox==NO) {
        
         [objappShareManager.SelectedCatagoryDic setValue:@"0" forKey:@"isurgent"];
    }
    else
    {
        [objappShareManager.SelectedCatagoryDic setValue:@"1" forKey:@"isurgent"];

    }
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"tableReload" object:nil];
    
    
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         
                         [_viewCategory setFrame:CGRectMake(_viewCategory.frame.origin.x, _viewCategory.frame.origin.y-_viewCategory.frame.size.height,  _viewCategory.frame.size.width, _viewCategory.frame.size.height)];
                         
                         
                         
                     }
     
                     completion:^(BOOL END){
                         
                     }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
        
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        
    });

   
    
}


- (IBAction)btnCategoryClearAction:(id)sender {
    
    
    objappShareManager.TransportFlageArray =[[NSMutableArray alloc]init];
    for (int i=0; i< objappShareManager.CatagoryArr.count; i++) {
        
        NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
        [categoryArray addObject:@"0"];
        
        NSMutableArray *tmpArr=[[NSMutableArray alloc]init];
        for (int j=0; j< [[[[objappShareManager.CatagoryArr objectAtIndex:i]valueForKey:@"children"]valueForKey:@"category_title"] count ];j++) {
            
            [tmpArr addObject:@"0"];
            
        }
        [categoryArray addObject:tmpArr];
        
        [objappShareManager.TransportFlageArray addObject:categoryArray];
        
        
    }
    
    for (int i=0; i< [objappShareManager.CatagoryArr count] ; i++) {
        SectionInfo *array  = [self.sectionInfoArray objectAtIndex:i];
     
            NSString *title = array.category.name;
            array.sectionView = [[SectionView alloc] initWithFrame:CGRectMake(0, 0, self.tblCategorySelect.bounds.size.width, 45) WithTitle:title Section:i delegate:self andselected:-1];
        [self sectionClosed:i];
    
    }
    _txtMovingTo.text=nil;
    _txtMovingFrom.text=nil;
    
    PackingServiceChekbox=NO;
    [_PackingServiceChekbox setImage:[UIImage imageNamed:@"Square_Checkbox_Unchecked"] forState:UIControlStateNormal];
    
    UrgentShipmentDeliveryChekBox=NO;
    [_UrgentShipmentDeliveryChekBox setImage:[UIImage imageNamed:@"Square_Checkbox_Unchecked"] forState:UIControlStateNormal];
    

    
    [_tblCategorySelect reloadData];
    
    
    [objappShareManager.SelectedCatagoryDic setValue:nil forKey:@"SubCategoryID"];
    
    [objappShareManager.SelectedCatagoryDic setValue:nil forKey:@"move_from"];
    
    [objappShareManager.SelectedCatagoryDic setValue:nil forKey:@"move_to"];
    
    
    [objappShareManager.SelectedCatagoryDic setValue:@"0" forKey:@"isurgent"];
    
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"tableReload" object:nil];
    
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         
                         [_viewCategory setFrame:CGRectMake(_viewCategory.frame.origin.x, _viewCategory.frame.origin.y-_viewCategory.frame.size.height,  _viewCategory.frame.size.width, _viewCategory.frame.size.height)];
                         
                         
                         
                     }
     
                     completion:^(BOOL END){
                         
                     }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
        
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        
    });
    

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSeaechAction:(id)sender {
    
    
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         
                         [_viewCategory setFrame:CGRectMake(_viewCategory.frame.origin.x, _viewCategory.frame.origin.y-_viewCategory.frame.size.height,  _viewCategory.frame.size.width, _viewCategory.frame.size.height)];
                         
                         
                         
                     }
     
                     completion:^(BOOL END){
                         
                     }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self.view removeFromSuperview];
        
        [self removeFromParentViewController];
        
        [self didMoveToParentViewController:nil];
        
    });
    

}
- (IBAction)btnCategoryAction:(id)sender {
    
    [self moreFiltersbtnclick];
    
     [self othersbtnClick];
    
    if (categorybtnclick==NO) {
        categorybtnclick=YES;
        [UIView animateWithDuration:0.50
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [_viewCategory setFrame:CGRectMake(_viewCategory.frame.origin.x
                                    , _viewCategory.frame.origin.y, _viewCategory.frame.size.width, _viewCategory.frame.size.height+_tblCategorySelect.frame.size.height)];
                             
                              [_scrollViewCategory setContentSize:CGSizeMake(_scrollViewCategory.frame.size.width, _viewCategory.frame.size.height+10)];
                             
                             
                             [_btnMoreFiltersOutlet setFrame:CGRectOffset(_btnMoreFiltersOutlet.frame, 0, _tblCategorySelect.frame.size.height)];
                             [_imgMoreFiltersbtnArrow setFrame:CGRectOffset(_imgMoreFiltersbtnArrow.frame, 0, _tblCategorySelect.frame.size.height)];
                             
                             [_btnOthersOutlet setFrame:CGRectOffset(_btnOthersOutlet.frame, 0, _tblCategorySelect.frame.size.height)];
                             
                             [_imgOthersbtnArrow setFrame:CGRectOffset(_imgOthersbtnArrow.frame, 0, _tblCategorySelect.frame.size.height)];
                             
                             [_tblCategorySelect setFrame:CGRectOffset(_tblCategorySelect.frame, _tblCategorySelect.frame.size.width+10,0)];
                             [_imgCategorybtnArrow setImage:[UIImage imageNamed:@"img_listDownArrow"]];
                             [_viewSubmitClear setFrame:CGRectOffset(_viewSubmitClear.frame, 0, _tblCategorySelect.frame.size.height)];
                             
                         }
         
                         completion:^(BOOL END){
                             
                         }];
        
    }
    else{
        
    
    
    [self categorybtnclick];

    }
    
}
- (IBAction)btnMoreFiltersAction:(id)sender {
    
    [self othersbtnClick];
   
    [self categorybtnclick];
    
    if (moreFiltersbtnClick==NO) {
        moreFiltersbtnClick=YES;
        [UIView animateWithDuration:0.50
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             
                             [_viewCategory setFrame:CGRectMake(_viewCategory.frame.origin.x
                                                                , _viewCategory.frame.origin.y, _viewCategory.frame.size.width, _viewCategory.frame.size.height+_viewMoreFilters.frame.size.height)];
                             [_scrollViewCategory setContentSize:CGSizeMake(_scrollViewCategory.frame.size.width, _viewCategory.frame.size.height+10)];
                             
                            [_viewMoreFilters setFrame:CGRectOffset(_viewMoreFilters.frame, _viewMoreFilters.frame.size.width, 0)];
                       
                             [_btnOthersOutlet setFrame:CGRectOffset(_btnOthersOutlet.frame, 0, _viewMoreFilters.frame.size.height)];

                            [_imgOthersbtnArrow setFrame:CGRectOffset(_imgOthersbtnArrow.frame, 0, _viewMoreFilters.frame.size.height)];
                             
                            [_viewSubmitClear setFrame:CGRectOffset(_viewSubmitClear.frame, 0, _viewMoreFilters.frame.size.height)];
                             
                             [_imgMoreFiltersbtnArrow setImage:[UIImage imageNamed:@"img_listDownArrow"]];
                            
                             
                         }
         
                         completion:^(BOOL END){
                             
                         }];
        
    }
    else{
        
        [self moreFiltersbtnclick];
    }
    
  
    
}

- (IBAction)btnOthersAction:(id)sender {
    
    [self dismissKeyboard];
    
    
    [self categorybtnclick];
     [self moreFiltersbtnclick];
    
    if (othersbtnClick==NO) {
        othersbtnClick=YES;
        [UIView animateWithDuration:0.50
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [_viewCategory setFrame:CGRectMake(_viewCategory.frame.origin.x
                                                                , _viewCategory.frame.origin.y, _viewCategory.frame.size.width, _viewCategory.frame.size.height+_viewOthers.frame.size.height)];
                              [_scrollViewCategory setContentSize:CGSizeMake(_scrollViewCategory.frame.size.width, _viewCategory.frame.size.height+_viewOthers.frame.size.height+10)];
                             
                             
                             [_viewOthers setFrame:CGRectOffset(_viewOthers.frame,_viewOthers.frame.size.width , 0)];
                             
                            [_viewSubmitClear setFrame:CGRectOffset(_viewSubmitClear.frame, 0, _viewOthers.frame.size.height)];
                             
                               [_imgOthersbtnArrow setImage:[UIImage imageNamed:@"img_listDownArrow"]];
                         }
         
                         completion:^(BOOL END){
                             
                         }];
        
    }
    else{
      
        [self othersbtnClick];
        
    }
    
    
}

-(void)categorybtnclick
{
    
    
    if (categorybtnclick==YES) {
        
        categorybtnclick=NO;
        [UIView animateWithDuration:0.50
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             [_viewCategory setFrame:CGRectMake(_viewCategory.frame.origin.x
                                                                , _viewCategory.frame.origin.y, _viewCategory.frame.size.width, _viewCategory.frame.size.height-_tblCategorySelect.frame.size.height)];
                             
                             [_scrollViewCategory setContentSize:CGSizeMake(_scrollViewCategory.frame.size.width, _viewCategory.frame.size.height+10)];
                             
                             
                             [_btnMoreFiltersOutlet setFrame:CGRectOffset(_btnMoreFiltersOutlet.frame, 0, -_tblCategorySelect.frame.size.height)];
                             [_imgMoreFiltersbtnArrow setFrame:CGRectOffset(_imgMoreFiltersbtnArrow.frame, 0, -_tblCategorySelect.frame.size.height)];
                             
                             [_btnOthersOutlet setFrame:CGRectOffset(_btnOthersOutlet.frame, 0, -_tblCategorySelect.frame.size.height)];
                             
                             [_imgOthersbtnArrow setFrame:CGRectOffset(_imgOthersbtnArrow.frame, 0,-_tblCategorySelect.frame.size.height)];
                             
                             [_tblCategorySelect setFrame:CGRectOffset(_tblCategorySelect.frame, -_tblCategorySelect.frame.size.width-10,0)];
                             
                              [_viewSubmitClear setFrame:CGRectOffset(_viewSubmitClear.frame, 0, -_tblCategorySelect.frame.size.height)];
                             
                             [_imgCategorybtnArrow setImage:[UIImage imageNamed:@"img_list-arrow"]];
                             
                             
                         }
         
                         completion:^(BOOL END){
                             
                         }];
        
        
    }
    
    
}
-(void)moreFiltersbtnclick
{
    if (moreFiltersbtnClick==YES) {
        
        
        moreFiltersbtnClick=NO;
        [UIView animateWithDuration:0.50
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             
                             [_viewCategory setFrame:CGRectMake(_viewCategory.frame.origin.x
                                                                , _viewCategory.frame.origin.y, _viewCategory.frame.size.width, _viewCategory.frame.size.height-_viewMoreFilters.frame.size.height)];
                              [_scrollViewCategory setContentSize:CGSizeMake(_scrollViewCategory.frame.size.width, _viewCategory.frame.size.height+10)];
                             
                             
                             [_viewMoreFilters setFrame:CGRectOffset(_viewMoreFilters.frame, -_viewMoreFilters.frame.size.width, 0)];
                             
                             [_btnOthersOutlet setFrame:CGRectOffset(_btnOthersOutlet.frame, 0, -_viewMoreFilters.frame.size.height)];
                             
                             [_imgOthersbtnArrow setFrame:CGRectOffset(_imgOthersbtnArrow.frame, 0, -_viewMoreFilters.frame.size.height)];
                             
                              [_viewSubmitClear setFrame:CGRectOffset(_viewSubmitClear.frame, 0, -_viewMoreFilters.frame.size.height)];
                             
                             [_imgMoreFiltersbtnArrow setImage:[UIImage imageNamed:@"img_list-arrow"]];
                             
                             
                             
                         }
         
                         completion:^(BOOL END){
                             
                         }];
        
    }
    
}

-(void)othersbtnClick
{
    
    
    if (othersbtnClick==YES) {
        
    
    othersbtnClick=NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         [_viewCategory setFrame:CGRectMake(_viewCategory.frame.origin.x
                                                            , _viewCategory.frame.origin.y, _viewCategory.frame.size.width, _viewCategory.frame.size.height-_viewOthers.frame.size.height)];
                         
                         [_scrollViewCategory setContentSize:CGSizeMake(_scrollViewCategory.frame.size.width, _viewCategory.frame.size.height+10)];
                         
                         [_viewOthers setFrame:CGRectOffset(_viewOthers.frame,-_viewOthers.frame.size.width , 0)];
                        [_viewSubmitClear setFrame:CGRectOffset(_viewSubmitClear.frame, 0, -_viewOthers.frame.size.height)];
                         
                         [_imgOthersbtnArrow setImage:[UIImage imageNamed:@"img_list-arrow"]];
                         
                     }
     
                     completion:^(BOOL END){
                         
                     }];

    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
     txtteg=textField.tag;
    
    self.city_tbl_view.delegate=self;
    self.city_tbl_view.dataSource=self;
    CGPoint scrollPoint = CGPointMake(0,textField.frame.origin.y+200);
    [_scrollViewMain setContentOffset:scrollPoint animated:YES];
    
    if(textField.tag==0)
    {
       
        if (citytblshow==YES) {
             [_city_tbl_view setFrame:CGRectOffset(_city_tbl_view.frame, 0,-45)];
        }
        
    }else if(textField.tag==1)
    {
        if (citytblshow==NO) {
            [_city_tbl_view setFrame:CGRectOffset(_city_tbl_view.frame, 0,45)];
            citytblshow=YES;
        }
       
        
    }
    
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [_scrollViewMain setContentOffset:CGPointZero animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    NSString  *urlString;
    NSCharacterSet *charsToTrim = [NSCharacterSet characterSetWithCharactersInString:@"  ()d   ;[ {]}+=_-*/,'\"^#`<>|"];
    

    NSString *str1 = [self.txtMovingFrom.text stringByTrimmingCharactersInSet:charsToTrim];
    NSString *strSearch1 = [str1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *str2 = [self.txtMovingTo.text stringByTrimmingCharactersInSet:charsToTrim];
    NSString *strSearch2 = [str2 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if(textField.tag==0)
    {
        
        urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@&input=%@",BASE_KEY,strSearch1];
        if (_txtMovingFrom.text.length>0) {
            _city_tbl_view.hidden=NO;
        }
        
        
    }else if(textField.tag==1)
    {
        urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@&input=%@",BASE_KEY,strSearch2];
        
        if (_txtMovingTo.text.length>0) {
            _city_tbl_view.hidden=NO;
           //
        }
        
    }
    
    
    NSURL *url=[NSURL URLWithString:urlString];
    
    //  dispatch_async(kBgQueue, ^{
    NSData* data = [NSData dataWithContentsOfURL: url];
    // [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    //  })
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          
                          options:kNilOptions
                          error:&error];
    NSLog(@"Data:%@",json);
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    NSMutableDictionary  *dataDic = [json objectForKey:@"predictions"];
    NSArray  *feed_dataDic=(NSArray *)dataDic;
    aryCity = [feed_dataDic valueForKey:@"description"];
    aryPostalCode=[feed_dataDic valueForKey:@"place_id"];
    
    //Write out the data to the console.
    NSLog(@"Google Data: %@", aryCity);
    
    NSLog(@"PlaceID=%@",aryPostalCode);
    
    
    if(string.length == 0 && textField.text.length==1)
    {
        aryCity=nil;
        _city_tbl_view.hidden=YES;
        [self.city_tbl_view reloadData];
    }
    
    [self.city_tbl_view reloadData];
    
    return YES;
}
//-(void)json{
//    
//    NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?key=%@&placeid=%@",BASE_KEY,strplaceid];
//    NSURL *url=[NSURL URLWithString:urlString];
//    
//    //  dispatch_async(kBgQueue, ^{
//    NSData* data = [NSData dataWithContentsOfURL: url];
//    // [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
//    //  })
//    NSError* error;
//    NSDictionary* json = [NSJSONSerialization
//                          JSONObjectWithData:data
//                          
//                          options:kNilOptions
//                          error:&error];
//    
//    NSMutableDictionary  *dataDic1 = [json objectForKey:@"result"];
//    NSMutableDictionary *dataDic2 = [dataDic1 objectForKey:@"address_components"];
//    // arydata=(NSMutableArray *)dataDic2;
//    strpostalcode=[[NSString alloc]init];
//    for(int i=0;i<[dataDic2 count];i++)
//    {
//        if ([[[[dataDic2 valueForKey:@"types"]objectAtIndex:i]objectAtIndex:0] isEqualToString:@"postal_code"]) {
//           NSMutableArray *aryTypes=[dataDic2 valueForKey:@"long_name"];
//            
//            strpostalcode=[aryTypes objectAtIndex:i];
//        }
//        
//    }
//    
//    NSLog(@"Data:%@",strpostalcode);
//    
//}
-(void)dismissKeyboard{
    
    [_txtMovingFrom resignFirstResponder];
    [_txtMovingTo resignFirstResponder];
   
}

- (IBAction)btnPackingServiceChekbox:(id)sender {
    
    if (PackingServiceChekbox==NO) {
      
        PackingServiceChekbox=YES;
        [_PackingServiceChekbox setImage:[UIImage imageNamed:@"Square_Checkbox_Checked"] forState:UIControlStateNormal];
    
    }
    else
    {
        PackingServiceChekbox=NO;
        [_PackingServiceChekbox setImage:[UIImage imageNamed:@"Square_Checkbox_Unchecked"] forState:UIControlStateNormal];
        
    }
    
    
}

- (IBAction)btnUrgentShipmentDeliveryChekBox:(id)sender {
    
    
    if (UrgentShipmentDeliveryChekBox==NO) {
        
        UrgentShipmentDeliveryChekBox=YES;
        [_UrgentShipmentDeliveryChekBox setImage:[UIImage imageNamed:@"Square_Checkbox_Checked"] forState:UIControlStateNormal];
        
    }
    else
    {
        UrgentShipmentDeliveryChekBox=NO;
        [_UrgentShipmentDeliveryChekBox setImage:[UIImage imageNamed:@"Square_Checkbox_Unchecked"] forState:UIControlStateNormal];
        
    }
    
}
@end
