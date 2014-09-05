//
//  NewsCell.m
//  Newss
//
//  Created by xingJH on 14-9-1.
//  Copyright (c) 2014年 Janlent. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.newsImage.layer.borderColor = [UIColor grayColor].CGColor;
    self.newsImage.layer.borderWidth = 1;
    self.newsImage.layer.cornerRadius = 3;
}

-(void)downImage:(NSString*)imageStr{
    dispatch_queue_t myQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(myQueue, ^{
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageStr]]];
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        request = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.newsImage.image = [UIImage imageWithData:returnData];
        });
    });
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
