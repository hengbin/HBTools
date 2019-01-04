//
//  HBImagePickerController.m
//  HBTools
//
//  Created by 花生酱 on 03/01/2019.
//  Copyright © 2019 花生酱. All rights reserved.
//

#import "HBImagePickerController.h"

@interface HBImagePickerController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation HBImagePickerController

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender: (id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
