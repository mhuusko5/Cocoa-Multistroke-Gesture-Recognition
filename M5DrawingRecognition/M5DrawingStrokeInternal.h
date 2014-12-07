//
//  M5DrawingStrokeInternal.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5DrawingStroke.h"

@interface M5DrawingStroke ()

#pragma mark - M5DrawingStroke Internal -

@property (strong, nonatomic, readwrite) NSMutableArray *points;

- (int)pointCount;
- (M5DrawingPoint *)pointAtIndex:(int)i;
- (void)insertPoint:(M5DrawingPoint *)point atIndex:(int)i;

#pragma mark -

@end