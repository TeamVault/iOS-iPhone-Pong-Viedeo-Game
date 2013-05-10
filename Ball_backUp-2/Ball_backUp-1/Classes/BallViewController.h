//
//  BallViewController.h
//  Ball
//
//


#import <UIKit/UIKit.h>
#import "AudioToolbox/AudioServices.h"

@interface BallViewController : UIViewController <UIGestureRecognizerDelegate>{
    
    IBOutlet UIImageView *ball;
    IBOutlet UIImageView *anakin;
    IBOutlet UIImageView *darthV;
    CGPoint pos,posAnakin,posDarthV;
    IBOutlet UIImageView *starwarsBackGround;
    IBOutlet UILabel *scoreAnakin;
    IBOutlet UILabel *scoreDarthV;
    IBOutlet UILabel *winnerLabel;
    SystemSoundID   darthVWinsSound;
    SystemSoundID   anakinWinsSound;
    SystemSoundID   blasterSound;
    SystemSoundID   blaster2Sound;
}


@property(nonatomic,retain) IBOutlet UIImageView *ball;
@property(nonatomic,retain) IBOutlet UIImageView *anakin;
@property(nonatomic,retain) IBOutlet UIImageView *darthV;
@property(nonatomic,retain) IBOutlet UIImageView *starwarsBackGround;
@property(nonatomic, retain) IBOutlet UILabel * scoreAnakin;
@property(nonatomic, retain) IBOutlet UILabel * scoreDarthV;
@property(nonatomic, retain) IBOutlet UILabel *winnerLabel;
@property(nonatomic) SystemSoundID darthVWinsSound;
@property(nonatomic) SystemSoundID anakinWinsSound;
@property(nonatomic) SystemSoundID blasterSound;
@property(nonatomic) SystemSoundID blaster2Sound;

@end