//
//  M5DrawingRecognizer.m
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5DrawingRecognizerInternal.h"

#import "M5DrawingUtilitiesInternal.h"
#import "M5DrawingGestureInternal.h"
#import "M5DrawingTemplateInternal.h"
#import "M5DrawingResultInternal.h"

@implementation M5DrawingRecognizer {
    @private
    NSMutableDictionary *_loadedGestures;
}

#pragma mark - M5DrawingRecognizer -

- (M5DrawingResult *)recognizeGestureWithStrokes:(NSMutableArray *)strokes {
    @try {
        M5DrawingStroke *currentPoints = M5DrawingStroke.new;
        for (M5DrawingStroke *stroke in strokes) {
            for (M5DrawingPoint *point in stroke.points) {
                [currentPoints addPoint:point];
            }
        }
        
        M5DrawingResult *result = M5DrawingResult.new;
        
        if (currentPoints.pointCount > M5DUMinimumPointCount) {
            M5DrawingTemplate *inputTemplate = [[M5DrawingTemplate alloc] initWithPoints:currentPoints];
            
            float lowestDistance = FLT_MAX;
            
            for (M5DrawingGesture *gestureToMatch in _loadedGestures.allValues) {
                if (gestureToMatch.strokes.count == strokes.count) {
                    NSMutableArray *loadedGestureTemplates = gestureToMatch.templates;
                    
                    for (M5DrawingTemplate *templateToMatch in loadedGestureTemplates) {
                        if (M5DUAngleBetweenUnitVectors(inputTemplate.startUnitVector, templateToMatch.startUnitVector) <= M5DUDegreesToRadians(M5DUStartAngleLeniency)) {
                            float distance = M5DUDistanceAtBestAngle(inputTemplate.stroke, templateToMatch.stroke);
                            if (distance < lowestDistance) {
                                lowestDistance = distance;
                                
                                result.gestureIdentity = gestureToMatch.identity;
                                result.score = (int)ceilf(100.0 * (1.0 - (lowestDistance / (0.5 * sqrt(2 * pow(M5DUBoundingBoxSize, 2))))));
                            }
                        }
                    }
                }
            }
        }
        
        if (result.gestureIdentity.length > 0 && result.score > 0) {
            return result;
        }
    }
    @catch (NSException *exception)
    {
        return nil;
    }
    
    return nil;
}

- (M5DrawingGesture *)loadGestureWithIdentity:(NSString *)identity strokes:(NSMutableArray *)strokes {
    M5DrawingGesture *gesture = [[M5DrawingGesture alloc] initWithIdentity:identity strokes:strokes];
    
    [gesture generateTemplates];
    
    _loadedGestures[gesture.identity] = gesture;
    
    return gesture;
}

- (void)loadGesture:(M5DrawingGesture *)gesture {
    if (!gesture || !gesture.identity || !gesture.strokes.count) {
        return;
    }
    
    if (!gesture.templates) {
        [gesture generateTemplates];
    }
    
    _loadedGestures[gesture.identity] = gesture;
}

- (void)unloadGestureWithIdentity:(NSString *)identity {
    [_loadedGestures removeObjectForKey:identity];
}

- (NSArray *)loadedGestures {
    return _loadedGestures.allValues;
}

#pragma mark -

#pragma mark - M5DrawingRecognizer Private -

- (instancetype)init {
    if (self = [super init]) {
        _loadedGestures = NSMutableDictionary.new;
    }
    
    return self;
}

#pragma mark -

@end
