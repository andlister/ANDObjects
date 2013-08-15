//
//  NSAttributedString+HTML.h
//
//  Created by Andrew Lister on 4/16/13.
//  Copyright (c) 2013 plasticcube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (HTML)

+ (NSAttributedString *)attributedStringFromHtmlString:(NSString *)string fontSize:(float)fontSize;

@end
