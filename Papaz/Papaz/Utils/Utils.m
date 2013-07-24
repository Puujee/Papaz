//
//  Utils.m
//  Papaz
//
//  Created by L on 7/24/13.
//  Copyright (c) 2013 Sorako. All rights reserved.
//

#import "Utils.h"
#import <objc/message.h>
#import "EXTScope.h"

@implementation Utils
+ (void) showAlert:(NSString *)message {
    UIAlertView *customAlertView = [[UIAlertView alloc]initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [customAlertView show];
}

+ (void) showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *customAlertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [customAlertView show];
}

+(NSString *)cachesDicectory {
    NSString *appDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    if (!appDirectory) {
        return nil;
    }
    return appDirectory;
}

+ (NSString *) downloadDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (void) getImageAtURL:(NSString *)imageURL placeHolderImage:(UIImage*)placeHolderImage atGSImageView:(UIImageView *)imageView animated:(BOOL)animated;
{
    NSString *filePath = [[self cachesDicectory] stringByAppendingPathComponent:[imageURL stringByReplacingOccurrencesOfString:@"/" withString:@""]];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    if (image) {
        
        if (animated) {
            imageView.image = placeHolderImage;
            dispatch_async(dispatch_get_main_queue(), ^{
                id animation = objc_msgSend(NSClassFromString(@"CATransition"), @selector(animation));
                objc_msgSend(animation, @selector(setType:), @"kCATransitionFade");
                objc_msgSend(imageView.layer, @selector(addAnimation:forKey:), animation, nil);
                objc_msgSend(animation, @selector(setDuration:), 0.7);
            });
        }
        imageView.image = image;
    }
    
    else {
        
        @weakify(imageView);
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageURL]];
        
        [imageView setImageWithURLRequest:request placeholderImage:placeHolderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            @strongify(imageView);
            NSString *savePath = [[self cachesDicectory] stringByAppendingPathComponent:[imageURL stringByReplacingOccurrencesOfString:@"/" withString:@""]];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
            [[NSFileManager defaultManager] createFileAtPath:savePath contents:imageData attributes:nil];
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    id animation = objc_msgSend(NSClassFromString(@"CATransition"), @selector(animation));
                    objc_msgSend(animation, @selector(setType:), @"kCATransitionFade");
                    objc_msgSend(imageView.layer, @selector(addAnimation:forKey:), animation, nil);
                    objc_msgSend(animation, @selector(setDuration:), 0.7);
                });
                imageView.image = image;
            }
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
    }
}

+(UIImage*)thumbImage:(UIImage*)originalImage {
    float iPhoneSize = 100.0f;
    
	float originalWidth = originalImage.size.width;
	float originalHeight = originalImage.size.height;
	
	float kAppIconWidth;
	float kAppIconHeight;
	
	if (originalWidth < iPhoneSize) {
		return originalImage;
	}
	if (originalHeight < iPhoneSize) {
		return originalImage;
	}
	if (originalWidth > originalHeight) {
		kAppIconWidth = iPhoneSize;
		kAppIconHeight = iPhoneSize*originalHeight/originalWidth;
	}
	else {
		kAppIconWidth = iPhoneSize*originalWidth/originalHeight;
		kAppIconHeight = iPhoneSize;
	}
	
	CGSize itemSize = CGSizeMake(kAppIconWidth, kAppIconHeight);
	UIGraphicsBeginImageContext(itemSize);
	CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
	[originalImage drawInRect:imageRect];
	UIImage *compressedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return compressedImage;
}

@end
