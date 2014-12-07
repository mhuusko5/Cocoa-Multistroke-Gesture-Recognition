//
//  M5DrawingTemplateInternal.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M5DrawingUtilitiesInternal.h"

@interface M5DrawingTemplate : NSObject <NSCopying, NSCoding>

#pragma mark - M5DrawingTemplate Internal -

@property M5DrawingStroke *stroke;
@property M5DrawingStroke *originalStroke;
@property M5DrawingPoint *startUnitVector;

- (id)initWithPoints:(M5DrawingStroke *)points;

#pragma mark -

@end
