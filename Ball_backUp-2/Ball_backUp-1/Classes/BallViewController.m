//
//BallViewController.m
//Ball
//
//


#import "BallViewController.h"

@implementation BallViewController


@synthesize ball, anakin, darthV, scoreAnakin, scoreDarthV,starwarsBackGround, winnerLabel, anakinWinsSound, darthVWinsSound, blasterSound, blaster2Sound;

int const POINTS_TO_WIN = 5;
bool bDelayFlag = false;

// #################################################################
// HELPER METHODS

- (void)playAudioFile:(NSString *) fileName:(SystemSoundID) soundID {
    
    NSString *slash = @"/";
    NSString *newFileName = [slash stringByAppendingString:fileName];
    
    //Get the filename of the sound file:
	NSString *path = [NSString stringWithFormat:@"%@%@",
					  [[NSBundle mainBundle] resourcePath],
					  newFileName];
    
	//Get a URL for the sound file
	NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    
	//Use audio sevices to create the sound
	AudioServicesCreateSystemSoundID((CFURLRef)filePath, &soundID);
    
	//Use audio services to play the sound
	AudioServicesPlaySystemSound(soundID);
}


- (void)rotate180Label:(UILabel*)label {
    CGAffineTransform transform = label.transform;
    transform = CGAffineTransformRotate(transform, M_PI);
    label.transform = transform;
}


- (void)rotate180Image:(UIImageView*)image {
    CGAffineTransform transform = image.transform;
    transform = CGAffineTransformRotate(transform, M_PI);
    image.transform = transform;
}

- (void)rotate90Label:(UILabel*)label {
    CGAffineTransform transform = label.transform;
    transform = CGAffineTransformRotate(transform, M_PI_2);
    label.transform = transform;
}

- (void)rotate90Image:(UIImageView*)image {
    CGAffineTransform transform = image.transform;
    transform = CGAffineTransformRotate(transform, M_PI_2);
    image.transform = transform;
}

// ##############################################################
// MAIN LOOP

-(void) onTimer {
    
    if (!bDelayFlag) {
        // bDelayFlag = false;
        
        
        ball.center = CGPointMake(ball.center.x+pos.x,ball.center.y+pos.y);
        
        //    anakin.center=CGPointMake(anakin.center.x+posAnakin.x,anakin.center.y);
        
        // darthV.center =CGPointMake(darthV.center.x+posDarthV.x,darthV.center.y);
        
        // bounds
        
        if(ball.center.x > self.view.bounds.size.width - ball.frame.size.width/2  || ball.center.x <  ball.frame.size.width/2){
            pos.x = -pos.x;
        }
        if(ball.center.y > self.view.bounds.size.height - ball.frame.size.height/2 || ball.center.y < - ball.frame.size.height/2) {
            pos.y = -pos.y;
        }
        
        // end of bounds testing
        
        // Anakin collision detection
        
        if (CGRectIntersectsRect(anakin.frame, ball.frame)) {
            
            // Intersection between anakin and the ball
            
            if ((ball.center.x <= (anakin.center.x + anakin.frame.size.width / 2)) 
                && (ball.center.x >= (anakin.center.x - anakin.frame.size.width / 2)) 
                && ((ball.center.y-ball.frame.size.height / 2) <= (anakin.center.y + anakin.center.y/2))) {
                // Ball hits the front of anakin
                pos.y = -pos.y;
                AudioServicesPlaySystemSound(blasterSound);  
            } else if ((ball.center.x > anakin.center.x)  && (ball.center.y <= (anakin.center.y + anakin.frame.size.height / 2))) {
                // the ball hits anakin from the right and the ball is below the front edge of anakin
                pos.x = -pos.x;
                AudioServicesPlaySystemSound(blasterSound);                
            } else if ((ball.center.x < anakin.center.x) && (ball.center.y <= (anakin.center.y + anakin.frame.size.height / 2))) {
                // the ball hits anakin from the left and the ball is below the front edge of anakin
                pos.x = -pos.x;
                AudioServicesPlaySystemSound(blasterSound);                
            }
        }   
        // end of anakin collision detection
        // DarthV collision detection
        if (CGRectIntersectsRect(darthV.frame, ball.frame)) {
            // Intersection between darthV and the ball
            if ((ball.center.x <= (darthV.center.x + darthV.frame.size.width / 2))&& (ball.center.x >= (darthV.center.x - darthV.frame.size.width / 2)) && ((ball.center.y+ball.frame.size.height / 2) >=(darthV.center.y - darthV.center.y/2))) {
                
                // Ball hits the front of darthV
                pos.y = -pos.y;
                AudioServicesPlaySystemSound(blaster2Sound);                
            } else if ((ball.center.x > darthV.center.x)  && (ball.center.y >= (darthV.center.y - darthV.frame.size.height / 2))) {
                // the ball hits darthV from the right and the ball is below the front edge of darthV                
                pos.x = -pos.x;
                AudioServicesPlaySystemSound(blaster2Sound);                
            } else if ((ball.center.x < darthV.center.x) && (ball.center.y >= (darthV.center.y - darthV.frame.size.height / 2))) {
                // the ball hits darthV from the left and the ball is below the front edge of darthV
                pos.x = -pos.x;
                AudioServicesPlaySystemSound(blaster2Sound);                
            }
        }
        // end of darthV collision detection
        
        
        // ##################################################################
        
        // Begin Scoring Game Logic
        
        int iCurrentPointsDarthV = 0;
        int iCurrentPointsAnakin = 0;
        
        if(ball.center.y <= anakin.center.y) {
            // DarthV made a point
            iCurrentPointsDarthV = [scoreDarthV.text intValue];
            iCurrentPointsDarthV++;
            // TODO - Maybe this can cause a sort of memory management problem. Ask!
            scoreDarthV.text = [NSString stringWithFormat:@"%i", iCurrentPointsDarthV];
            // the ball is returned into the middle
            ball.center = self.view.center;
            // we have to wait for some time before we start again.
            //bDelayFlag = true;
        }
        
        if(ball.center.y >= darthV.center.y) {
            // Anakin made a point
            iCurrentPointsAnakin = [scoreAnakin.text intValue];
            iCurrentPointsAnakin++;
            // TODO - Maybe this can cause a sort of memory management problem. Ask!
            scoreAnakin.text = [NSString stringWithFormat:@"%i", iCurrentPointsAnakin];
            // the ball is returned into the middle
            ball.center = self.view.center;
            // we have to wait for some time before we start again.
            //bDelayFlag = true;
        }   
        
        if (iCurrentPointsDarthV == POINTS_TO_WIN) {
            // Darth Vader wins the match!
            winnerLabel.text = @"Darth Vader Wins!";
            [self rotate90Label:winnerLabel];
            // play the imperial march
            //[self playAudioFile:@"darthVWins.wav":darthVWinsSound];
            AudioServicesPlaySystemSound(darthVWinsSound);            
        } else if (iCurrentPointsAnakin == POINTS_TO_WIN) {
            // Anakin wins the match!
            winnerLabel.text = @"Anakin Wins!";        
            [self rotate90Label:winnerLabel];
            //[self playAudioFile:@"anakinWins.wav":anakinWinsSound];
            AudioServicesPlaySystemSound(anakinWinsSound);        
        }
        
    }    
}

