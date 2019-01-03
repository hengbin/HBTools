//
//  LabelViewController.m
//  HBTools
//
//  Created by 花生酱 on 01/01/2019.
//  Copyright © 2019 花生酱. All rights reserved.
//

#import "LabelViewController.h"
#import "HBLabel.h"
#import <SDAutoLayout/SDAutoLayout.h>

NSString * const detailText = @"豫章故郡，洪都新府。星分翼轸，地接衡庐。襟三江而带五湖，控蛮荆而引瓯越。物华天宝，龙光射牛斗之墟；人杰地灵，徐孺下陈蕃之榻。雄州雾列，俊采星驰。台隍枕夷夏之交，宾主尽东南之美。都督阎公之雅望，棨戟遥临；宇文新州之懿范，襜帷暂驻。十旬休假，胜友如云；千里逢迎，高朋满座。腾蛟起凤，孟学士之词宗；紫电青霜，王将军之武库。家君作宰，路出名区；童子何知，躬逢胜饯。\n时维九月，序属三秋。潦水尽而寒潭清，烟光凝而暮山紫。俨骖騑于上路，访风景于崇阿。临帝子之长洲，得仙人之旧馆。层峦耸翠，上出重霄；飞阁流丹，下临无地。鹤汀凫渚，穷岛屿之萦回；桂殿兰宫，即冈峦之体势。";

@interface LabelViewController ()

@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel * label = [[UILabel alloc]init];
    label.textColor =[UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = detailText;
    label.backgroundColor = [UIColor cyanColor];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    label.sd_layout
    .topSpaceToView(self.navigationController.navigationBar, 10)
    .leftSpaceToView(self.view, 8)
    .rightSpaceToView(self.view, 8)
    .autoHeightRatio(0);
    
    [label updateLayout];
    
    UILabel * infoA = [UILabel new];
    
    infoA.text = [NSString stringWithFormat:@"无缩进，无格式的Label.height= %.4f",label.frame.size.height];
    infoA.backgroundColor = [UIColor blackColor];
    infoA.textColor = [UIColor whiteColor];
    infoA.textAlignment = NSTextAlignmentCenter;
    infoA.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:infoA];
    
    infoA.sd_layout
    .topSpaceToView(label, 10)
    .leftSpaceToView(self.view, 8)
    .rightSpaceToView(self.view, 8)
    .autoHeightRatio(0);
    
    
    HBLabel * labelB = [[HBLabel alloc]init];
    labelB.textColor_HB([UIColor orangeColor])
    .fontSize_HB(15)
    .textAlignment_HB(left)
    .backgroundColor_HB([UIColor cyanColor])
    .firstLineHeadIndent_HB(labelB.font.pointSize*2)
    .lineSpacing_HB(5.0)
    .paragraphSpacing_HB(12.0)
    .labelText_HB(detailText);
    labelB.numberOfLines = 0;
    labelB.isAttributedContent = YES;
    [self.view addSubview:labelB];
    
    labelB.sd_layout
    .topSpaceToView(infoA, 20)
    .leftSpaceToView(self.view, 8)
    .rightSpaceToView(self.view, 8)
    .autoHeightRatio(0);
    
    [labelB updateLayout];
    
    UILabel * infoB = [UILabel new];
    infoB.text = [NSString stringWithFormat:@"有缩进，有格式的Label.height= %.4f",labelB.frame.size.height];
    infoB.backgroundColor = [UIColor blackColor];
    infoB.textColor = [UIColor whiteColor];
    infoB.textAlignment = NSTextAlignmentCenter;
    infoB.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:infoB];
    
    infoB.sd_layout
    .topSpaceToView(labelB, 10)
    .leftSpaceToView(self.view, 8)
    .rightSpaceToView(self.view, 8)
    .autoHeightRatio(0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
