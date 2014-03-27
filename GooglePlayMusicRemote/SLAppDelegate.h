//
//  SLAppDelegate.h
//  GooglePlayMusicRemote
//
//  Created by Steven La on 2/22/14.
//  Copyright (c) 2014 Steven La. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SLAppDelegate : NSObject <NSApplicationDelegate>
{
    NSAppleScript *script;
    NSString *path;
}

@property (assign) IBOutlet NSWindow *window;

@end
