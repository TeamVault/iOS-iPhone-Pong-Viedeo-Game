//
//  BallViewController.m
//  Ball
//
//

#import "BallViewController.h"

@implementation BallViewController

@synthesize ball,anakin,darthV;

/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/

-(void) onTimer {
	ball.center = CGPointMake(ball.center.x+pos.x,ball.center.y+pos.y);
    anakin.center =CGPointMake(anakin.center.x+posAnakin.x,anakin.center.y);
	darthV.center =CGPointMake(anakin.center.x+posDarthV.x,darthV.center.y);
    
    
    
    if(ball.center.x > self.view.bounds.size.width - ball.frame.size.width/2   || ball.center.x <  ball.frame.size.width/2)
		pos.x = -pos.x;
	if(ball.center.y > self.view.bounds.size.height - ball.frame.size.height/2 || ball.center.y < - ball.frame.size.height/2)
		pos.y = -pos.y;
    if(ball.center.y > anakin.frame.size.height - ball.frame.size.height/2 || ball.center.y < - ball.frame.size.height/2) 
               pos.y = -pos.y;  
       
    if(ball.center.x > anakin.frame.size.height - ball.frame.size.height/2 || ball.center.y < - ball.frame.size.height/2)
       pos.x = -pos.x;
       
       
      }


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    pos = CGPointMake(14.0,7.0);
	
	[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

@end
