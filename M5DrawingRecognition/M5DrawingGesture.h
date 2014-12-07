//
//  M5DrawingGesture.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "M5DrawingUtilitiesInternal.h"
#import "M5DrawingTemplateInternal.h"

@interface M5DrawingGesture : NSObject <NSCopying, NSCoding>

#pragma mark - M5DrawingGesture -

@property (strong, nonatomic, readonly) NSString *identity;

#pragma mark -

@end
