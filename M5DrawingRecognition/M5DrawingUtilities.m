//
//  M5DrawingUtilities.m
//  M5DrawingRecognition
//
//  Created by Mathew Huusko V on 12/7/14.
//  Copyright (c) 2014 Mathew Huusko V. All rights reserved.
//

#import "M5DrawingUtilitiesInternal.h"

#pragma mark - M5DrawingUtilitiesInternal -

float M5DUDistanceAtBestAngle(M5DrawingStroke *inputPoints, M5DrawingStroke *matchPoints) {
	float minAngleRange = M5DUDegreesToRadians(-M5DUGoldenRatioAngleLeniency);
	float maxAngleRange = M5DUDegreesToRadians(M5DUGoldenRatioAngleLeniency);

	float x1 = M5DUGoldenRatio * minAngleRange + (1.0 - M5DUGoldenRatio) * maxAngleRange;
	float f1 = M5DUDistanceAtAngle(inputPoints, matchPoints, x1);
	float x2 = (1.0 - M5DUGoldenRatio) * minAngleRange + M5DUGoldenRatio * maxAngleRange;
	float f2 = M5DUDistanceAtAngle(inputPoints, matchPoints, x2);
	while (abs(maxAngleRange - minAngleRange) > M5DUDegreesToRadians(M5DUGoldenRatioDegreeConstant)) {
		if (f1 < f2) {
			maxAngleRange = x2;
			x2 = x1;
			f2 = f1;
			x1 = M5DUGoldenRatio * minAngleRange + (1.0 - M5DUGoldenRatio) * maxAngleRange;
			f1 = M5DUDistanceAtAngle(inputPoints, matchPoints, x1);
		}
		else {
			minAngleRange = x1;
			x1 = x2;
			f1 = f2;
			x2 = (1.0 - M5DUGoldenRatio) * minAngleRange + M5DUGoldenRatio * maxAngleRange;
			f2 = M5DUDistanceAtAngle(inputPoints, matchPoints, x2);
		}
	}

	return MIN(f1, f2);
}

NSMutableArray *M5DUHeapPermute(int count, NSMutableArray *order, NSMutableArray *newOrders) {
	if (count == 1) {
		[newOrders addObject:order.copy];
	}
	else {
		for (int i = 0; i < count; i++) {
			M5DUHeapPermute(count - 1, order, newOrders);
			int last = [order[(count - 1)] intValue];
			if (count % 2 == 1) {
				int first = [order[0] intValue];
				order[0] = @(last);
				order[(count - 1)] = @(first);
			}
			else {
				int next = [order[i] intValue];
				order[i] = @(last);
				order[(count - 1)] = @(next);
			}
		}
	}

	return newOrders;
}

NSMutableArray *M5DUMakeUnistrokes(NSMutableArray *strokes, NSMutableArray *orders) {
	NSMutableArray *unistrokes = NSMutableArray.new;
	for (int r = 0; r < orders.count; r++) {
		NSMutableArray *strokeOrder = orders[r];

		for (int b = 0; b < pow(2, strokeOrder.count); b++) {
			M5DrawingStroke *unistroke = M5DrawingStroke.new;

			for (int i = 0; i < strokeOrder.count; i++) {
				int strokeIndex = [strokeOrder[i] intValue];
				M5DrawingStroke *stroke = strokes[strokeIndex];

				NSMutableArray *copyOfStrokePoints = stroke.points.mutableCopy;

				NSArray *points;
				if (((b >> i) & 1) == 1) {
					points = copyOfStrokePoints.reverseObjectEnumerator.allObjects;
				}
				else {
					points = copyOfStrokePoints;
				}

				for (int p = 0; p < points.count; p++) {
					[unistroke addPoint:points[p]];
				}
			}

			[unistrokes addObject:unistroke];
		}
	}

	return unistrokes;
}

