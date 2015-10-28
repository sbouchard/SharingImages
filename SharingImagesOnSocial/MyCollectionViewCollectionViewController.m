//
//  MyCollectionViewCollectionViewController.m
//  SharingImagesOnSocial
//
//  Created by SBouchard on 2015-10-26.
//  Copyright © 2015 Solutions Waizu inc. All rights reserved.
//

#import "MyCollectionViewCollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import "SharingImageDelegate.h"

@interface MyCollectionViewCollectionViewController ()
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) SharingImageDelegate *sharingImageDelegate;
@end

@implementation MyCollectionViewCollectionViewController

static NSString * const reuseIdentifier = @"imageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharingImageDelegate = [[SharingImageDelegate alloc] init];
    self.imagesArray = @[[UIImage imageNamed:@"ewok1"], [UIImage imageNamed:@"ewok2"], [UIImage imageNamed:@"ewok3"]];
    
    // Register cell classes
    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    UINib *cellNib = [UINib nibWithNibName:@"imageCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"imageCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imagesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell.imageView setImage:[self.imagesArray objectAtIndex:indexPath.row]];
    
    if (cell.selected) {
        cell.alpha = 1; // highlight selection
    }
    else
    {
        cell.alpha = 0.5; // Default color
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    ImageCollectionViewCell *datasetCell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.alpha = 1;
    
    [self.sharingImageDelegate shareimagesFromController:self withImagesList:self.imagesArray selectedImg:indexPath.row];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCollectionViewCell *datasetCell = (ImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    datasetCell.alpha = 0.5;

}




@end
