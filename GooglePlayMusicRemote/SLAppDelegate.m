//
//  SLAppDelegate.m
//  GooglePlayMusicRemote
//
//  Created by Steven La on 2/22/14.
//  Copyright (c) 2014 Steven La. All rights reserved.
//

#import "SLAppDelegate.h"
#import "AppleMediaKeyController.h"

@implementation SLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Create Media Key listener and bind events
    [AppleMediaKeyController sharedController];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(playPause) name:MediaKeyPlayPauseNotification object:nil];
    [center addObserver:self selector:@selector(next) name:MediaKeyNextNotification object:nil];
    [center addObserver:self selector:@selector(previous) name:MediaKeyPreviousNotification object:nil];
    
    // Set path for Applescript to be the `controller.scpt` inside application bundle
    NSBundle *mainBundle = [NSBundle mainBundle];
    path = [mainBundle pathForResource:@"controller" ofType:@"scpt"];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    if (flag) {
        return NO;
    }
    else
    {
        [_window makeKeyAndOrderFront:self];
        return YES;
    }
}

- (void)doAction:(NSString*)action {
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/usr/bin/osascript";
    
    NSArray *args = [NSArray arrayWithObjects:path, action, nil];
    [task setArguments:args];
    
    [task launch];
    [task waitUntilExit];
}

- (void)playPause {
    [self doAction:@"playPause"];
}

- (void)next {
    [self doAction:@"nextSong"];
}

- (void)previous {
    [self doAction:@"prevSong"];
}


@end
