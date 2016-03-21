//
//  Utils.m
//  tools
//
//  Created by jianghui yin on 13-11-13.
//  Copyright (c) 2013年 16816. All rights reserved.
//


//  gateway.sandbox.push.apple.com:2195  测试服务器
//  gateway.push.apple.com:2195          发布服务器

#import "Utils.h"

//  750有点慢
#define SCALE_IMAGE_W   320.00
#define SCALE_IMAGE_H   480.00

@implementation Utils

// 检测版本信息

#pragma mark ---> 图片相关操作
+ (UIImage *)captureImgWithSize:(CGSize)size layer:(CALayer *)layer opaque:(BOOL)opaque scale:(float)scale
{
    // 创建画布
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    
    // 渲染画布
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 生成图片
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束制作
    UIGraphicsEndImageContext();
    
    return img;
}


+ (UIImage *)scaleWithImg:(UIImage *)anImage
{
    return [Utils scaleWithImg:anImage size:CGSizeZero];
}

//  压缩图片
//  在使用CGSizeZero时设置为默认裁剪规格
+ (UIImage *)scaleWithImg:(UIImage *)anImage size:(CGSize)size
{
    if (size.width == CGSizeZero.width && size.height == CGSizeZero.height) {
        
        CGSize tempSize = anImage.size;
        
        // 图片尺寸宽和高都大于于屏幕尺寸
        if (!(tempSize.width <= SCALE_IMAGE_W && tempSize.height <= SCALE_IMAGE_H)) {
            if (tempSize.width/tempSize.height > SCALE_IMAGE_W/SCALE_IMAGE_H) {
                
                tempSize.height = (SCALE_IMAGE_W / tempSize.width) * tempSize.height;
                tempSize.width = SCALE_IMAGE_W;
            } else {
                tempSize.width = (SCALE_IMAGE_H / tempSize.height) * tempSize.width;
                tempSize.height = SCALE_IMAGE_H;
            }
        }
        size = tempSize;
    }
    //  准备绘制图片
    UIGraphicsBeginImageContext(size);
    
    //  把图片按照给定的size绘制
    [anImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //  得到当前绘制的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //  绘制结束
    UIGraphicsEndImageContext();
    
    return newImage;
}

//  克服图片旋转
+ (UIImage *)normalizedImage:(UIImage *)img
{
    if (img == UIImageOrientationUp) return img;
    UIGraphicsBeginImageContextWithOptions(img.size, NO, img.scale);
    [img drawInRect:(CGRect){0, 0, img.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}


#pragma mark ---> 检测版本
// 检测版本
+ (BOOL)checkVersionWithID:(int)appId
{
    BOOL rs = NO;
    // 当前版本
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    NSString *URL = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%d", appId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingMutableContainers error:&error];
    if (error)
    {
        NSLog(@"error -->%@", dic);
        return rs;
    }
    
    NSArray *infoArray = [dic objectForKey:@"results"];
    if ([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        
        if (![lastVersion isEqualToString:currentVersion]) {
            rs = YES;
        }
    }
    return rs;
}

#pragma mark ---- openurl

// 打开应用所在页面
+ (void)openAppUrlWithId:(int)appId
{
    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d",appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

// 打开应用评论页面
+ (void)openAppDiscussUrlWithId:(int)appId
{
    NSString *str = nil;
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    
    if (version >= 7.0) {
        str = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d", appId];
    } else {
        
        str = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",
               appId ];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


#pragma mark ---- > 验证字符串
/**
 *  过滤表情
 *
 *  @param string 输入字符串
 *
 *  @return 过滤之后的字符串
 */
+ (NSString *)filterEmoji:(NSString *)string {
    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const char *utf8 = [string UTF8String];
    char *newUTF8 = malloc( sizeof(char) * len );
    int j = 0;
    
    //0xF0(4) 0xE2(3) 0xE3(3) 0xC2(2) 0x30---0x39(4)
    for ( int i = 0; i < len; i++ ) {
        unsigned int c = utf8;
        BOOL isControlChar = NO;
        if ( c == 4294967280 ||
            c == 4294967089 ||
            c == 4294967090 ||
            c == 4294967091 ||
            c == 4294967092 ||
            c == 4294967093 ||
            c == 4294967094 ||
            c == 4294967095 ||
            c == 4294967096 ||
            c == 4294967097 ||
            c == 4294967088 ) {
            i = i + 3;
            isControlChar = YES;
        }
        if ( c == 4294967266 || c == 4294967267 ) {
            i = i + 2;
            isControlChar = YES;
        }
        if ( c == 4294967234 ) {
            i = i + 1;
            isControlChar = YES;
        }
        if ( !isControlChar ) {
            newUTF8[j] = utf8;
            j++;
        }
    }
    newUTF8[j] = '\0';
    NSString *encrypted = [NSString stringWithCString:(const char*)newUTF8
                                             encoding:NSUTF8StringEncoding];
    free( newUTF8 );
    return encrypted;
}

/**
 *  是否含有表情
 *
 *  @param string 输入字符串
 *
 *  @return 返回值
 */
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


+ (NSString *)coverNull:(NSString *)string
{
    if ([Utils isEmpty:string]) {
        return @"";
    }
    return string;
}

+ (BOOL)isEmpty:(NSString *)string
{
    if (string == nil ||
        string == NULL ||
        [string isKindOfClass:[NSNull class]] ||
        string.length < 1) {
        return YES;
    }
    return NO;
}

+ (BOOL)isUrlString:(NSString *)urlString
{
    NSString * tmp = [urlString lowercaseString];
    if ([tmp hasPrefix:@"http://"] || [tmp hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)string:(NSString *)string isGreaterThan:(NSInteger)length
{
    if (![Utils isEmpty:string] && string.length > length) {
        return YES;
    }
    return NO;
}

+ (BOOL)string:(NSString *)string greaterThan:(NSInteger)small lessThan:(NSInteger)big
{
    if (![Utils isEmpty:string] && string.length >= small && string.length <= big) {
        return YES;
    }
    return NO;
}


#pragma mark --- 字符串长度
+ (CGSize)sizeForString:(NSString *)str font:(UIFont *)font boundingSize:(CGSize)size
{
    //    [NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]
    NSDictionary * dic = @{NSFontAttributeName: font};
    CGRect rect = [str boundingRectWithSize:size
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:dic
                                    context:nil];
    //    CGSize size = [str sizeWithAttributes:dic];
    return rect.size;
}

+ (NSString *)phoneFormatWithPhoneNum:(NSString *)phone
{
    if (phone == nil || phone.length < 1) {
        return nil;
    }
    
    NSString * prefix = [phone substringToIndex:3];
    NSString * suffix = [phone substringFromIndex:7];
    
    return [NSString stringWithFormat:@"%@****%@", prefix, suffix];
}


#pragma mark ---  字符串转 16 10 8
+ (unsigned long)hexFromString:(NSString *)str
{
    unsigned long color = strtoul([str UTF8String],0,16);
    return color;
}

#pragma mark - 车牌号正则
+ (BOOL)verifyPlateNumber:(NSString *)numString
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:numString];
}


#pragma mark ---  时间转换
+ (NSString *)timeStrWithTimestamp:(NSString *)stamp formart:(NSString *)formart
{
    NSString * formartStr = formart ? formart : @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formartStr];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:stamp.integerValue];
    return [formatter stringFromDate:date];
}
#pragma mark - 数组处理
+ (NSArray *)removeEmptyForArray:(NSArray *)array
{
    NSMutableArray * res = [NSMutableArray array];
    for (id item in array) {
        if ([item isKindOfClass:[NSString class]] &&
            item != nil &&
            ((NSString *)item).length > 0) {
            [res addObject:[NSString stringWithFormat:@"%@", item]];
        }
    }
    
    return [NSArray arrayWithArray:res];
}

+ (NSArray *)imageUrlArray:(NSMutableArray *)array
{
    
    NSMutableArray * urlRes = [NSMutableArray array];
    NSMutableArray * imageRes = [NSMutableArray array];
    for (id item in array) {
        if ([item isKindOfClass:[NSString class]]) {
            [urlRes addObject:item];
        } else if ([item isKindOfClass:[UIImage class]]){
            [imageRes addObject:item];
        }
    }
    
    return @[urlRes, imageRes];
}

#pragma mark - 字符串 组数 相互转换
+ (NSArray *)arraySeparateByString:(NSString *)string   //字符串转化数组
{
    NSArray * arr = [string componentsSeparatedByString:@","];
    return  [self removeEmptyForArray:arr];
}

+ (NSMutableString *)stringSeparateBySring:(NSArray *)array  //组数转化字符串
{
    NSMutableString * tmpSring = [NSMutableString string];
    for (NSString * str in array) {
        [tmpSring appendFormat:@"%@,",str];
    }
    return tmpSring;
}
//  随机颜色
+ (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//1. 整形判断
+ (BOOL)isPureInt:(NSString *)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//2.浮点形判断：
+ (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isPureNumber:(NSString *)string
{
    if ([self isPureFloat:string]||[self isPureInt:string]) {
        return YES;
        
    }return NO;
}

+ (NSMutableAttributedString *)priceString:(NSString *)string
{
    NSArray * charArr = [string componentsSeparatedByString:@"*"];
    NSString * charStr = [charArr lastObject]; //* 后面的XXXX
    
    NSMutableAttributedString * price  = [[NSMutableAttributedString alloc] initWithString:string];
    if (string.length<1) {
        return price;
    }
    
    //价格:
    [price addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 3)];
    //120.00
    [price addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, string.length-charStr.length-4)];
    //*xxxx
    [price addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(string.length-charStr.length-1,charStr.length+1)];
    
    return price;
}

+ (NSMutableAttributedString *)specificationString:(NSString *)string
{
    
    NSMutableAttributedString * specification  = [[NSMutableAttributedString alloc] initWithString:string];
    if (string.length<1) {
        return specification;
    }
    
    [specification addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 3)];
    [specification addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, string.length-3)];
    return specification;
}

+ (id)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha
{
    NSAssert(7 == hex.length, @"Hex color format error!");
    unsigned color = 0;
    NSScanner *hexValueScanner = [NSScanner scannerWithString:[hex substringFromIndex:1]];
    [hexValueScanner scanHexInt:&color];
    int blue = color & 0xFF;
    int green = (color >> 8) & 0xFF;
    int red = (color >> 16) & 0xFF;
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (void)pasteboardForText:(NSString *)text
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = text;
}

+ (UIImage *)clipImage:(UIImage *)image imageSize:(CGSize)imageSize
{
    CGImageRef tmpRef = image.CGImage;
    CGImageRef imgRef = CGImageCreateWithImageInRect(tmpRef, CGRectMake(0, (imageSize.height-imageSize.width)/2, imageSize.width, imageSize.width));
    return [UIImage imageWithCGImage:imgRef];
}
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    NSLog(@"%@",NSStringFromCGSize(sourceImage.size));
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+(UIImage * )imageWithSourceImage:(UIImage *)image
{
    
    NSData *data = UIImagePNGRepresentation(image) ;
    
    return [UIImage imageWithData:data] ;
}

@end
