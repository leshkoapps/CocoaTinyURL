//
//  CocoaTinyURL.m
//  Everapp
//
//  Created by Artem on 10/27/18.
//  Copyright © 2018 Everappz. All rights reserved.
//

#import "CocoaTinyURL.h"



@interface CocoaTinyURL() <NSURLSessionDelegate>

@property (nonatomic,strong)NSURLSession *session;

@end


@implementation CocoaTinyURL

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static CocoaTinyURL *shared;
    dispatch_once(&onceToken, ^{
        shared = [CocoaTinyURL new];
    });
    return shared;
}

- (instancetype)init{
    self = [super init];
    if(self){
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.allowsCellularAccess = YES;
        configuration.timeoutIntervalForRequest = 5.0;
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    }
    return self;
}

- (NSString*)urlEncodeString:(NSString*)string{
    NSCharacterSet * allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"] invertedSet];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

- (NSURLSessionDataTask *)makeTinyURL:(NSURL *)url completion:(void (^)(NSURL * _Nullable tinyURL, NSError * _Nullable error))completion{
    NSParameterAssert(url);
    if(url==nil){
        if(completion){
            completion(nil,[NSError errorWithDomain:NSCocoaErrorDomain code:-1001 userInfo:nil]);
        }
    }
    NSString *urlEncodedParam = [self urlEncodeString:url.absoluteString];
    NSString *urlStr = [NSString stringWithFormat:@"http://tinyurl.com/api-create.php?source=indexpage&url=%@",urlEncodedParam];
    NSURL *requestURL = [NSURL URLWithString:urlStr];
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSURL *tinyURL = nil;
        if(data){
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if(dataStr){
                tinyURL = [NSURL URLWithString:dataStr];
            }
        }
        if(tinyURL){
            if(completion){
                completion(tinyURL,nil);
            }
        }
        else{
            NSDictionary *userInfo = nil;
            if(error){
                userInfo = @{NSUnderlyingErrorKey:error};
            }
            NSError *resultError = [NSError errorWithDomain:NSCocoaErrorDomain code:-1002 userInfo:userInfo];
            if(completion){
                completion(nil,resultError);
            }
        }
    }];
    [task resume];
    return task;
}

@end
