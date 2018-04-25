//
//  CategorizedArray.m
//  InstaKilo
//
//  Created by Brian Vo on 2018-04-25.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import "CategorizedArray.h"

@implementation CategorizedArray

-(NSArray *)arrayCategory:(NSArray <ImageClass *> *)array :(NSString *)category {
    NSMutableArray *subjectArray = [[NSMutableArray alloc] init];
    NSMutableArray *locationArray = [[NSMutableArray alloc] init];
    
    if ([category isEqualToString:@"subject"]) {
        for (ImageClass* imageClass in array) {
            NSString* subjectName = imageClass.subject;
            if (![subjectArray containsObject:subjectName]) {
                [subjectArray addObject:subjectName];
            }
        }
        return subjectArray;
    }
    if ([category isEqualToString:@"location"]) {
        for (ImageClass* imageClass in array) {
            NSString* locationName = imageClass.location;
            if (![locationArray containsObject:locationName]) {
                [locationArray addObject:locationName];
            }
        }
        return locationArray;
    }
    
    return nil;
    
}

@end
