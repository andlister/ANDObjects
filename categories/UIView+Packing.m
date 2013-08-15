//
//  UIView+Packing.m
//  DraftingBoard
//
//  Created by Andrew Lister on 8/19/12.
//
//

#import "UIView+Packing.h"


@implementation UIView (Packing)


- (void)sizeSubviewsToFit {
    [self sizeSubviewsToFitWithPadding:0.f];
}

- (void)sizeSubviewsToFitWithPadding:(float)padding {
    
    float sideLength = [self calcuateSideLengthForCount:[self.subviews count]];
    
    for (int i = 0, col = 0, row = 0; i < [self.subviews count]; i++, col++) {
        
        float right = (sideLength * col) + sideLength;
        if (right > self.frame.size.width) {  // next row
            col = 0;
            row++;
        }
        
        UIView *view = [self.subviews objectAtIndex:i];
        view.frame = CGRectMake(col * sideLength, row * sideLength, sideLength - padding, sideLength - padding);
    }
}


/** 
    Calculates the size all the views will need to be to fit within this
    containter (frame size) given the number of images to be contained.
    Obtain max side length to fit
  */
- (float)calcuateSideLengthForCount:(int)count {
    
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    
    float containerArea = width * height;
    float idealArea = containerArea/count;
    float idealSideLength = sqrtf(idealArea);
    
    int rows = ceilf(height/idealSideLength);
    int columns = ceilf(width/idealSideLength);
    
    float minSideLength = MIN((width/columns), (height/rows));
    float maxSideLength = MAX((width/columns), (height/rows));
    
    //Use the max side length unless it causes overlap.
    float sideLength = ((((rows * maxSideLength) > height) && (((rows-1) * columns) < count)) ||
                        (((columns * maxSideLength) > width) && (((columns-1) * rows) < count)))? minSideLength : maxSideLength;
    
    return sideLength;
}


@end