// ##############################################################

// Implement viewDidLoad to do additional setup after loading the view.

- (void)viewDidLoad {
    pos = CGPointMake(14.0,7.0);
    [self addGestureRecognizersToPiece:anakin];
    [self addGestureRecognizersToPiece:darthV];
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    [self rotate180Image:anakin];
    [self rotate180Label:scoreAnakin];    
    [self rotate90Image:starwarsBackGround];
    
    NSString *soundDarthVpath = [[NSBundle mainBundle] pathForResource:@"darthVWins 1" ofType:@"aif"];
    CFURLRef soundDarthVURL = (CFURLRef ) [NSURL fileURLWithPath:soundDarthVpath];
    AudioServicesCreateSystemSoundID(soundDarthVURL, &darthVWinsSound);

    NSString *soundAnakinpath = [[NSBundle mainBundle] pathForResource:@"anakinWins 1" ofType:@"aif"];
    CFURLRef soundAnakinURL = (CFURLRef ) [NSURL fileURLWithPath:soundAnakinpath];
    AudioServicesCreateSystemSoundID(soundAnakinURL, &anakinWinsSound);

    NSString *soundBlasterpath = [[NSBundle mainBundle] pathForResource:@"BLASTER" ofType:@"aif"];
    CFURLRef soundBlasterURL = (CFURLRef ) [NSURL fileURLWithPath:soundBlasterpath];
    AudioServicesCreateSystemSoundID(soundBlasterURL, &blasterSound);
    
    NSString *soundBlaster2path = [[NSBundle mainBundle] pathForResource:@"BLASTER2" ofType:@"aif"];
    CFURLRef soundBlaster2URL = (CFURLRef ) [NSURL fileURLWithPath:soundBlaster2path];
    AudioServicesCreateSystemSoundID(soundBlaster2URL, &blaster2Sound);
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {    
    [super dealloc];
    [anakin dealloc];
    [darthV dealloc];
    //    [newScoreAnakin dealloc];
    //    [newScoreDarthV dealloc];
}

//////////////////////////////////////////////

- (void)addGestureRecognizersToPiece:(UIView *)piece
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [piece addGestureRecognizer:panGesture];
    [panGesture release];
}

- (void)awakeFromNib
{
}

#pragma mark -
#pragma mark === Utility methods  ===
#pragma mark


// scale and rotation transforms are applied relative to the layer's anchor point

// this method moves a gesture recognizer's view's anchor point between the user's fingers

//- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {

//    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {

//        UIView *piece = gestureRecognizer.view;

//        CGPoint locationInView = [gestureRecognizer locationInView:piece];

//        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];

//

//        piece.layer.anchorPoint = CGPointMake(locationInView.x /piece.bounds.size.width, locationInView.y / piece.bounds.size.height);

//        piece.center = locationInSuperview;

//    }

//}








// shift the piece's center by the pan amount

// reset the gesture recognizer's translation to {0, 0} after applying so the next callback is a delta from the current position

- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer

{
    
    UIView *piece = [gestureRecognizer view];
    
    
    
    //[self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan ||
        [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [gestureRecognizer translationInView:[piece
                                                                    superview]];
        
        
        
        //[piece setCenter:CGPointMake([piece center].x + translation.x,
        // [piece center].y + translation.y)]; if you want to move on x and y
            
        [piece setCenter:CGPointMake([piece center].x + translation.x,[piece center].y + 0)];
        
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
        
    }
    
}




// scale the piece by the current scale

// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current scale





//////////////////////////////////////////////

@end