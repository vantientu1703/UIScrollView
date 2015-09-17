//
//  BootLogic.m
//  TechmasterApp
//
//  Created by techmaster on 9/7/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

#import "BootLogic.h"
#import "MainScreen.h"


@implementation BootLogic
+ (void) boot: (UIWindow*) window

{
    MainScreen* mainScreen = [[MainScreen alloc] initWithStyle:UITableViewStyleGrouped];
    //--------- From this line, please customize your menu data -----------
    NSDictionary* basic = @{SECTION: @"ScrollView", MENU: @[
                                    @{TITLE: @"ScrollView Basic",CLASS: @"ScrollViewBasic"},
                                    @{TITLE: @"Content Size",CLASS: @"ContentSize"},
                                    @{TITLE: @"Tap to Zoom",CLASS: @"TapToZoom"},
                                    @{TITLE: @"Paging ScrollView",CLASS: @"PagingScrollView"}
                          ]};
    NSDictionary* intermediate = @{SECTION: @"Lập trình cảm ứng đa chạm", MENU: @[
                                           @{TITLE: @"Tap",CLASS: @"Tap"},
                                           @{TITLE: @"Pan",CLASS: @"Pan"},
                                           @{TITLE: @"Pinch",CLASS: @"Pinch"},
                                           @{TITLE: @"Throw Ball",CLASS: @"ThrowBall"},
                                           @{TITLE: @"Rotate Ball",CLASS: @"RotateBall"}
                                  ]};
    NSDictionary* advanced = @{SECTION: @"NSArray", MENU: @[
                                    @{TITLE: @"CreateArray", CLASS: @"createArray"}
                                    //@{TITLE: @"CustomSlider", CLASS:@"CustomSlider"}
                                    
                                    ]};
    
    mainScreen.menu = @[basic, intermediate, advanced];
    mainScreen.title = @"UIScrollView ";
    mainScreen.about = @"This is demo by Van Tien Tu";
    //--------- End of customization -----------
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController: mainScreen];
    
    window.rootViewController = nav;
}
@end
