Cocoa Multistroke Gesture Recognition
===========================================
A drop-in solution for matching multistroke input (gesture/drawing) against a gesture set. Designed for easy appending to/deleting from, and storing of this gesture set.


Psuedo-example usage:

GestureRecognizer *recognizer = [[GestureRecognizer alloc] init];
    
[recognizer addGesture:[[Gesture alloc] initWithId:@"LetterI" andStrokes:[NSMutableArray arrayWithObjects:[[GestureStroke alloc] initWithPoints:AN_ARRAY_OF_GESTURE_POINTS_THAT_MAKE_AN_I], nil]]];
    
[recognizer addGesture:[[Gesture alloc] initWithId:@"UserInput" andStrokes:AN_ARRAY_OF_GESTURE_STROKES_DERIVED_FROM_USER_MOUSE_OR_TOUCH_INPUT]];
    
...
...
...
    
GestureResult *result = [recognizer recognizeGestureWithStrokes:AN_ARRAY_OF_GESTURE_STROKES_DERIVED_FROM_LATER_USER_INPUT];
    
if (result) {
    NSLog(@"Previously loaded gesture with identifier %@ was recognized with an accuracy of %i", result.identifier, result.score);
}
