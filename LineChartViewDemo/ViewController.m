//
//  ViewController.m
//  LineChartViewDemo
//
//  Created by xiaohaibo on 10/2/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//
#import "LineChartView.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    LineChartView* chartView = [[LineChartView alloc]initWithFrame: CGRectMake(30, 50, self.view.frame.size.width, 200)];
    
    chartView.dataArray = @[[NSNumber numberWithInt:12],[NSNumber numberWithInt:9],[NSNumber numberWithInt:1],[NSNumber numberWithInt:19],[NSNumber numberWithInt:22],[NSNumber numberWithInt:-32],[NSNumber numberWithInt:-2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:-32],[NSNumber numberWithInt:12],[NSNumber numberWithInt:-32]];
    chartView.xAxisTitleArray =@[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11)];
    chartView.yLegend = @"Y";
    chartView.xLegend = @"X";
    
    [self.view addSubview:chartView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
