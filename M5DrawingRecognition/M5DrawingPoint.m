//
//  M5DrawingPoint.m
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5DrawingPointInternal.h"

@implementation M5DrawingPoint

#pragma mark - M5DrawingPoint -

- (id)initWithX:(float)x andY:(float)y andStrokeId:(int)strokeId {
    if (self = [super init]) {
        _x = x;
        _y = y;
        _strokeId = strokeId;
    }
    
	return self;
}

#pragma mark -

#pragma mark - M5DrawingPoint Private -

- (NSString *)description {
    return [NSString stringWithFormat:@"X: %f Y: %f Stroke: %i", _x, _y, _strokeId];
}

#pragma mark -

#pragma mark - NSCoding - 

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeFloat:_x forKey:@"x"];
	[coder encodeFloat:_y forKey:@"y"];
	[coder encodeInt:_strokeId forKey:@"strokeId"];
}

- (id)initWithCoder:(NSCoder *)coder {
    return [self initWithX:[coder decodeFloatForKey:@"x"] andY:[coder decodeFloatForKey:@"y"] andStrokeId:[coder decodeIntForKey:@"strokeId"]];
}

#pragma mark -

#pragma mark - NSCopying -

- (id)copyWithZone:(NSZone *)zone {
	M5DrawingPoint *copy = [[M5DrawingPoint allocWithZone:zone] initWithX:_x andY:_y andStrokeId:_strokeId];

	return copy;
}

#pragma mark -

@end
