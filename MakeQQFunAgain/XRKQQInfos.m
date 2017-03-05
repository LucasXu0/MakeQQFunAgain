//
//  XRKQQInfos.m
//  hookwechat
//
//  Created by TsuiYuenHong on 2017/3/4.
//
//

#import "XRKQQInfos.h"

@implementation XRKQQInfos
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static XRKQQInfos *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [XRKQQInfos new];
        _instance.recallStatus = YES;
    });
    return _instance;
}
@end
