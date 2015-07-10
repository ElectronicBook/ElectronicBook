//
//  JHOneTableViewCell.m
//  ElectronicBook
//
//  Created by gan on 7/3/15.
//  Copyright (c) 2015 wonder. All rights reserved.
//

#import "JHOneTableViewCell.h"
#import "BaseBill.h"

@interface JHOneTableViewCell()


@end
@implementation JHOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 设置模型
- (void)setBaseBill:(BaseBill *)baseBill{
    _baseBill = baseBill;
    self.comodity.text = _baseBill.name;
    if ([baseBill.isIncome intValue] == 1) {
        self.consume.text = [_baseBill.value stringValue];
    }
    else{
        NSString *text = @"-";
        if ([_baseBill.value intValue] == 0){
            text = @"";
        }
        self.consume.text = [text stringByAppendingString:[_baseBill.value stringValue]];

    }
    
}
// 设置cell里面的控件属性。
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *path = @"oneCell";
    JHOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:path];
    if (cell == nil) {
        cell = [[JHOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:path];
    }
   
  //  cell.textLabel.text = @"aaaa";
    // 根据传入的数据对cell进行初始化
   // cell.comodity.text = @"牛奶";
    //cell.consume.text = @"40.0";
    return cell;
}

// 重写initWithStyle方法，创建将来可能会使用到的控件。
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 获得父cell的frame
       // CGRect cellFrame = self.frame;
        //CGRect imageFrame = CGRectMake(cellFrame.origin.x, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height );
        
        // 初始化xib
        self = [[[NSBundle mainBundle] loadNibNamed:@"JHOneTableViewCell" owner:nil options:nil] firstObject];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.frame];
        imageView.image = [UIImage imageNamed:@"cell"];
     //   UIEdgeInsets inset = UIEdgeInsetsMake(3, 0, 3, 0);
       // [self setSeparatorInset:inset];
        self.backgroundColor = [UIColor clearColor];
//        [self setSelected:YES animated:YES];
        
       // [self.contentView addSubview:imageView];
        self.backgroundView = imageView;
        // 设置选中状态的颜色
        [self setSelectionStyle:UITableViewCellSelectionStyleBlue];
        self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellHighlighted"]];
       // self.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellHighlighted"]];
    }
    return self;
}


@end
