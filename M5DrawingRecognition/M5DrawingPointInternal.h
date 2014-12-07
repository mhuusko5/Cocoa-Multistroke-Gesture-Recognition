//
//  M5DrawingPointInternal.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5DrawingPoint.h"

@interface M5DrawingPoint ()

#pragma mark - M5DrawingPoint Internal -

@property (assign, nonatomic, readwrite) float x, y;
@property (assign, nonatomic, readwrite) int strokeId;

#pragma mark -

@end