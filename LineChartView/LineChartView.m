//
//  LineChartView.m
// 
//
//  Created by xiaohaibo on 10/2/15.
//  Copyright © 2015 xiaohaibo. All rights reserved.
//
#import "LineChartView.h"
#import <QuartzCore/QuartzCore.h>
#define xMargin 24
@interface LineChartView()
{
    double xStepLength;
    double minValue;
    double maxValue;
    double averageValue;
    double halfHeight;
}
@end

@implementation LineChartView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        halfHeight = self.frame.size.height/2;
    }
    return self;
}
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    halfHeight = frame.size.height/2;
    [self setNeedsDisplay];
}
-(void)setDataArray:(NSArray *)afistArray{
    _dataArray = afistArray;
    [self setNeedsDisplay];
}
-(void)setXAxisTitleArray:(NSArray *)ayLabelTitle{
    _xAxisTitleArray = ayLabelTitle;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    if (!self.dataArray.count) {
        
        return;
    }
    maxValue = minValue = 0;
    averageValue = 0;
    xStepLength = (self.frame.size.width - 70)/self.dataArray.count;
   
    for (NSNumber *number in _dataArray) {
        
        maxValue = MAX(number.doubleValue, maxValue);
        minValue = MIN(number.doubleValue, minValue);

    }
 
    if (maxValue == 0&&minValue ==0) {
        
        maxValue = 1;
        
    }
    averageValue = (maxValue+minValue)/2;
    
    UIColor *currentColor = [UIColor blackColor];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
    
    // line X
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextMoveToPoint(context,    10,  halfHeight);
    CGContextAddLineToPoint(context, self.frame.size.width -50, halfHeight);
    CGContextAddLineToPoint(context, self.frame.size.width -54, halfHeight-4);
    CGContextAddLineToPoint(context, self.frame.size.width -50, halfHeight);
    CGContextAddLineToPoint(context, self.frame.size.width -54, halfHeight+4);
    CGContextStrokePath(context);
    
    //add yAxis
    double halfGraph = halfHeight;
    double yNumber = 0;
    UILabel *gradationLabel = [[UILabel alloc]initWithFrame:CGRectMake(-45, halfGraph-5, 50, 15)];
    gradationLabel.backgroundColor = [UIColor clearColor];
    gradationLabel.textAlignment = NSTextAlignmentRight;
    [gradationLabel setFont:[UIFont systemFontOfSize:10]];
    [gradationLabel setAdjustsFontSizeToFitWidth:YES];
    
    
    gradationLabel.text = [NSString stringWithFormat:@"%.2f",averageValue];
    
    gradationLabel.textColor = [UIColor grayColor];
    [self addSubview:gradationLabel];
    if (!self.yAxisScale||self.yAxisScale.intValue<1||self.yAxisScale.intValue>5) {
        self.yAxisScale = @(5);
    }
    for (int i = 0; i<2; i++) {
        
        yNumber = averageValue;
        
        for (int j = 0; j<self.yAxisScale.intValue; j++) {
            double offset = (halfHeight - 9)/self.yAxisScale.doubleValue;
            if(i==0){
                halfGraph -= offset;
                yNumber +=(maxValue-averageValue)/self.yAxisScale.intValue;
               
            }
            else
            {
                halfGraph += offset;
                yNumber -=(averageValue -minValue)/self.yAxisScale.intValue;
             
            }

            CGContextSetLineWidth(context, 1.50);
            CGContextSetLineDash(context, 0, NULL, 0);
            CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
            CGContextMoveToPoint(context, 10,halfGraph);
            CGContextAddLineToPoint(context, 16, halfGraph);
            CGContextStrokePath(context);
           
            CGContextSetLineWidth(context, 0.6);
            CGFloat dashes[] = { 2, 2 };
            CGContextSetLineDash( context, 0.0, dashes, 2 );
            
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor);
            CGContextMoveToPoint(context, 10,halfGraph);
            CGContextAddLineToPoint(context, self.frame.size.width - 60, halfGraph);
            CGContextStrokePath(context);
            
            
            
            UILabel *gradationLabel = [[UILabel alloc]initWithFrame:CGRectMake(-45, halfGraph-5, 50, 15)];
            gradationLabel.backgroundColor = [UIColor clearColor];
            gradationLabel.textAlignment = NSTextAlignmentRight;
            [gradationLabel setFont:[UIFont systemFontOfSize:10]];
            [gradationLabel setAdjustsFontSizeToFitWidth:YES];
            
           
            gradationLabel.text = [NSString stringWithFormat:yNumber == yNumber?@"%.2f":@"%.2f",yNumber];
            
            gradationLabel.textColor = [UIColor grayColor];
            [self addSubview:gradationLabel];
        }
        halfGraph = halfHeight;
       
    }
    

    
    double nextX1 = xMargin - 6;
    double nextX2 = xMargin;
    for (int i = 0; i<_dataArray.count; i++) {
        
        CGContextSetLineDash(context, 0, NULL, 0);
        CGContextSetLineWidth(context, 1.5);
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextMoveToPoint(context, nextX2,halfHeight-5);
        CGContextAddLineToPoint(context, nextX2, halfHeight);
        CGContextStrokePath(context);
        nextX2 += xStepLength;
      
        
        if (self.xAxisTitleArray.count && self.xAxisTitleArray.count >= self.dataArray.count) {
            UILabel *gradationLabel = [[UILabel alloc]initWithFrame:CGRectMake(nextX1,halfHeight-2, 50, 20)];
            gradationLabel.backgroundColor = [UIColor clearColor];
            gradationLabel.textAlignment = NSTextAlignmentLeft;
            [gradationLabel setFont:[UIFont systemFontOfSize:10]];
            [gradationLabel setAdjustsFontSizeToFitWidth:YES];
            gradationLabel.text = [NSString stringWithFormat:@"%@",[_xAxisTitleArray objectAtIndex:i]];
            gradationLabel.textColor = [UIColor grayColor];
            [self addSubview:gradationLabel];
            nextX1 += xStepLength;
        }
        
    }
    
    CGContextSetLineDash(context, 0, NULL, 0);
    UILabel *xLabel = [[UILabel alloc]initWithFrame:CGRectMake(-10, -25, 100, 30)];
    xLabel.backgroundColor = [UIColor clearColor];
    [xLabel setFont:[UIFont systemFontOfSize:11]];
    xLabel.textColor = [UIColor darkGrayColor];

    xLabel.text = self.yLegend;
    [self addSubview:xLabel];
    
    CGContextSetLineDash(context, 0, NULL, 0);
    CGContextSetLineWidth(context, 2.0);
    // line Y
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextMoveToPoint(context, 10,self.frame.size.height);
    CGContextAddLineToPoint(context, 10, 0);
    CGContextAddLineToPoint(context, 6, 6);
    CGContextAddLineToPoint(context, 10, 0);
    CGContextAddLineToPoint(context, 14, 6);
    CGContextStrokePath(context);
    
    UILabel *yLabel = [[UILabel alloc]initWithFrame:CGRectMake( self.frame.size.width -54, halfHeight -5, 100, 30)];
    yLabel.backgroundColor = [UIColor clearColor];
    [yLabel setFont:[UIFont systemFontOfSize:11]];
    yLabel.textColor = [UIColor darkGrayColor];
    
    yLabel.text = self.xLegend;
    [self addSubview:yLabel];
    
    CGContextSetLineWidth(context, 1.0);
    
    
    __block double nextX = xMargin;
    double downToXline = halfHeight;
    
    //coefficient
    
    
    double coefficient = (halfHeight - 9)/(averageValue - minValue);
    if ([_dataArray[0] doubleValue]>averageValue) {
        coefficient = (halfHeight - 9)/(maxValue - averageValue);
    }
    CGMutablePathRef spadePath = CGPathCreateMutable();
    CGPathMoveToPoint(spadePath, NULL, nextX, downToXline - ([_dataArray[0] doubleValue]-averageValue)*coefficient);
    
    [_dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != 0) {
            double coefficient= 0;
            if ([obj doubleValue]>averageValue) {
                coefficient = (halfHeight - 9)/(maxValue - averageValue);
            }else{
           coefficient = (halfHeight - 9)/(averageValue - minValue);
            }
            CGPathAddLineToPoint(spadePath, NULL,nextX+xStepLength, downToXline - ([obj doubleValue]-averageValue)*coefficient);
            nextX +=xStepLength;
        }
        
    }];
    
    [[UIColor colorWithRed:139.0/255 green:178.0/255 blue:38.0/255 alpha:1] set];
    CGContextSetLineWidth(context, 1.6);
    CGContextSetLineJoin(context, kCGLineJoinRound);
 
    CGContextAddPath(context, spadePath);
    
    CGContextStrokePath(context);

    
    [[UIColor redColor] set];
    nextX = xMargin;
    downToXline = halfHeight;
    [_dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        double coefficient = (halfHeight -9)/(averageValue - minValue);
        if ([obj doubleValue]>averageValue) {
            coefficient = (halfHeight -9)/(maxValue - averageValue);
        }
        CGContextFillEllipseInRect(context, CGRectMake(nextX-3, downToXline-3 - ([obj doubleValue]-averageValue)*coefficient,6,6));
        nextX +=xStepLength;
        
    }];
 

}


@end
