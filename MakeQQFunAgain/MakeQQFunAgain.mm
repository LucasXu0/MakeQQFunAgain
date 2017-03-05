#import <CaptainHook/CaptainHook.h>
#import <Cycript/Cycript.h>
#import <UIKit/UIKit.h>
#import "XRKSettingsViewController.h"
#import "XRKQQInfos.h"
#import <Foundation/Foundation.h>

#define CYCRIPT_PORT 8888

CHDeclareClass(UIApplication)
CHDeclareClass(QQAddressBookAppDelegate)
CHDeclareClass(QQMessageRecallModule)
CHDeclareClass(RecallModel)
CHDeclareClass(QQAccountsModel)
CHDeclareClass(QQSettingsViewController)

// 监听 Cycript 8888 端口
CHOptimizedMethod2(self, void, QQAddressBookAppDelegate, application, UIApplication *, application, didFinishLaunchingWithOptions, NSDictionary *, options)
{
    CHSuper2(QQAddressBookAppDelegate, application, application, didFinishLaunchingWithOptions, options);
    NSLog(@"## Start Cycript ##");
    CYListenServer(CYCRIPT_PORT);
}

CHOptimizedMethod2(self, void, QQMessageRecallModule, handleRecallNotify, RecallModel *, arg1, isOnline, _Bool, arg2){
    if ([XRKQQInfos sharedInstance].recallStatus) {
        return ;
    }
    CHSuper2(QQMessageRecallModule, handleRecallNotify, arg1, isOnline, arg2);
}

// QQ Level
CHOptimizedMethod0(self, unsigned int, QQAccountsModel, level){
    return [XRKQQInfos sharedInstance].qqLevel;
}

CHOptimizedMethod0(self, NSString *, QQAccountsModel, description){
    return [NSString stringWithFormat:@"%p", self];
}

// QQ Setting
CHOptimizedMethod1(self, NSInteger, QQSettingsViewController, numberOfSectionsInTableView, UITableView *, tableView){
    return 4;
}

CHOptimizedMethod2(self, UITableViewCell *, QQSettingsViewController, tableView, UITableView *, tableView, cellForRowAtIndexPath, NSIndexPath *, indexPath){
    if (indexPath.section == 3){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"xrk_cell"];
        cell.textLabel.text = @"自定义操作";
        return cell;
    }
    return CHSuper2(QQSettingsViewController, tableView, tableView, cellForRowAtIndexPath, indexPath);
}

CHOptimizedMethod2(self, UITableViewCell *, QQSettingsViewController, tableView, UITableView *, tableView, didSelectRowAtIndexPath, NSIndexPath *, indexPath){
    if (indexPath.section == 3){
        UINavigationController *nav = [self valueForKey:@"navigationController"];
        XRKSettingsViewController *settingsVC = [[XRKSettingsViewController alloc] init];
        [nav pushViewController:settingsVC animated:NO];
    }
    return CHSuper2(QQSettingsViewController, tableView, tableView, didSelectRowAtIndexPath, indexPath);
}

CHConstructor // code block that runs immediately upon load
{
    @autoreleasepool
    {
        CHLoadLateClass(QQAddressBookAppDelegate);  // load class (that will be "available later")
        CHHook2(QQAddressBookAppDelegate, application, didFinishLaunchingWithOptions); // register hook
        
        // QQ 撤回
        CHLoadLateClass(QQMessageRecallModule);
        CHHook2(QQMessageRecallModule, handleRecallNotify, isOnline);
        
        // QQ level
        CHLoadLateClass(QQAccountsModel);
        CHHook0(QQAccountsModel, level);
        CHHook0(QQAccountsModel, description);
        
        // QQ Setting
        CHLoadLateClass(QQSettingsViewController);
        CHHook1(QQSettingsViewController, numberOfSectionsInTableView);
        CHHook2(QQSettingsViewController, tableView, cellForRowAtIndexPath);
        CHHook2(QQSettingsViewController, tableView, didSelectRowAtIndexPath);
        
    }
}
