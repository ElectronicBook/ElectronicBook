//
//  JHOneTableViewCell.h
//  ElectronicBook
//
//  Created by gan on 7/3/15.
//  Copyright (c) 2015 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseBill;
@interface JHOneTableViewCell : UITableViewCell
/**
 *  商品
 */
@property (weak, nonatomic) IBOutlet UILabel *comodity;

/**
 *  消费
 */
@property (weak, nonatomic) IBOutlet UILabel *consume;

@property (nonatomic, strong) BaseBill *baseBill;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
