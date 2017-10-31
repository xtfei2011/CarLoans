//
//  TFCityListViewController.m
//  CarLoans
//
//  Created by 谢腾飞 on 2017/7/13.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCityListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "TFHotCityListCell.h"
#import "TFCityListReusableView.h"

@interface TFCityListViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate>

@property (nonatomic ,strong) NSMutableArray *allCities;
@property (nonatomic ,strong) NSMutableArray *allCityName;
@property (nonatomic ,strong) NSArray *hostCities;
@property (nonatomic ,strong) NSString *locationCityName;
@property (nonatomic ,getter = isLocationFail ,assign) BOOL isLocationFail;
@property (nonatomic ,getter = isLocating ,assign) BOOL isLocating;

@property (nonatomic ,strong) UITableView *mainTable;
@property (nonatomic ,strong) NSArray *cityData;
@property (nonatomic ,strong) UICollectionView *hotCityListView;
@property (nonatomic ,strong) CLLocationManager *manager;//获取用户位置
@property (nonatomic ,strong) CLGeocoder *geocoder;//反地理编码
@end

@implementation TFCityListViewController
static NSString *collectionCellID = @"collectionCellID";
static NSString *collectionHeadID = @"collectionHeadID";

- (CLLocationManager *)manager
{
    if (!_manager) {
        _manager = [CLLocationManager new];
        [_manager requestAlwaysAuthorization];
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.distanceFilter = kCLDistanceFilterNone;
    }
    return _manager;
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (NSArray *)cityData
{
    if (!_cityData) {
        _cityData = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cityGroups" ofType:@"plist"]];
    }
    return _cityData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择城市";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupParameter];
    
    [self statLocation];
}

- (void)setupParameter
{
    self.allCities = [NSMutableArray new];
    self.allCityName = [NSMutableArray new];
    self.hostCities = [NSArray new];
    self.isLocating = NO;
    
    for (NSDictionary *dic in self.cityData) {
        
        if (![dic[@"title"] isEqualToString:@"热门"]) {
            
            for (NSString *cityName in dic[@"cities"]) {
                [self.allCityName addObject:cityName];
            }
            
            [self.allCities addObject:dic];
        }else{
            self.hostCities = dic[@"cities"];
        }
    }
    
    [self.hotCityListView registerClass:[TFHotCityListCell class] forCellWithReuseIdentifier:collectionCellID];
    [self.hotCityListView registerClass:[TFCityListReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeadID];
    
    self.mainTable = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.mainTable.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    self.mainTable.sectionIndexBackgroundColor = [UIColor clearColor];
    self.mainTable.sectionIndexColor = [UIColor grayColor];
    self.mainTable.backgroundColor = TFGlobalBg;
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    self.mainTable.tableFooterView = [UIView new];
    [self.view addSubview:self.mainTable];
}

- (UICollectionView *)hotCityListView
{
    if (!_hotCityListView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat W = (_hostCities.count/3 == 0 ? _hostCities.count/3 : _hostCities.count/3 + 1) * 40 + 100;
        
        _hotCityListView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, TFMainScreen_Width - 20, W) collectionViewLayout:flowLayout];
        _hotCityListView.delegate = self;
        _hotCityListView.dataSource = self;
        _hotCityListView.backgroundColor = [UIColor whiteColor];
    }
    return _hotCityListView;
}

- (void)statLocation
{
    //开始定位，定位后签到
    self.manager.delegate = self;
    [self.manager requestWhenInUseAuthorization];
    
    // 设置定位精度，十米，百米，最好
    [self.manager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [self.manager startUpdatingLocation];
    
    [self.geocoder reverseGeocodeLocation:self.manager.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        [self.manager stopUpdatingLocation];
        _isLocating = YES;
        if (error || placemarks.count == 0) {
            _isLocationFail = YES;
        }else{
            _isLocationFail = NO;
            CLPlacemark *currentPlace = [placemarks firstObject];
            _locationCityName = currentPlace.locality;
        }
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reloadCollection) userInfo:nil repeats:NO];
    }];
}

-(void)reloadCollection
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.hotCityListView reloadItemsAtIndexPaths:@[path]];
    });
}

#pragma mark ====== 其他城市列表
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allCities.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        NSArray *cites = _allCities[section - 1][@"cities"];
        return cites.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat H = (_hostCities.count/3 == 0 ? _hostCities.count/3 : _hostCities.count/3 + 1) * 40 + 100;
    
    return (indexPath.section == 0) ? H : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *newCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"new"];
        [newCell addSubview:self.hotCityListView];
        return newCell;
    }else{
        NSDictionary *dic = _allCities[indexPath.section - 1];
        cell.textLabel.text = dic[@"cities"][indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cityName = [NSString new];
    if (indexPath.section != 0) {
        NSDictionary *dic = _allCities[indexPath.section - 1];
        cityName = dic[@"cities"][indexPath.row];
    }
    self.selectCity(cityName);
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        return _allCities[section - 1][@"title"];
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arr = [NSMutableArray new];
    for (NSDictionary *dic in _allCities) {
        [arr addObject:dic[@"title"]];
    }
    return arr;
}

#pragma mark 索引列点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index + 1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [TFProgressHUD showMessage:title];
    return index + 1;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (section == 0) ? 1 : _hostCities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFHotCityListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[TFHotCityListCell alloc]initWithFrame:CGRectZero];
    }
    if (indexPath.section == 0) {
        cell.cityNameLabel.text = @"定位中...";
        cell.cityNameLabel.textAlignment = NSTextAlignmentLeft;
        CGRectSetX(cell.cityNameLabel.frame, cell.locationView.frame.size.width + cell.locationView.frame.origin.x + 5);
        [cell.locationView startAnimating];
        
        if (_isLocating) {
            [cell isShowGPSStatus:_isLocationFail withLocationCityName:_locationCityName];
        }
    }else{
        cell.cityNameLabel.text = _hostCities[indexPath.row];
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && !_isLocationFail) {
        self.selectCity(_locationCityName);
    }else{
        self.selectCity(_hostCities[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(self.hotCityListView.xtf_width/3, 30);
    }else{
        return CGSizeMake(self.hotCityListView.xtf_width/3 - 20, 30);
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader ]){
        reuseIdentifier = collectionHeadID;
    }
    
    TFCityListReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if (indexPath.section == 0) {
            view.sectionTitleLabel.text = @"定位城市";
        }else{
            view.sectionTitleLabel.text = @"热门城市";
        }
    }
    
    return view;
}

//返回头headerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(TFMainScreen_Width, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.minimumLineSpacing = 5;
    return UIEdgeInsetsMake(5, 10, 5, 10);
}
@end
