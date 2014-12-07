//
//  M5DrawingResultInternal.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5DrawingResult.h"

@interface M5DrawingResult ()

#pragma mark - M5DrawingResult Internal -

@property (strong, nonatomic, readwrite) NSString *gestureIdentity;
@property (assign, nonatomic, readwrite) int score;

#pragma mark -

@end