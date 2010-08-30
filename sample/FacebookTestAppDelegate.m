//
//  FacebookTestAppDelegate.m
//  FacebookTest
//
//  Created by Philippe on 10-08-25.
//  Copyright 2010 Philippe Casgrain. All rights reserved.
//

#import "FacebookTestAppDelegate.h"
#import "ApplicationID.h"

@implementation FacebookTestAppDelegate

@synthesize token_label;
@synthesize request_label;
@synthesize request_text;
@synthesize result_text;
@synthesize send_request;
@synthesize window;

- (void) applicationDidFinishLaunching: (NSNotification*) aNotification
{
    fb = [[PhFacebook alloc] initWithApplicationID: APPLICATION_ID delegate: self];
    self.token_label.stringValue = @"Invalid";
    [self.request_label setEnabled: NO];
    [self.request_text setEnabled: NO];
    [self.send_request setEnabled: NO];
    [self.result_text setEnabled: NO];
}

#pragma mark IBActions

- (IBAction) getAccessToken: (id) sender
{
    [fb getAccessTokenForPermissions: [NSArray arrayWithObject: @"read_stream"]];
}

- (IBAction) sendRequest: (id) sender
{
    [self.send_request setEnabled: NO];
    [fb sendRequest: request_text.stringValue];
}

#pragma mark PhFacebookDelegate methods

- (void) tokenResult: (NSDictionary*) result
{
    if ([[result valueForKey: @"valid"] boolValue])
    {
        self.token_label.stringValue = @"Valid";
        [self.request_label setEnabled: YES];
        [self.request_text setEnabled: YES];
        [self.send_request setEnabled: YES];
        [self.result_text setEnabled: YES];
    }
    else
    {
        self.result_text.stringValue = [NSString stringWithFormat: @"Error: {%@}", [result valueForKey: @"error"]];
    }

}

- (void) requestResult: (NSDictionary*) result
{
    [self.send_request setEnabled: YES];

    self.result_text.stringValue = [NSString stringWithFormat: @"Request: {%@}\n%@", [result objectForKey: @"request"], [result objectForKey: @"result"]];
}

- (void) willShowUINotification: (PhFacebook*) sender
{
    // PhFacebook will show some UI, so maybe move to front or alert the user
}

@end
