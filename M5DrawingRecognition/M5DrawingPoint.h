//
//  M5DrawingPoint.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M5DrawingPoint : NSObject <NSCopying, NSCoding>

#pragma mark - M5DrawingPoint -

- (id)initWithX:(float)x andY:(float)y andStrokeId:(int)strokeId;

#pragma mark -

@end
