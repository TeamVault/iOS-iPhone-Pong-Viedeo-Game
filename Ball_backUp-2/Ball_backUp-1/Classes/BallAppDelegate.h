//
//  BallAppDelegate.h
//  Ball
//
//

#import <UIKit/UIKit.h>

@class BallViewController;

@interface BallAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    BallViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BallViewController *viewController;

@end

