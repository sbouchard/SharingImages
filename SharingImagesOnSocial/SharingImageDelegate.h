//
//  SharingImage.h
//  SharingImagesOnSocial
//
//  Created by SBouchard on 2015-10-26.
//  Copyright © 2015 Solutions Waizu inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharingImageDelegate : NSObject

- (void) shareimagesFromController:(UIViewController*) controller withImagesList:(NSArray *)imgList selectedImg:(long)selImgIndex;

@end
