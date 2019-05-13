//
//  ViewController.m
//  howto-afnetworking
//
//  Created by José Silva on 12/05/2019.
//  Copyright © 2019 Codavel. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performGETRequest];
    [self performPOSTRequest];
}

- (void) performGETRequest{
    // 1 - define resource URL
    NSURL *URL                      = [NSURL URLWithString:@"https://httpbin.org/get"];
    
    //2 - create AFNetwork manager
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    
    //3 - set a cache policy
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    //4 - create request
    [manager    GET:URL.absoluteString
         parameters:nil
           progress:nil
     //5 - response handling
            success:^(NSURLSessionTask *task, id responseObject) {
                NSLog(@"Reply GET JSON: %@", responseObject);
            }
            failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }
     ];
}

- (void) performPOSTRequest{
    // 1 - define resource URL
    NSURL *URL                      = [NSURL URLWithString:@"https://httpbin.org/post"];
    
    //2 - create AFNetwork manager
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //3 - set a body
    NSDictionary *body = @{@"Getting": @{@"Started":@{@"With":@{@"Bolina":@"go to"}},@"url":@"https://www.codavel.com/trybolina/"}};
    //4 - create request
    [manager POST:URL.absoluteString
       parameters:body
         progress:nil
     //5 - response handling
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"Reply POST JSON: %@", responseObject);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"error: %@", error);
          }
     ];
}
@end
