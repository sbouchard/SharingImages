//
//  SharingImage.m
//  SharingImagesOnSocial
//
//  Created by SBouchard on 2015-10-26.
//  Copyright © 2015 Solutions Waizu inc. All rights reserved.
//

#import "SharingImage.h"

@interface SharingImage()

@end

@implementation SharingImage


- (IBAction)shareOneImage:(id)sender{
    
}

- (IBAction)shareAllImage:(id)sender{
    
}

- (void) shareimagesFromController:(UIViewController*) controller withImagesList:(NSArray *)imgList selectedImg:(long)selImgIndex{

    if(controller && imgList && [imgList count] > 0 && selImgIndex > 0 && selImgIndex < [imgList count]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        __block SharingImage *sid = self;
        
        // Share Selected Image
        // [R559] - One picture to share (select only one at a time, not multiple)
        UIAlertAction* shareOneImg = [UIAlertAction actionWithTitle:@"Share this image" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                NSArray *singleImg = @[[imgList objectAtIndex:selImgIndex]];
                                                                [sid share:singleImg from:controller];
                                                            }];
        
        // Share All Images
        // [R559] - Don't show the option above (select one or all) if there's only one image to share.
        UIAlertAction* shareAllImg;
        if([imgList count]>1){
            // [R559] - all pictures in the result(<image share count>).
            NSString *title = [NSString stringWithFormat:@"Share all images in result (%lu)", (unsigned long)[imgList count]];
            shareAllImg = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    [sid share:imgList from:controller];
                                                                }];
        
            
        }
        // Cancel button
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action){}];
        
        
        [alert addAction:shareOneImg];
        if(shareAllImg){[alert addAction:shareAllImg];}
        [alert addAction:cancelAction];
        
        [controller presentViewController:alert animated:YES completion:nil];
    }else{
        NSLog(@"Share image invalid parameters");
    }
}


- (void)share:(NSArray*)imgToShare from:(UIViewController*) ctrl {
    
    UIActivityViewController *shareCtrl = [[UIActivityViewController alloc] initWithActivityItems:imgToShare applicationActivities:nil];
    
    // Exclude all activities except AirDrop.
    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
    shareCtrl.excludedActivityTypes = excludedActivities;
    
    // Mail configuration
    // TODO: Note: singular if only one image to share. (needs to be localized)
    // Email "Subject":  <Patient First Name>'s <Service Category Name> Image[s]
    // Email "Body":  blank.
    [shareCtrl setValue:@"<Patient First Name>'s <Service Category Name> Image[s]" forKey:@"subject"];
    
    // Present the controller
    [ctrl presentViewController:shareCtrl animated:YES completion:nil];
    
}

@end
