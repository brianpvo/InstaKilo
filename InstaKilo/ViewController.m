//
//  ViewController.m
//  InstaKilo
//
//  Created by Brian Vo on 2018-04-25.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewCell.h"
#import "ImageClass.h"
#import "HeaderView.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray <ImageClass *> *imagesClass;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"%@", [self.imagesClass valueForKey:@"subject"]);
    
    
    
}
- (IBAction)segmentControlTapped:(id)sender {
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imagesClass count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                           withReuseIdentifier:@"HeaderView"
                                                                                  forIndexPath:indexPath];
        
        switch (self.segmentControl.selectedSegmentIndex) {
            case 0:
                headerView.label.text = @"All Photos";
                break;
            case 1:
                headerView.label.text = @"Subject";
                break;
            case 2:
                headerView.label.text = @"Location";
                break;
                
            default:
                break;
        }
        return headerView;
    }
    
    return nil;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCellId" forIndexPath:indexPath];
    
    UIImage *image = [UIImage imageNamed:[self.imagesClass objectAtIndex:indexPath.row].imageName];
    
    cell.imageView.image = image;
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray <ImageClass *> *)imagesClass {
    return @[
             [[ImageClass alloc] initWithImageSubjectLocation:@"image1" subject:@"Memes" location:@"Vancouver"],
             [[ImageClass alloc] initWithImageSubjectLocation:@"image2" subject:@"Memes" location:@"Vancouver"],
             [[ImageClass alloc] initWithImageSubjectLocation:@"image3" subject:@"Faces" location:@"Vancouver"],
             [[ImageClass alloc] initWithImageSubjectLocation:@"image4" subject:@"Memes" location:@"Vancouver"],
             [[ImageClass alloc] initWithImageSubjectLocation:@"image5" subject:@"Memes" location:@"Burnaby"],
             [[ImageClass alloc] initWithImageSubjectLocation:@"image6" subject:@"Memes" location:@"Burnaby"],
             [[ImageClass alloc] initWithImageSubjectLocation:@"image7" subject:@"Memes" location:@"Burnaby"],
             [[ImageClass alloc] initWithImageSubjectLocation:@"image8" subject:@"Memes" location:@"Surrey"],
             [[ImageClass alloc] initWithImageSubjectLocation:@"image9" subject:@"Memes" location:@"Surrey"],
             [[ImageClass alloc] initWithImageSubjectLocation:@"image10" subject:@"Faces" location:@"Toronto"]
             ];
}


@end
