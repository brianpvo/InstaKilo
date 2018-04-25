//
//  CategorizedArray.h
//  InstaKilo
//
//  Created by Brian Vo on 2018-04-25.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageClass.h"

@interface CategorizedArray : NSObject

-(NSArray *)arrayCategory:(NSArray <ImageClass *> *)array :(NSString *)category;

@end