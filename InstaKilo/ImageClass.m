//
//  ImageClass.m
//  InstaKilo
//
//  Created by Brian Vo on 2018-04-25.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import "ImageClass.h"

@implementation ImageClass

- (instancetype)initWithImageSubjectLocation:(NSString*)imageName subject:(NSString *)subject location:(NSString*)location
{
    self = [super init];
    if (self) {
        _imageName = imageName;
        _subject = subject;
        _location = location;
    }
    return self;
}

@end
