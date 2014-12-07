//
//  M5DrawingStroke.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M5DrawingPoint.h"

@interface M5DrawingStroke : NSObject <NSCopying, NSCoding>

#pragma mark - M5DrawingStroke -

- (id)initWithPoints:(NSMutableArray *)points;
- (void)addPoint:(M5DrawingPoint *)point;

#pragma mark -

@end
