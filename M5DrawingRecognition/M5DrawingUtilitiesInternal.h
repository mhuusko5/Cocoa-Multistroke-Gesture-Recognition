//
//  M5DrawingUtilitiesInternal.h
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

#import "M5DrawingStrokeInternal.h"
#import "M5DrawingPointInternal.h"

#pragma mark - M5DrawingUtilitiesInternal -

#define M5DUBoundingBoxSize 1000.0f

#define M5DUGoldenRatio (0.5 * (-1.0 + sqrt(5.0)))

#define M5DUStartVectorDelay 2
#define M5DUStartVectorLength 10

#define M5DUMinimumPointCount 13

#define M5DUScaleLeniency 0.25f

#define M5DUResampledStrokePointCount 160

#define M5DUGoldenRatioAngleLeniency 30.0f

#define M5DUStartAngleLeniency 40.0f

#define M5DUGoldenRatioDegreeConstant 2.0f

float M5DUDistanceAtBestAngle(M5DrawingStroke *inputPoints, M5DrawingStroke *matchPoints);
NSMutableArray *M5DUHeapPermute(int count, NSMutableArray *order, NSMutableArray *newOrders);
NSMutableArray *M5DUMakeUnistrokes(NSMutableArray *strokes, NSMutableArray *orders);
M5DrawingStroke *M5DURotateBy(M5DrawingStroke *points, float radians);
M5DrawingStroke *M5DUResample(M5DrawingStroke *points);
M5DrawingStroke *M5DUScale(M5DrawingStroke *points);
M5DrawingStroke *M5DUTranslateToOrigin(M5DrawingStroke *points);
float M5DUAngleBetweenUnitVectors(M5DrawingPoint *unitVector1, M5DrawingPoint *unitVector2);
float M5DUPathDistance(M5DrawingStroke *points1, M5DrawingStroke *points2);
M5DrawingPoint *M5DUCalcStartUnitVector(M5DrawingStroke *points);
CGRect M5DUBoundingBox(M5DrawingStroke *points);
float M5DUDistanceAtAngle(M5DrawingStroke *recognizingPoints, M5DrawingStroke *matchPoints, float radians);
float M5DURoundToDigits(float number, int decimals);
float M5DUDegreesToRadians(float degrees);
float M5DURadiansToDegrees(float radians);
float M5DUPathLength(M5DrawingStroke *points);
float M5DUDistance(M5DrawingPoint *point1, M5DrawingPoint *point2);
M5DrawingPoint *M5DUCentroid(M5DrawingStroke *points);

#pragma mark -
