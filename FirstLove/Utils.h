//
//  Utils.h
//  tools
//
//  Created by jianghui yin on 13-11-13.
//  Copyright (c) 2013年 16816. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

/**
 *  过滤表情
 *
 *  @param string 输入字符串
 *
 *  @return 过滤之后的字符串
 */
+ (NSString *)filterEmoji:(NSString *)string;

/**
 *  是否含有表情
 *
 *  @param string 输入字符串
 *
 *  @return 返回值
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

#pragma mark ---> 图片相关操作
/** 根据上下文制作图片
 *  @param  size  : 图片的大小
            layer : 要绘制的图片的内容
            opaque: 是否透明
            scale : 缩放比例
 */
+ (UIImage *)captureImgWithSize:(CGSize)size
                          layer:(CALayer *)layer
                         opaque:(BOOL)opaque
                          scale:(float)scale;


/**
 *  压缩图片
 *
 *  @param anImage 图片
 *
 *  @return 压缩后的图片
 */
+ (UIImage *)scaleWithImg:(UIImage *)anImage;

/** 压缩图片
 *  @param  anImage: 要压缩的图片
            size   : 压缩后的大小
 */
+ (UIImage *)scaleWithImg:(UIImage *)anImage
                     size:(CGSize)size;

/**
 *  图片旋转
 *
 *  @param img 传入图片
 *
 *  @return 返回正常图片
 */
+ (UIImage *)normalizedImage:(UIImage *)img;

#pragma mark ---> 检测版本
/** 检测版本, 有新版本返回YES
 *
 *  @param  appId : 应用的id
 */
+ (BOOL)checkVersionWithID:(int)appId;


#pragma mark ---- openurl

// 打开应用所在页面
+ (void)openAppUrlWithId:(int)appId;

// 打开应用评论页面
+ (void)openAppDiscussUrlWithId:(int)appId;

#pragma mark ---> 检测网络


+ (id)shareReachability;

+ (BOOL) connectedToNetwork;


// 是否wifi
+ (BOOL)isEnableWIFI;
// 是否3G
+ (BOOL)isEnable3G;


#pragma mark ---- > 验证字符串
+ (NSString *)coverNull:(NSString *)string;

+ (BOOL)isEmpty:(NSString *)string;

// 是否为url
+ (BOOL)isUrlString:(NSString *)urlString;

/**
 *  限定字符串最小长度
 *
 *  @param string 字符串
 *  @param length 最小程度
 *
 *  @return result
 */
+ (BOOL)string:(NSString *)string isGreaterThan:(NSInteger)length;

/**
 *  限定字符长度
 *
 *  @param string 字符串
 *  @param small  最小长度
 *  @param big    最大长度
 *
 *  @return result
 */
+ (BOOL)string:(NSString *)string greaterThan:(NSInteger)small lessThan:(NSInteger)big;


#pragma mark --- 字符串长度
+ (CGSize)sizeForString:(NSString *)str font:(UIFont *)font boundingSize:(CGSize)size;


/**
 *  格式化手机号。如，13634567896--》136****7896
 *
 *  @param phone 手机号
 *
 *  @return 字符串
 */
+ (NSString *)phoneFormatWithPhoneNum:(NSString *)phone;


#pragma mark ---- 读取文件的mimetype

//+ (NSString *)mimeType


#pragma mark ---  字符串转 16 10 8

+ (unsigned long)hexFromString:(NSString *)str;

#pragma mark ---  时间转换
/**
 *  时间戳转时间
 *
 *  @param stamp   时间戳
 *  @param formart 时间格式， 默认 yyyy-MM-dd HH:mm:ss
 *
 *  @return string
 */
+ (NSString *)timeStrWithTimestamp:(NSString *)stamp formart:(NSString *)formart;

#pragma mark - 数组处理
+ (NSArray *)removeEmptyForArray:(NSArray *)array;  //移除空数组
/**
 *  将数组里的元素分类
 *  返回的第一个元素是url  第二个元素为image类型
 */
+ (NSArray *)imageUrlArray:(NSMutableArray *)array;

+ (NSArray *)arraySeparateByString:(NSString *)string;

//  获取随机色
+ (UIColor *)randomColor;
+ (UIColor *) colorWithHexString: (NSString *)color;

//1. 整形判断
+ (BOOL)isPureInt:(NSString *)string;

    //2.浮点形判断：
+ (BOOL)isPureFloat:(NSString *)string;
   //3  是否是数字
+ (BOOL)isPureNumber:(NSString *)string;

//  车票号正则验证
+ (BOOL)verifyPlateNumber:(NSString *)numString;

//XX:XXXX*X
+ (NSMutableAttributedString *)priceString:(NSString *)string;
//XX:XXXXXX
+ (NSMutableAttributedString *)specificationString:(NSString *)string;

+ (id)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  将文字复制到剪贴板
 *
 *  @param text 复制文字
 */
+ (void)pasteboardForText:(NSString *)text;
//根据图片的  宽度 截成正方形
+ (UIImage *)clipImage:(UIImage *)image imageSize:(CGSize)imageSize;
/* 传入一张图片根据你的给予的宽度 进行比例压缩**/
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
/**
 对图片的大小进行压缩
 */
+(UIImage * )imageWithSourceImage:(UIImage *)image ;

@end
