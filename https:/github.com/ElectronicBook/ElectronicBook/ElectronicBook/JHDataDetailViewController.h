//
//  JHDataDetailViewController.h
//  ElectronicBook
//
//  Created by gan on 7/6/15.
//  Copyright (c) 2015 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHDataDetailViewController;
@class BaseBill;

@protocol JHDataDetailViewControllerDelegate <NSObject>

@required
- (void)dataDetailViewConttrollerDidDataDetail:(JHDataDetailViewController *)dataDetail andBaseBill:(BaseBill *)baseBill andIsNew:(BOOL)isNew;
@end


@interface JHDataDetailViewController : UIViewController

@property (nonatomic, assign) id<JHDataDetailViewControllerDelegate> delegate;
- (instancetype)initWithBaseBill: (BaseBill *) baseBill;
@end
