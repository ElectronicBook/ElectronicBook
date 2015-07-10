//
//  MySehmented.h
//  ElectronicBook
//
//  Created by 你 on 15-7-10.
//  Copyright (c) 2015年 wonder. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonClickDeledate <NSObject>

- (IBAction)click;

@end

@interface MySehmented : UISegmentedControl

@property (strong, nonatomic) id<ButtonClickDeledate> deledate;

- (instancetype) initWithMyframe:(CGRect)frame;

@end
