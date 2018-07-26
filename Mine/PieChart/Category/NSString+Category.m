//
//  NSString+Category.m
//  Mine
//
//  Created by Facebook on 2018/7/26.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
- (CGRect)stringWidthRectWithSize:(CGSize)size font:(UIFont *)font{
    NSDictionary * attributes = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}
@end
