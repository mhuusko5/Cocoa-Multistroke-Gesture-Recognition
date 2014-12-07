//
//  M5DrawingResult.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M5DrawingResult : NSObject

#pragma mark - M5DrawingResult -

@property (strong, nonatomic, readonly) NSString *gestureIdentity;
@property (assign, nonatomic, readonly) int score;

#pragma mark -

@end
