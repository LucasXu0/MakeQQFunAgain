//
//  XRKQQInfos.h
//  hookwechat
//
//  Created by TsuiYuenHong on 2017/3/4.
//
//

#import <Foundation/Foundation.h>

@interface XRKQQInfos : NSObject

// QQ Level
@property (nonatomic, assign) unsigned int qqLevel;

// 撤回标记
@property (nonatomic, assign) BOOL recallStatus;

+ (instancetype)sharedInstance;
@end
