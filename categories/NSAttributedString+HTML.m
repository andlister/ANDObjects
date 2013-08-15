//
//  NSAttributedString+HTML.m
//
//  Created by Andrew Lister on 4/16/13.
//  Copyright (c) 2013 plasticcube. All rights reserved.
//

#import "NSAttributedString+HTML.h"

@implementation NSAttributedString (HTML)

+ (NSAttributedString *)attributedStringFromHtmlString:(NSString *)string fontSize:(float)fontSize
{
    if ([string length] > 0) {
        NSMutableString *strippedString = [NSMutableString stringWithString:string];
        NSMutableArray *ranges = [NSMutableArray array];
        
        // TODO: just handling bold for now - improve
        NSString *regExString = @"(<b>(.*?)</b>)";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExString options:0 error:nil];
        NSTextCheckingResult *match = nil;
        
        do {
            match = [regex firstMatchInString:strippedString options:0 range:NSMakeRange(0, [strippedString length])];
            
            if (match) {
                NSRange wholeRange = [match rangeAtIndex:1]; // <b>text</b>
                NSRange textRange = [match rangeAtIndex:2];  // text part
                
                [strippedString replaceCharactersInRange:wholeRange withString:[strippedString substringWithRange:textRange]];
                NSRange newTextRange = NSMakeRange(wholeRange.location, textRange.length);
                [ranges addObject:[NSValue valueWithRange:newTextRange]];
            }
            
        } while (match != nil);

        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:strippedString];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, [strippedString length])];
        [ranges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [attString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:fontSize] range:[obj rangeValue]];
        }];
        
        return attString;
    }
    
    return nil;
}

@end
