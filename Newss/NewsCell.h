//
//  NewsCell.h
//  Newss
//
//  Created by xingJH on 14-9-1.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *newsTiltle;
@property (strong, nonatomic) IBOutlet UILabel *newsInfo;
@property (strong, nonatomic) IBOutlet UIImageView *newsImage;

-(void)downImage:(NSString*)imageStr;
@end
