//
//  M5DrawingGestureInternal.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5DrawingGesture.h"

@interface M5DrawingGesture ()

#pragma mark - M5DrawingGesture Internal -

@property (strong, nonatomic, readonly) NSMutableArray *strokes;
@property (strong, nonatomic, readonly) NSMutableArray *templates;

- (instancetype)initWithIdentity:(NSString *)identity strokes:(NSMutableArray *)strokes;
- (void)generateTemplates;

#pragma mark -

@end