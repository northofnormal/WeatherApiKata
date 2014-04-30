//
//  WAKWeatherService.m
//  WeatherApiKata
//
//  Created by Matt Chowning on 4/26/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import "WAKWeatherService.h"

@implementation WAKWeatherService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPRequestOperationManager alloc] init];
    }
    return self;
}

- (void)getCurrentTemp:(void (^)(NSInteger))successBlock {
    
    void (^newSuccessBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger currentTemperature = [self parseFehrenheitTemp:responseObject];
        successBlock(currentTemperature);
    };
    
    [self.manager GET:@"http://api.wunderground.com/api/ee4ed185d47c8af2/conditions/q/MI/Detroit.json"
           parameters:nil
              success:newSuccessBlock
              failure:nil];
}


- (NSInteger)parseFehrenheitTemp:(id)responseObject {
    NSNumber *response = responseObject[@"current_observation"][@"temp_f"];
    return [response integerValue];
}

@end
