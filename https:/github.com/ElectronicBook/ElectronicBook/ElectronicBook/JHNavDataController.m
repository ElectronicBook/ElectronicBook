//
//  JHNavDataController.m
//  ElectronicBook
//
//  Created by gan on 7/3/15.
//  Copyright (c) 2015 wonder. All rights reserved.
//

#import "JHNavDataController.h"
#import "JHOneTableViewCell.h"
#import "JHTitleView.h"
#import "JHChangeCellAlertView.h"
#import "JHDataDetailViewController.h"
#import "BaseBill.h"
#import "BaseBillManager.h"
#import "AppDelegate.h"



#define JHbackgroundColor [[UIColor alloc]initWithRed:178/255.0 green:54/255.0 blue:0 alpha:1.0]

@interface JHNavDataController ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate, JHDataDetailViewControllerDelegate, JHTitleViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *billList;

@property (nonatomic, strong)  BaseBillManager *baseBillManager;

@property (nonatomic, copy) NSString *dateFlag;

@property (nonatomic, strong) NSMutableArray *dataAll;
//@property (nonatomic, copy)NSString *dateNeed;
//总收入
@property (weak, nonatomic) IBOutlet UILabel *daySumIncome;
// 实际收入
@property (weak, nonatomic) IBOutlet UILabel *daySum;
// 实际支出
@property (weak, nonatomic) IBOutlet UILabel *daySumOutcome;


@end

@implementation JHNavDataController


// 懒加载
- (NSMutableArray *) billList{
//    // 清空_billList, 我觉得当navBar的时间被点击的时候这个时候清空它，然后再赋值。
//    _billList = nil;
//    // 将数据全部取出来
//    NSArray *array = [_baseBillManager selectBills:nil];
//    // 取出array中符合时间的模型，将其赋值给_billList
//    if (_billList == nil) {
//       
//        _billList = [_baseBillManager selectBills:nil];
//       
//        // 名字赋值
//       
//    }
    
    // 如果dateNeed为空，则说明程序刚启动，为它创建一个对象
    if (self.dateFlag == nil) {
        self.dateFlag = [self getDate:[NSDate date]];
    }
    if (_billList == nil) {
        // 根据dateNeed 与所有模型进行查找，找到就可以。
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.dataAll.count ];
        
        float sumIncome = 0;
        float sumOutcome = 0;
        for (BaseBill *bill in self.dataAll) {
            // 如果该bill的timeDate是我所想要的，就将它添加到我们的_billList的数组中
            NSString *dateTemp = [self getDate:bill.date];
            if ([self.dateFlag isEqualToString:dateTemp]) {
                [arrayM addObject:bill];
                if ([bill.isIncome intValue] == 0) {
                    sumIncome += [bill.value floatValue];
                }else{
                    sumOutcome += [bill.value floatValue];
                }
            }
        }
        // 设置label
        self.daySum.text = [NSString stringWithFormat: @"%0.2f",(sumIncome - sumOutcome)];
        self.daySumIncome.text = [NSString stringWithFormat:@"%0.2f", sumIncome];
        self.daySumOutcome.text = [NSString stringWithFormat:@"%0.2f", sumOutcome];
        _billList = arrayM;
    }
    //
    return _billList;
}

// 获取时间
- (NSString *) getDate: (NSDate *) date {
    //创建日间初始化对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy/MM/dd"];
    NSString *dateNeed = [dateFormatter stringFromDate:date];
    return dateNeed;
}

- (NSMutableArray *)dataAll{
    if (_dataAll == nil) {
        _dataAll = [_baseBillManager selectBills:nil];
    }
    return _dataAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  //  UINavigationController *nav = self.navigationController;
  //  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [nav.navigationBar addSubview:button];
    
    // 设置分割线样式
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(barButtonAddClick:)];
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"editWhite-1"] highlightedImage:[UIImage imageNamed:@"editBlack-1"]]];
    
    // 创建一个数据库管理者
//    _baseBillManager = [[BaseBillManager alloc]initWithTableName:@"BaseBill"];
    AppDelegate *dele = [UIApplication sharedApplication].delegate;
    self.baseBillManager = dele.baseBillManager;
//    //新建一条新的数据模型
//    BaseBill *baseB = (BaseBill *)[_baseBillManager createBill];
//    //    修改数据模型的值
//    baseB.name = @"milk";
//    baseB.value = @(234);
//    // 利用数据库管理者保存修改过的数据
//    [_baseBillManager saveBill];
    
    // 删除数据
   // [_baseBillManager deleteBills:self.billList];
    
    //
    
    
    
    
    
    // navigationItem
    //右边的navigationItem 控件 添加按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addButton"] style:UIBarButtonItemStylePlain target:self action:@selector(barButtonAddClick:)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
   // self.navigationItem.titleView = [[UISwitch alloc]init];
    self.navigationController.navigationBar.backgroundColor = JHbackgroundColor;
    self.navigationItem.title = @"本日记帐";
    
    // 创建自定义的xib, view,要想通过xib来实现初始化自定义的view, 要通过loadNibNamed的方法来实现。  navigation bar的中间
   JHTitleView *titleView = [[[NSBundle mainBundle]loadNibNamed:@"JHTitleView" owner:nil options:nil]firstObject];
    //JHTitleView *titleView = [[JHTitleView alloc]init];
    //titleView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleView;
    
    // 成为titleView 的代理，监听当它的按钮被点击
    titleView.delegate = self;

    
    
    
