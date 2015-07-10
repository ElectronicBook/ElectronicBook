//
//  JHTitleView.h
//  ElectronicBook
//
//  Created by gan on 7/4/15.
//  Copyright (c) 2015 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JHTitleView;
@protocol JHTitleViewDelegate <NSObject>

@required
- (void)titleView:(JHTitleView *)titleView andTitleText:(NSString *) dateNeed;

@end
@interface JHTitleView : UIView

- (NSString *) getDate: (NSDate *) date andInterval: (NSTimeInterval )interval;

// 如设置JHTitleViewDelegate这个类型？
@property (nonatomic, assign) id<JHTitleViewDelegate> delegate;
@end
