//
//  XRKSettingsViewController.m
//  hookwechat
//
//  Created by TsuiYuenHong on 2017/3/4.
//
//

#import "XRKSettingsViewController.h"
#import "XRKQQInfos.h"

#define CurrentViewSize self.view.frame.size
#define CurrentViewOrigin self.view.frame.origin

@interface XRKSettingsViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *levelTextField;
@property (nonatomic, strong) UILabel *recallStatusLabel;
@property (nonatomic, strong) UISwitch *recallStatusSwitch;
@end

@implementation XRKSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.levelTextField];
    [self.view addSubview:self.recallStatusLabel];
    [self.view addSubview:self.recallStatusSwitch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITextField *)levelTextField{
    if (!_levelTextField) {
        _levelTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, CurrentViewSize.width - 40, 30)];
        _levelTextField.delegate = self;
        _levelTextField.placeholder = @"输入 QQ 等级 ...";
    }
    return _levelTextField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [XRKQQInfos sharedInstance].qqLevel  = textField.text.intValue;
}

- (UILabel *)recallStatusLabel{
    if (!_recallStatusLabel) {
        _recallStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 130, CurrentViewSize.width - 120, 30)];
        _recallStatusLabel.text = @"防撤回模式";
    }
    return _recallStatusLabel;
}

- (UISwitch *)recallStatusSwitch{
    if (!_recallStatusSwitch) {
        _recallStatusSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(CurrentViewSize.width - 70, 130, 50, 30)];
        _recallStatusSwitch.on = YES;
        [_recallStatusSwitch addTarget:self action:@selector(changeRecallStatus:) forControlEvents:UIControlEventValueChanged];
    }
    return _recallStatusSwitch;
}

- (void)changeRecallStatus:(UISwitch *)recallStatusSwitch{
    [XRKQQInfos sharedInstance].recallStatus = recallStatusSwitch.isOn;
}

@end
