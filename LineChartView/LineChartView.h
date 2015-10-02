//
//  LineChartView.h
//   
//
//  Created by xiaohaibo on 10/2/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChartView : UIView

@property(retain,nonatomic) NSArray  *dataArray;//data source to be diplayed
@property(retain,nonatomic) NSString *xLegend;
@property(retain,nonatomic) NSString *yLegend;
@property(retain,nonatomic) NSArray  *xAxisTitleArray;
@property(retain,nonatomic) NSNumber *yAxisScale;

@end
