//
//  M5DrawingTemplate.m
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5DrawingTemplateInternal.h"

@implementation M5DrawingTemplate

#pragma mark - M5DrawingTemplate Internal -

- (id)initWithPoints:(M5DrawingStroke *)points {
    if (self = [super init]) {
        _originalStroke = points;
        
        _stroke = M5DUResample(_originalStroke);
        _stroke = M5DUScale(_stroke);
        _stroke = M5DUTranslateToOrigin(_stroke);
        
        _startUnitVector = M5DUCalcStartUnitVector(_stroke);
    }

	return self;
}

#pragma mark -

#pragma mark - M5DrawingTemplate Private -

- (NSString *)description {
    NSMutableString *desc = NSMutableString.new;
    
    for (M5DrawingPoint *point in _stroke.points) {
        [desc appendFormat:@"%@ \r", point.description];
    }
    
    return desc;
}

#pragma mark -

#pragma mark - NSCoding -

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:_originalStroke forKey:@"originalStroke"];
}

- (id)initWithCoder:(NSCoder *)coder {
    return [self initWithPoints:[coder decodeObjectForKey:@"originalStroke"]];
}

#pragma mark -

#pragma mark - NSCopy -

- (id)copyWithZone:(NSZone *)zone {
	M5DrawingTemplate *copy = [[M5DrawingTemplate allocWithZone:zone] initWithPoints:_originalStroke.copy];

	return copy;
}

#pragma mark -

@end
