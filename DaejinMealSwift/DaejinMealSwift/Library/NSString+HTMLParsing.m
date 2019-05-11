//
//  NSString+HTMLParsing.m
//  WebCrawlingTest
//
//  Created by hanwe lee on 2018. 12. 26..
//  Copyright © 2018년 RSupport. All rights reserved.
//

#import "NSString+HTMLParsing.h"

@implementation NSString (HTMLParsing)

-(NSString *)removeTDTag
{
    NSString *result = nil;
    NSMutableString *mutableResult = [[NSMutableString alloc] initWithString:self];
    int frontStartIndex = 0,frontEndIndex = 0;
    
    if([mutableResult hasPrefix:@"<td"]){
        if([mutableResult hasSuffix:@"</td>"]){
            NSRange range = [mutableResult rangeOfString:@"</td>"];
            if(range.location != NSNotFound){
                [mutableResult deleteCharactersInRange:range];
                for(int i = 0 ; i< [mutableResult length] ; i++){
                    if([mutableResult characterAtIndex:i] == '<'){
                        frontStartIndex = i;
                    }
                    if([mutableResult characterAtIndex:i] == '>'){
                        frontEndIndex = i;
                        [mutableResult deleteCharactersInRange:NSMakeRange(frontStartIndex, frontEndIndex+1)];
                        break;
                    }
                }
            }
        }
        
    }
    result = [[NSString alloc] initWithString:mutableResult];
    return result;
}

@end
