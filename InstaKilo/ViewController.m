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
#import "CategorizedArray.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray <ImageClass *> *imagesClass;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic) NSArray <NSString *> *subjectArray;
@property (nonatomic) NSArray <NSString *> *locationArray;
@property (nonatomic) NSMutableArray <ImageClass *> *subjectClassArray;
@property (nonatomic) NSMutableArray <ImageClass *> *locationClassArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imagesClass = [[NSMutableArray alloc] initWithArray:@[
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
                                                               ]];
    
    self.subjectArray = [CategorizedArray arrayCategory:self.imagesClass :@"subject"];
    self.locationArray = [CategorizedArray arrayCategory:self.imagesClass :@"location"];
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processDoubleTap:)];
    [doubleTapGesture setNumberOfTapsRequired:2];
    [doubleTapGesture setNumberOfTouchesRequired:1];
    doubleTapGesture.delaysTouchesBegan = YES;
    [self.view addGestureRecognizer:doubleTapGesture];
    
    
}

-(void)processDoubleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint point = [sender locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        NSString *subjectString;
        NSString *locationString;
        
        if (indexPath)
        {
            NSLog(@"Image was double tapped");
            NSLog(@"%lu", indexPath.row);
            
            switch (self.segmentControl.selectedSegmentIndex) {
                case 0:
                    [self.imagesClass removeObjectAtIndex:indexPath.row];
        
                    break;
                case 1:
                    // NEEDS WORK
                    //subjectString = [self.subjectArray objectAtIndex:indexPath.section];
                    //self.subjectClassArray = [CategorizedArray subjectImages:subjectString ImageClassArray:self.imagesClass];
                    NSLog(@"number of things before %lu", [self.subjectClassArray count]);
                    [self.subjectClassArray removeObjectAtIndex:indexPath.row];;
                    NSLog(@"number of things after %lu", [self.subjectClassArray count]);
                    break;
                case 2:
                    // NEEDS WORK
                    locationString = [self.subjectArray objectAtIndex:indexPath.section];
                    self.locationClassArray = [CategorizedArray locationImages:locationString ImageClassArray:self.imagesClass];
                    [self.locationClassArray removeObjectAtIndex:indexPath.row];
                    break;
                default:
                    break;
            }
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            [self.collectionView reloadData];
            
        }
    }
}

- (IBAction)segmentControlTapped:(id)sender {
    [self.collectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSString *subjectString;
    NSString *locationString;
    
    NSInteger number;
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            number = [self.imagesClass count];
            break;
        case 1:
            subjectString = [self.subjectArray objectAtIndex:section];
            number = [CategorizedArray subjectImages:subjectString ImageClassArray:self.imagesClass].count;
            break;
        case 2:
            locationString = [self.locationArray objectAtIndex:section];
            number = [CategorizedArray locationImages:locationString ImageClassArray:self.imagesClass].count;
            break;
        default:
            number = 0;
            break;
    }
    return number;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger number;
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            number = 1;
            break;
        case 1:
            number = self.subjectArray.count;
            break;
        case 2:
            number = self.locationArray.count;
            break;
        default:
            number = 1;
            break;
    }
    return number;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                           withReuseIdentifier:@"HeaderView"
                                                                                  forIndexPath:indexPath];

        NSString *sectionHeader;
        
        switch (self.segmentControl.selectedSegmentIndex)
        {
            case 0:
                sectionHeader = @"All Photos";
                break;
            case 1:
                sectionHeader =  [self.subjectArray objectAtIndex:indexPath.section];
                break;
            case 2:
                sectionHeader = [self.locationArray objectAtIndex:indexPath.section];
                break;
            default:
                break;
        }
        headerView.label.text = sectionHeader;

        return headerView;
    }
    
    return nil;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCellId" forIndexPath:indexPath];
    
    
    NSString *subjectString;
    NSString *locationString;
    UIImage *image;
    
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            image = [UIImage imageNamed:[self.imagesClass objectAtIndex:indexPath.row].imageName];
            break;
        case 1:
            subjectString = [self.subjectArray objectAtIndex:indexPath.section];
            self.subjectClassArray = [CategorizedArray subjectImages:subjectString ImageClassArray:self.imagesClass];
            
            image = [UIImage imageNamed:[self.subjectClassArray objectAtIndex:indexPath.row].imageName];
            break;
        case 2:
            locationString = [self.locationArray objectAtIndex:indexPath.section];
            self.locationClassArray = [CategorizedArray locationImages:locationString ImageClassArray:self.imagesClass];
            
            image = [UIImage imageNamed:[self.locationClassArray objectAtIndex:indexPath.row].imageName];
            break;

        default:
            break;
    }
    
    cell.imageView.image = image;
    
    return cell;
}


@end
