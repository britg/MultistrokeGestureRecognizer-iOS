//
//  CJSONSerializedData.m
//  TouchMetricsTest
//
//  Created by Jonathan Wight on 10/31/10.
//  Copyright 2010 toxicsoftware.com. All rights reserved.
//

#import "CJSONSerializedData.h"

@interface CJSONSerializedData ()
@end

#pragma mark -

@implementation CJSONSerializedData

@synthesize data;

- (id)initWithData:(NSData *)inData
    {
    if ((self = [super init]) != NULL)
        {
        data = inData;
        }
    return(self);
    }


- (NSData *)serializedJSONData
    {
    return(self.data);
    }

@end
