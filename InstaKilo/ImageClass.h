//
//  ImageClass.h
//  InstaKilo
//
//  Created by Brian Vo on 2018-04-25.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageClass : NSObject

@property (nonatomic) NSString *imageName;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *subject;

- (instancetype)initWithImageSubjectLocation:(NSString*)imageName subject:(NSString *)subject location:(NSString*)location;

@end
