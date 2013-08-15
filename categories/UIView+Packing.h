//
//  UIView+Packing.h
//  DraftingBoard
//
//  Created by Andrew Lister on 8/19/12.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Packing)

/** 
    Resizes and lays out all the subviews to best fit this containing view.
    Resizing squares all the subviews so they are all the exact same size square 
    and lays the out on the space available.
 */
- (void)sizeSubviewsToFit;

/**
    Resizes and lays out all the subviews to best fit this containing view including
    padding. Resizing squares all the subviews so they are all the exact same size square
    and lays the out on the space available.
 */
- (void)sizeSubviewsToFitWithPadding:(float)padding;

@end
