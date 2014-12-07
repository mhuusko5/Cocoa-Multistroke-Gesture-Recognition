//
//  M5DrawingRecognizer.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M5DrawingGesture.h"
#import "M5DrawingResult.h"

@interface M5DrawingRecognizer : NSObject

#pragma mark - M5DrawingRecognizer -

- (M5DrawingResult *)recognizeGestureWithStrokes:(NSMutableArray *)strokes;
- (M5DrawingGesture *)loadGestureWithIdentity:(NSString *)identity strokes:(NSMutableArray *)strokes;
- (void)loadGesture:(M5DrawingGesture *)gesture;
- (void)unloadGestureWithIdentity:(NSString *)identity;

- (NSArray *)loadedGestures;

#pragma mark -

@end