M5DrawingStroke *M5DURotateBy(M5DrawingStroke *points, float radians) {
	M5DrawingPoint *centroid = M5DUCentroid(points);
	float cosValue = cosf(radians);
	float sinValue = sinf(radians);

	M5DrawingStroke *rotatedPoints = M5DrawingStroke.new;
	for (int i = 0; i < points.pointCount; i++) {
		M5DrawingPoint *point = [points pointAtIndex:i];
		float rotatedX = (point.x - centroid.x) * cosValue - (point.y - centroid.y) * sinValue + centroid.x;
		float rotatedY = (point.x - centroid.x) * sinValue + (point.y - centroid.y) * cosValue + centroid.y;

		[rotatedPoints addPoint:[[M5DrawingPoint alloc] initWithX:rotatedX andY:rotatedY andStrokeId:point.strokeId]];
	}

	return rotatedPoints;
}

M5DrawingStroke *M5DUResample(M5DrawingStroke *points) {
	M5DrawingStroke *currentPoints = points.copy;
	M5DrawingStroke *newPoints = M5DrawingStroke.new;
	[newPoints addPoint:[points pointAtIndex:0]];

	float newPointDistance = M5DUPathLength(points) / (M5DUResampledStrokePointCount - 1);
	float initialDistance = 0.0;

	for (int i = 1; i < currentPoints.pointCount; i++) {
		M5DrawingPoint *point1 = [currentPoints pointAtIndex:(i - 1)];
		M5DrawingPoint *point2 = [currentPoints pointAtIndex:i];
		float d = M5DUDistance(point1, point2);

		if ((initialDistance + d) > newPointDistance) {
			float x = point1.x + ((newPointDistance - initialDistance) / d) * (point2.x - point1.x);
			float y = point1.y + ((newPointDistance - initialDistance) / d) * (point2.y - point1.y);

			M5DrawingPoint *newPoint = [[M5DrawingPoint alloc] initWithX:x andY:y andStrokeId:point1.strokeId];
			[newPoints addPoint:newPoint];

			[currentPoints insertPoint:newPoint atIndex:i];

			initialDistance = 0.0;
		}
		else {
			initialDistance += d;
		}
	}

	if (newPoints.pointCount < M5DUResampledStrokePointCount) {
		M5DrawingPoint *lastPoint = [points pointAtIndex:points.pointCount - 1];
		for (int j = 0; j < (M5DUResampledStrokePointCount - newPoints.pointCount); j++) {
			[newPoints addPoint:lastPoint.copy];
		}
	}

	return newPoints;
}

M5DrawingStroke *M5DUScale(M5DrawingStroke *points) {
	CGRect currentBox = M5DUBoundingBox(points);
	BOOL isLine = MIN(currentBox.size.width / currentBox.size.height, currentBox.size.height / currentBox.size.width) <= M5DUScaleLeniency;

	M5DrawingStroke *scaled = M5DrawingStroke.new;
	for (M5DrawingPoint *point in points.points) {
		float scale;
		float scaledX;
		float scaledY;
		if (isLine) {
			scale = (M5DUBoundingBoxSize / MAX(currentBox.size.width, currentBox.size.height));
			scaledX = point.x * scale;
			scaledY = point.y * scale;
		}
		else {
			scaledX = point.x * (M5DUBoundingBoxSize / currentBox.size.width);
			scaledY = point.y * (M5DUBoundingBoxSize / currentBox.size.height);
		}

		[scaled addPoint:[[M5DrawingPoint alloc] initWithX:scaledX andY:scaledY andStrokeId:point.strokeId]];
	}

	return scaled;
}

M5DrawingStroke *M5DUTranslateToOrigin(M5DrawingStroke *points) {
	M5DrawingPoint *centroid = M5DUCentroid(points);
	M5DrawingStroke *translated = M5DrawingStroke.new;

	for (int i = 0; i < points.pointCount; i++) {
		M5DrawingPoint *point = [points pointAtIndex:i];
		float translatedX = point.x - centroid.x;
		float translatedY = point.y - centroid.y;
		[translated addPoint:[[M5DrawingPoint alloc] initWithX:translatedX andY:translatedY andStrokeId:point.strokeId]];
	}

	return translated;
}

