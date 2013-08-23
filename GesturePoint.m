#import "GesturePoint.h"

@implementation GesturePoint

@synthesize stroke;

- (id) initWithX:(float)_x andY:(float)_y andStroke:(int)_id
{
    self = [super init];

    point = [NSValue valueWithPoint:NSMakePoint(_x, _y)];
    stroke = _id;

    return self;
}


- (id) initWithPoint:(NSPoint)_point andStroke:(int)_id
{
    return [self initWithX:_point.x andY:_point.y andStroke:_id];
}


- (id) initWithValue:(NSValue *)_value andStroke:(int)_id
{
    self = [super init];

    point = _value;
    stroke = _id;

    return self;
}


- (void) setX:(float)_x
{
    point = [NSValue valueWithPoint:NSMakePoint(_x, [self getY])];
}


- (void) setY:(float)_y
{
    point = [NSValue valueWithPoint:NSMakePoint([self getX], _y)];
}


- (float) getX
{
    return [point pointValue].x;
}


- (float) getY
{
    return [point pointValue].y;
}


- (void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:point forKey:@"point"];
    [coder encodeObject:[NSNumber numberWithInt:stroke] forKey:@"stroke"];
}


- (id) initWithCoder:(NSCoder *)coder
{
    self = [super init];

    point = [coder decodeObjectForKey:@"point"];
    stroke = [[coder decodeObjectForKey:@"stroke"] intValue];

    return self;
}


- (id) copyWithZone:(NSZone *)zone
{
    GesturePoint *copy = [[GesturePoint allocWithZone:zone] initWithValue:[point copy] andStroke:stroke];

    return copy;
}


- (NSString *) description
{
    return [NSString stringWithFormat:@"X: %f Y: %f Stroke: %i", [self getX], [self getY], stroke];
}


@end
