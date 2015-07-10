//
//  JHDataDetailViewController.m
//  ElectronicBook
//
//  Created by gan on 7/6/15.
//  Copyright (c) 2015 wonder. All rights reserved.
//

#import "JHDataDetailViewController.h"
#import "JHChangeCellAlertView.h"
#import "BaseBill.h"
#import "BaseBillManager.h"
#import "AppDelegate.h"

@interface JHDataDetailViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *isIncome;

@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *remarkLabel;
@property (weak, nonatomic) IBOutlet UITextField *typeLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueLabel;

@property (assign, nonatomic, getter=isNew)  BOOL isNew;

// 数据库管理者
@property (nonatomic, strong) BaseBillManager *baseBillManager;

// 模型数据     如果为空就创建，不为空就不创建。
@property (nonatomic, strong) BaseBill *baseBill;


- (IBAction)backBtnClick:(id)sender;


@end

@implementation JHDataDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //NSLog(@"JHDataDetailViewController");
    //初始化一个baseBillManager
    AppDelegate *dele =  [UIApplication sharedApplication].delegate  ;
    self.baseBillManager = dele.baseBillManager;
    [self setViewValues];
}





- (IBAction)backBtnClick:(id)sender {// 让窗口消失，
    //提示保存数据
    JHChangeCellAlertView *alertView = [[JHChangeCellAlertView alloc]initWithTitle:@"确定要退出吗" message:@"点击取消不保存数据，点击确定将保存数据" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
        
   }


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 如果是取消，直接退出
    if (buttonIndex == 0) {
        
    } else if(buttonIndex == 1){
    // 如果是确定，将数据保存起来
    // 保存数据到数据库中
        [self performSelectorInBackground:@selector(saveData) withObject:nil];
        
    }
      // 让modal消失
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
    
   
}



// 保存数据
- (void) saveData{
   
  //  NSString *timeText = self.timeLabel.text;
    NSString *inCome = [NSString stringWithFormat:@"%ld", (long)self.isIncome.selectedSegmentIndex ] ;
    NSString *name = self.nameLabel.text;
    NSString *remark = self.remarkLabel.text;
    NSString *type = self.typeLabel.text;
    NSString *value = self.valueLabel.text;
    if (self.baseBill == nil) {
        // 创建

        self.baseBill = (BaseBill *)[self.baseBillManager createBill];


    }
    // 1设置时间
    // 1.1 创建一个时间对象
    NSDate *date = [NSDate date];
  //  NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-1*60*60*24];
    // 
    self.baseBill.date = date;
    // 设置收入
    self.baseBill.isIncome = [NSNumber numberWithFloat:[inCome floatValue]];
    // 设置条目名字
    self.baseBill.name = name;
    // 设置备注
    self.baseBill.remark = remark;
    // 设置类型
    self.baseBill.type = type;
    // 设置金额
    self.baseBill.value = [NSNumber numberWithFloat:[value floatValue]];
    
    [self.baseBillManager saveBill];
  //  NSLog(@"save data success");
    // 当保存好数据后要重新刷新数据
    // 通知代理对象
    if ([self.delegate respondsToSelector:@selector(dataDetailViewConttrollerDidDataDetail:andBaseBill: andIsNew:)]) {
        [self.delegate dataDetailViewConttrollerDidDataDetail:self andBaseBill:self.baseBill andIsNew:self.isNew];
    }
    
}


// 隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 让键盘消失
    [self.view endEditing:YES];
}
- (instancetype)init{
    if (self = [super init]) {
        _isNew = YES;
    }
    return self;
}
// 利用model 初始化参数
- (instancetype)initWithBaseBill: (BaseBill *) baseBill{
    if (self = [super init]) {
       
        // 模型
        // 传过来baseBill 就变成fault属性了。
        _baseBill = baseBill;
        self.isNew = NO;
        // 时间
        //_baseBill.date = nil;
        //_baseBill.date = [NSDate date];
        
        // 这些属性到这儿是为空的，也就是说不能在这里赋值 iOS具有xib模型的view是在什么时候初始化的
    }
    return  self;
}

// 设置modal
- (void)setViewValues{
    // 时间, 用写的那个时间方法来弄。
    if (self.baseBill.date == nil) {
        
        self.timeLabel.text = [self getDate:[NSDate date]];
        // 创建一个明天的时间
      //  self.timeLabel.text = [self getDate:  [NSDate dateWithTimeIntervalSinceNow:1*60*60*24]];
    }else{
        self.timeLabel.text = [self getDate:_baseBill.date];
    }
    
    if (_baseBill == nil) {
        return;
    }
    // 收入
    self.isIncome.selectedSegmentIndex =[_baseBill.isIncome longValue];
    // 名字
    self.nameLabel.text = _baseBill.name;
    // 备注
    self.remarkLabel.text = _baseBill.remark;
    // 类型
    self.typeLabel.text = _baseBill.type;
    // 金额
    self.valueLabel.text = [_baseBill.value stringValue];

}

// 设置时间
- (NSString *) getDate: (NSDate *) date  {
    
    //创建日间初始化对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy/MM/dd"];
    if (date == nil) {
        date = [NSDate date];
        //
    }
    NSString *dateNeed = [dateFormatter stringFromDate:date];
    return dateNeed;
}


@end
