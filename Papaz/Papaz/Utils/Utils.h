//
//  Utils.h
//  Papaz
//
//  Created by L on 7/24/13.
//  Copyright (c) 2013 Sorako. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject
+ (void) showAlert:(NSString *)message;
+ (void) showAlertWithTitle:(NSString *)title message:(NSString *)message;
+ (void) getImageAtURL:(NSString *)imageURL placeHolderImage:(UIImage*)placeHolderImage atGSImageView:(UIImageView *)imageView animated:(BOOL)animated;
+(UIImage*)thumbImage:(UIImage*)originalImage;
@end
