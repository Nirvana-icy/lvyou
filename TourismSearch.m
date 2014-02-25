//
//  TourismSearch.m
//  百度旅游
//
//  Created by Lucky on 13-3-25.
//  Copyright (c) 2013年 Hurricane. All rights reserved.
//

#import "TourismSearch.h"
#import "TourismStrategy.h"
#import "ShowView.h"
@interface TourismSearch ()
-(void)disableButton;
-(void)enableButton;
@end

@implementation TourismSearch
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化数组
    searchArray = [[NSMutableArray alloc] init];

    

	// Do any additional setup after loading the view.
    //设置页面背景——————————————————————————————————————————
    UIImage *img = [UIImage imageNamed:@"image_introbg"];
    UIColor *color = [[UIColor alloc] initWithPatternImage:img];
    self.view.backgroundColor = color;
    [color release];
    
    
    //设置左返回按钮————————————————————————————————————————————
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(7, 7, 60, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"file_tital_back_but_press"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"file_tital_back_but"] forState:UIControlStateHighlighted];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(pressBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.title = @"搜索";
    
 
    //searchbar————————————————————————————————————————
    mSearchBar = [[MySearchBar alloc] initWithFrame:CGRectMake(5, 10, 270, 30)];
    mSearchBar.backgroundColor = [UIColor clearColor];   //修改搜索框背景
    [[mSearchBar.subviews objectAtIndex:0]removeFromSuperview];  //去掉搜索框背景
    for (UIView *subview in mSearchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break; 
        }
    }
    mSearchBar.placeholder = @"搜索目的景点";
    [self.view addSubview:mSearchBar];
    [mSearchBar becomeFirstResponder];
    
    //设置语音按钮-———————————————————————————————————————————
    speakButton = [UIButton buttonWithType:UIButtonTypeCustom];
    speakButton.frame = CGRectMake(280, 10, 30, 30);
    [speakButton setImage:[UIImage imageNamed:@"image_microphone"] forState:UIControlStateNormal];
    [speakButton setImage:[UIImage imageNamed:@"image_microphone_selected"] forState:UIControlStateSelected];
    [speakButton addTarget:self action:@selector(btnMic) forControlEvents:UIControlEventTouchUpInside];
  //  [speakButton addTarget:self action:@selector(pressSpeak:) forControlEvents:UIControlEventTouchUpInside];btnMic
    [self.view addSubview:speakButton];
    
    //tableview—————————————————————————————————————————————————
    CGRect frame = CGRectMake(0, 50, 320, 480);
    mTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    mTableView.delegate =self;
    mTableView.dataSource = self;
    [self.view addSubview:mTableView];
    
    //语音部分
    NSString *param=[NSString stringWithFormat:@"server_url=http://dev.voicecloud.cn:1028/index.htm,appid=51505898"];
    _iFlyRecognizeControl=[[IFlyRecognizeControl alloc]initWithOrigin:CGPointMake(20, 70) initParam:param];
    [self.view addSubview:_iFlyRecognizeControl];
    [_iFlyRecognizeControl setEngine:@"sms" engineParam:nil grammarID:nil];
    [_iFlyRecognizeControl setSampleRate:16000];
    _iFlyRecognizeControl.delegate=self;
    //不显示log
    [_iFlyRecognizeControl setShowLog:NO];
    [param release];
    
   
    
}

//接口不对
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchbar;
{
	//键盘消失
	[searchbar resignFirstResponder];
    
    ShowView * sv = [[ShowView alloc] init];
    sv.sname = mSearchBar.text;
    //mvc.url=[NSString stringWithFormat:@"http://www.xinshipu.com/api/doSearch.html?q=%@",search.text];
    [self.navigationController pushViewController:sv animated:YES];
    [sv release];
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (0 == [searchArray count]) {
//        return 0;
//    }
    return [searchArray count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"Tourism";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cellID) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"111";
    return cell;
}

-(void)pressBack:(UIButton *)button
{
   // TourismStrategy * ts = [[TourismStrategy alloc] init];
    [self.navigationController popViewControllerAnimated:YES];


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//测试语音部分
-(void)onRecognizeEnd:(IFlyRecognizeControl *)iFlyRecognizeControl theError:(int)error
{
    NSLog(@"识别结束回调finish........");
    [self enableButton];
    //获得上传流量和下载流量 FAlSE:本次识别会话的流量，TRUE所有识别会话的流量
    NSLog(@"getUpflow:%d,getDownflow:%d",[iFlyRecognizeControl getUpflow:FALSE],[iFlyRecognizeControl getDownflow:FALSE]);
    
}
-(void)onRecognizeResult:(NSArray *)array
{
    //  在主线程中执行onUpdateTextView方法
    [self performSelectorOnMainThread:@selector(onUpdateTextView:) withObject:
	 [[array objectAtIndex:0] objectForKey:@"NAME"] waitUntilDone:YES];
}
//识别结果回调函数
-(void)onResult:(IFlyRecognizeControl *)iFlyRecognizeControl theResult:(NSArray *)resultArray
{
    [self onRecognizeResult:resultArray];
}
- (void)disableButton
{
    btn.enabled = NO;
    [mSearchBar resignFirstResponder];
	self.navigationController.navigationItem.leftBarButtonItem.enabled = NO;
}

- (void)enableButton
{
	btn.enabled = YES;
       // mSearchBar.editable = YES;
    [mSearchBar becomeFirstResponder];
    
    
	self.navigationController.navigationItem.leftBarButtonItem.enabled  = YES;
}
-(void)resignActive
{
    NSLog(@"resignActive");
    [_iFlyRecognizeControl cancel];
}

-(void)btnMic{
    if([_iFlyRecognizeControl start]){
        [self disableButton];
    }
}
- (void)onUpdateTextView:(NSString *)sentence
{
	
	NSString *str = [[NSString alloc] initWithFormat:@"%@", sentence];
	mSearchBar.text = str;
	
	NSLog(@"str");
}

-(void)dealloc
{

    btn = nil;
    mSearchBar = nil;
    speakButton = nil;
    mTableView = nil;
    searchArray = nil;
    [super dealloc];
}

@end
