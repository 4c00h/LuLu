//
//  file: main.m
//  project: lulu (login item)
//  description: main; 'nuff said
//
//  created by Patrick Wardle
//  copyright (c) 2017 Objective-See. All rights reserved.
//

@import Cocoa;
@import Sentry;

#import "consts.h"
#import "logging.h"
#import "utilities.h"

int main(int argc, const char * argv[])
{
    //return var
    int iReturn = -1;
    
    //error
    NSError* error = nil;
    
    //init crash reporting client
    SentryClient.sharedClient = [[SentryClient alloc] initWithDsn:CRASH_REPORTING_URL didFailWithError:&error];
    if(nil == error)
    {
        //start crash handler
        [SentryClient.sharedClient startCrashHandlerWithError:&error];
    }
    
    //any errors?
    // just log, but keep going...
    if(nil != error)
    {
        //log error
        logMsg(LOG_ERR, [NSString stringWithFormat:@"initializing 'Sentry' failed with %@", error]);
    }
    
    //already running?
    if(YES == isAppRunning([[NSBundle mainBundle] bundleIdentifier]))
    {
        //err msg
        logMsg(LOG_DEBUG, @"an instance of LuLu (helper app) is already running...exiting");
        
        //bail
        goto bail;
    }
    
    //launch app normally
    iReturn = NSApplicationMain(argc, argv);
    
bail:
    
    return iReturn;
}