float M5DUAngleBetweenUnitVectors(M5DrawingPoint *unitVector1, M5DrawingPoint *unitVector2) {
	float angle = (unitVector1.x * unitVector2.x + unitVector1.y * unitVector2.y);
	if (angle < -1.0 || angle > 1.0) {
		angle = M5DURoundToDigits(angle, 5);
	}

	return acos(angle);
}

float M5DUPathDistance(M5DrawingStroke *points1, M5DrawingStroke *points2) {
	float distance = 0.0;
	for (int i = 0; i < points1.pointCount && i < points2.pointCount; i++) {
		distance += M5DUDistance([points1 pointAtIndex:i], [points2 pointAtIndex:i]);
	}

	return distance / points1.pointCount;
}

M5DrawingPoint *M5DUCalcStartUnitVector(M5DrawingStroke *points) {
	int endPointIndex = M5DUStartVectorDelay + M5DUStartVectorLength;
	M5DrawingPoint *pointAtIndex = [points pointAtIndex:endPointIndex];
	M5DrawingPoint *firstPoint = [points pointAtIndex:M5DUStartVectorDelay];

	M5DrawingPoint *unitVector = [[M5DrawingPoint alloc] initWithX:pointAtIndex.x - firstPoint.x andY:pointAtIndex.y - firstPoint.y andStrokeId:0];
	float magnitude = sqrtf(unitVector.x * unitVector.x + unitVector.y * unitVector.y);

	return [[M5DrawingPoint alloc] initWithX:unitVector.x / magnitude andY:unitVector.y / magnitude andStrokeId:0];
}

CGRect M5DUBoundingBox(M5DrawingStroke *points) {
	float minX = FLT_MAX;
	float maxX = -FLT_MAX;
	float minY = FLT_MAX;
	float maxY = -FLT_MAX;

	for (M5DrawingPoint *point in points.points) {
		if (point.x < minX) {
			minX = point.x;
		}

		if (point.y < minY) {
			minY = point.y;
		}

		if (point.x > maxX) {
			maxX = point.x;
		}

		if (point.y > maxY) {
			maxY = point.y;
		}
	}

	return CGRectMake(minX, minY, (maxX - minX), (maxY - minY));
}

float M5DUDistanceAtAngle(M5DrawingStroke *recognizingPoints, M5DrawingStroke *matchPoints, float radians) {
	M5DrawingStroke *newPoints = M5DURotateBy(recognizingPoints, radians);
	return M5DUPathDistance(newPoints, matchPoints);
}

float M5DURoundToDigits(float number, int decimals) {
	decimals = pow(10, decimals);
	return round(number * decimals) / decimals;
}

float M5DUDegreesToRadians(float degrees) {
	return degrees * M_PI / 180.0;
}

float M5DURadiansToDegrees(float radians) {
	return radians * 180.0 / M_PI;
}

float M5DUPathLength(M5DrawingStroke *points) {
	float distance = 0.0;
	for (int i = 1; i < points.pointCount; i++) {
		M5DrawingPoint *point1 = [points pointAtIndex:(i - 1)];
		M5DrawingPoint *point2 = [points pointAtIndex:i];
		distance += M5DUDistance(point1, point2);
	}

	return distance;
}

float M5DUDistance(M5DrawingPoint *point1, M5DrawingPoint *point2) {
	int xDiff = point2.x - point1.x;
	int yDiff = point2.y - point1.y;
	float dist = sqrt(xDiff * xDiff + yDiff * yDiff);
	return dist;
}

M5DrawingPoint *M5DUCentroid(M5DrawingStroke *points) {
	float x = 0.0;
	float y = 0.0;
	for (M5DrawingPoint *point in points.points) {
		x += point.x;
		y += point.y;
	}

	x /= points.pointCount;
	y /= points.pointCount;

	return [[M5DrawingPoint alloc] initWithX:x andY:y andStrokeId:0];
}

#pragma mark -
