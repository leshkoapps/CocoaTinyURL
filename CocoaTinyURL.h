//
//  CocoaTinyURL.h
//  Everapp
//
//  Created by Artem on 10/27/18.
//  Copyright © 2018 Everappz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CocoaTinyURL : NSObject

+ (instancetype)sharedInstance;

- (NSURLSessionDataTask *)makeTinyURL:(NSURL *)url completion:(void (^)(NSURL * _Nullable tinyURL, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
