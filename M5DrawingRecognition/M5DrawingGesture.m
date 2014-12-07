//
//  M5DrawingGesture.m
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5DrawingGestureInternal.h"

@implementation M5DrawingGesture

#pragma mark - M5DrawingGesture Internal -

- (instancetype)initWithIdentity:(NSString *)identity strokes:(NSMutableArray *)strokes {
    if (self = [super init]) {
        _identity = identity;
        _strokes = strokes;
    }

	return self;
}

- (void)generateTemplates {
	M5DrawingStroke *allPoints = M5DrawingStroke.new;
	for (M5DrawingStroke *stroke in _strokes) {
		for (M5DrawingPoint *point in stroke.points) {
			[allPoints addPoint:point];
		}
	}

	NSMutableArray *order = NSMutableArray.new;
	for (int i = 0; i < _strokes.count; i++) {
		[order insertObject:@(i) atIndex:i];
	}

	NSMutableArray *unistrokes = M5DUMakeUnistrokes(_strokes, M5DUHeapPermute((int)_strokes.count, order, NSMutableArray.new));

	_templates = NSMutableArray.new;
	for (int j = 0; j < unistrokes.count; j++) {
		[_templates addObject:[[M5DrawingTemplate alloc] initWithPoints:unistrokes[j]]];
	}
}

#pragma mark -

#pragma mark - M5DrawingGesture Private -

- (NSString *)description {
    NSMutableString *desc = NSMutableString.new;
    
    for (M5DrawingStroke *stroke in _strokes) {
        [desc appendFormat:@"%@ \r", stroke.description];
    }
    
    return desc;
}

#pragma mark -

#pragma mark - NSCoding -

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_identity forKey:@"identity"];
	[coder encodeObject:_strokes forKey:@"strokes"];
}

- (id)initWithCoder:(NSCoder *)coder {
    return [self initWithIdentity:[coder decodeObjectForKey:@"identity"] strokes:[[coder decodeObjectForKey:@"strokes"] mutableCopy]];
}

#pragma mark -

#pragma mark - NSCopying -

- (id)copyWithZone:(NSZone *)zone {
	M5DrawingGesture *copy = [[M5DrawingGesture allocWithZone:zone] initWithIdentity:_identity.copy strokes:_strokes.mutableCopy];

	return copy;
}

#pragma mark -

@end
