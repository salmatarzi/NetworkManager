/********* networkmanager.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <IBGxNetworkManager/IBGxNetworkManager.h>

@interface networkmanager : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation networkmanager

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
  IBGxNetworkManager   *obj =  [IBGxNetworkManager sharedInstance];

  NSString* urlString = command.arguments[0];
  NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

  NSDictionary* parameters = [[NSDictionary alloc]init];
  if (command.arguments.count > 1) {
    parameters = command.arguments[1];
  } else {
      parameters = nil;
  }

  [obj GET:url parameters:parameters completionHandler:^(id _Nullable response, NSError * _Nullable error) {

      CDVPluginResult* pluginResult = nil;
      if(error == nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:response];
      }
      else if(response == nil) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
      }
      [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
  }];
}

@end
