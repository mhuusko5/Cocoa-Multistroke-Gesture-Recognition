//
//  M5DrawingStroke.m
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5DrawingStrokeInternal.h"

@implementation M5DrawingStroke

#pragma mark - M5DrawingStroke -

- (id)initWithPoints:(NSMutableArray *)points {
	if (self = [super init]) {
        _points = points;
    }

	return self;
}

- (void)addPoint:(M5DrawingPoint *)point {
	[_points addObject:point];
}

#pragma mark -

#pragma mark - M5DrawingStroke Internal -

- (int)pointCount {
	return (int)_points.count;
}

- (M5DrawingPoint *)pointAtIndex:(int)i {
	return _points[i];
}

- (void)insertPoint:(M5DrawingPoint *)point atIndex:(int)i {
	[_points insertObject:point atIndex:i];
}

#pragma mark -

#pragma mark - M5DrawingStroke Private -

- (id)init {
    if (self = [super init]) {
        _points = NSMutableArray.new;
    }
    
    return self;
}

- (NSString *)description {
    NSMutableString *desc = NSMutableString.new;
    
    for (M5DrawingPoint *point in _points) {
        [desc appendFormat:@"%@ \r", point.description];
    }
    
    return desc;
}

#pragma mark -

#pragma mark - NSCoding -

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:_points forKey:@"points"];
}

- (id)initWithCoder:(NSCoder *)coder {
	return [self initWithPoints:[[coder decodeObjectForKey:@"points"] mutableCopy]];
}

#pragma mark -

#pragma mark - NSCopying -

- (id)copyWithZone:(NSZone *)zone {
	M5DrawingStroke *copy = [[M5DrawingStroke allocWithZone:zone] initWithPoints:_points.mutableCopy];

	return copy;
}

#pragma mark -

@end