//    self.navigationItem.
   // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init]
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    CGSize size = self.tableView.frame.size;
//    size.height = 1;
//    size.width = 0;
  //  self.tableView.contentSize = size;
    
    // 取消滚动动画
    // 添加table view的footer view
    
    
    // 设置tableview的头部标题
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *hlabel = [[UILabel alloc]initWithFrame:headerView.frame];
    hlabel.backgroundColor =[UIColor clearColor];
    hlabel.text = @"点击右上角新增消费项";
    // 设置字体的大小
    UIFont *myHFont = [UIFont systemFontOfSize:13];
    hlabel.font = myHFont;
    hlabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:hlabel];
    self.tableView.tableHeaderView = headerView ;
    
    
    //设置tableview的底部标题
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    footerView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:footerView.frame];
    label.backgroundColor =[UIColor clearColor];
    label.text = @"点击右上角新增消费项，移动cell, 删除cell";
    // 设置字体的大小
    UIFont *myFont = [UIFont systemFontOfSize:13];
    label.font = myFont;
    label.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:label];
    
    self.tableView.tableFooterView = footerView;
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)barButtonAddClick:(id) sender{
    JHDataDetailViewController * dataDetail = [[JHDataDetailViewController alloc]init];
    dataDetail.delegate = self;
   // NSLog(@"----%@", self.billList);
    // 当弹出的框出来后，需要更新billList中的信息。这要怎么做？这个情况是弹框完成添加任务后，想要通知这个控制器自已的任务已经完成。控制器得知这个消息后，获得到创建好的模型，将它添加到数组中，刷新表格。也就是说，这个控制器是弹窗的代理。
    [ self presentViewController:dataDetail animated:YES completion:^{
        [self performSelectorInBackground:@selector(getData) withObject:nil];
        self.billList = [self.baseBillManager selectBills:nil];
      
        //[self.tableView reloadData];
        
    }];
    
    
  //  NSLog(@"----%@", self.billList);

 /*
    UIViewController *control = [[UIViewController alloc]init];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
    //view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default"]];
    view.backgroundColor = JHbackgroundColor;
    // 设置view的背景图片
    control.view = view;
    [self.navigationController pushViewController:control animated:YES];
    self.navigationController.navigationBarHidden = NO;
  */

}
- (void)getData{
     self.billList = [self.baseBillManager selectBills:nil];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.billList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 创建cell
    JHOneTableViewCell *cell = [JHOneTableViewCell cellWithTableView:tableView];
    //对cell赋值
    cell.baseBill = self.billList[indexPath.row];
    // 返回cell
    return cell;
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //当用户点击的时候，会进入修改商品内容的界面。由于内容多，所以显示一个新的界面来修改。带上cell的参数，进行该界面的赋值
    //以modal的形式弹出
    
   // JHDataDetailViewController * dataDetail = [[JHDataDetailViewController alloc]initWithBaseBill: (BaseBill *) _billList[indexPath.row] ];
    
    
    // 再从数据库中读取一遍数据
   // self.billList = [self.baseBillManager selectBills:nil];
    JHDataDetailViewController * dataDetail = [[JHDataDetailViewController alloc]initWithBaseBill:  _billList[indexPath.row] ];
    dataDetail.delegate = self;
   [ self presentViewController:dataDetail animated:YES completion:^{
        // 刷新表格
       //[tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];

       [tableView reloadData];
   }];
    
    
    /*
    // 创建一个自定义的UIAlertView,
    JHChangeCellAlertView *alertView = [[JHChangeCellAlertView alloc]initWithTitle:@"请修改你要修改的内容﹕" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    UITextField *textView1 = [alertView textFieldAtIndex:0];

    // 获得到当前的cell
    JHOneTableViewCell *cell = (JHOneTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    textView1.placeholder = @"商品﹕";
    textView1.clearButtonMode = UITextFieldViewModeAlways;
    
    
    textView1.text = cell.comodity.text;
    UITextField *textView2 = [alertView textFieldAtIndex:1];
    textView2.text = cell.consume.text;
    textView2.placeholder = @"金额:";
    textView2.clearButtonMode = UITextFieldViewModeAlways;
    //键盘
    textView2.keyboardType = UIKeyboardTypeDecimalPad;
    [textView2 setSecureTextEntry:NO];
    // 让alertView 显示出来.
    // 将第几个cell赋给alertView的tag, 以实现在那边的定位
    alertView.tag = indexPath.row;
    [alertView show];
     */
}

/*
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {// 点击确定，将数据写到cell中，并刷新tableview
       // NSLog(@"Click YES");
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:alertView.tag inSection:0];
        JHOneTableViewCell *cell = (JHOneTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        //cell.comodity.text = [alertView textFieldAtIndex:0].text;
       // cell.consume.text = [alertView textFieldAtIndex:1].text;
        //刷新表格
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
        
    }
}
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 数据库从数据库中删除。
    [self.baseBillManager deleteBills:@[self.billList[indexPath.row]]];
    //[self.baseBillManager delete:];
   
    float sumIncome = 0;
    float sumOutcome = 0;
    for (BaseBill *bill in self.dataAll) {
        // 如果该bill的timeDate是我所想要的，就将它添加到我们的_billList的数组中
        NSString *dateTemp = [self getDate:bill.date];
        if ([self.dateFlag isEqualToString:dateTemp]) {
            if ([bill.isIncome intValue] == 0) {
                sumIncome += [bill.value floatValue];
            }else{
                sumOutcome += [bill.value floatValue];
            }
        }
    }
    // 设置label
    self.daySum.text = [NSString stringWithFormat: @"%0.2f",(sumIncome - sumOutcome)];
    self.daySumIncome.text = [NSString stringWithFormat:@"%0.2f", sumIncome];
    self.daySumOutcome.text = [NSString stringWithFormat:@"%0.2f", sumOutcome];

    
    
     // 删除数组中的数据
    [self.billList removeObjectAtIndex:indexPath.row];
    [self.dataAll removeObjectAtIndex:indexPath.row];
    // 删除cell
   // JHOneTableViewCell *cell = (JHOneTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    // 刷新cell
   // [self.tableView reloadData];
  
}

#pragma  mark - JHDataDetailViewControllerDelegate
-(void)dataDetailViewConttrollerDidDataDetail:(JHDataDetailViewController *)dataDetail andBaseBill:(BaseBill *)baseBill andIsNew:(BOOL) isNew{
    if (isNew) {
        [self.billList addObject:baseBill];
        [self.dataAll addObject:baseBill];
        // 刷新表格
        
        
    }
    /*
    // 不是新的，就是以前有的，就是修改以前的数据，所以说先删除以前的数据，在加上修改后的数据，那以前的数据呢，谁知道！我还是从前计算一次得了。
    float sumIncome = [self.daySumIncome.text floatValue];
    float sumOutcome = [self.daySumOutcome.text floatValue];
    if ([baseBill.isIncome intValue] == 0) {
        sumIncome += [baseBill.value floatValue];
    }else{
        sumOutcome += [baseBill.value floatValue];
    }
    // 设置label
    self.daySum.text = [NSString stringWithFormat: @"%0.2f",(sumIncome - sumOutcome)];
    self.daySumIncome.text = [NSString stringWithFormat:@"%0.2f", sumIncome];
    self.daySumOutcome.text = [NSString stringWithFormat:@"%0.2f", sumOutcome];
    */
    float sumIncome = 0;
    float sumOutcome = 0;
    for (BaseBill *bill in self.dataAll) {
        // 如果该bill的timeDate是我所想要的，就将它添加到我们的_billList的数组中
        NSString *dateTemp = [self getDate:bill.date];
        if ([self.dateFlag isEqualToString:dateTemp]) {
                      if ([bill.isIncome intValue] == 0) {
                sumIncome += [bill.value floatValue];
            }else{
                sumOutcome += [bill.value floatValue];
            }
        }
    }
    // 设置label
    self.daySum.text = [NSString stringWithFormat: @"%0.2f",(sumIncome - sumOutcome)];
    self.daySumIncome.text = [NSString stringWithFormat:@"%0.2f", sumIncome];
    self.daySumOutcome.text = [NSString stringWithFormat:@"%0.2f", sumOutcome];

    [self.tableView reloadData];

   
}

#pragma mark - JHTitleViewDelegate
- (void)titleView:(JHTitleView *)titleView andTitleText:(NSString *) dateNeed{
    NSLog(@"JHTitleViewDelegate");
    // 根据传入的时间，与数据库的时间进行对比，如果相等，就明数据库中有数据。就将数据取出来，显示cell.
    // 1. 取出数据库中的所有数据(已经取出来，不对，取出来的只是当天的数据在_billList中，)
//    [self.baseBillManager selectBills:NSPredicate *]  这个是根据:NSPredicate来取出数据，也就是说，我可以将数据库中的数据一次性全部取出来，边取出边判断该模型是否符合当天的时间，要全新修改懒加载方法。
    
    // 清空_billList, 我觉得当navBar的时间被点击的时候这个时候清空它，然后再赋值。
    _billList = nil;
    self.dateFlag = dateNeed;
    [self.tableView reloadData];

}
@end
