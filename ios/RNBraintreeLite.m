
#import "RNBraintreeLite.h"

@implementation RNBraintreeLite

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(
                 show,
                 showWithOptions:(NSDictionary*)options
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    BTDropInRequest *request = [[BTDropInRequest alloc] init];

    request.venmoDisabled = YES;
    request.paypalDisabled = YES;

    BTDropInController *dropIn = [[BTDropInController alloc] initWithAuthorization:options[@"clientToken"] request:request handler:^(BTDropInController * _Nonnull controller, BTDropInResult * _Nullable result, NSError * _Nullable error) {
        [self.reactRoot dismissViewControllerAnimated:YES completion:nil];

        if (error != nil) {
            NSLog(@"ERROR");
        } else if (result.cancelled) {
            reject(@"USER_CANCELLATION", @"The user cancelled", nil);
        } else {
            NSMutableDictionary* jsResult = [NSMutableDictionary new];

            [jsResult setObject:result.paymentMethod.nonce forKey:@"nonce"];
            [jsResult setObject:result.paymentMethod.type forKey:@"type"];
            [jsResult setObject:result.paymentDescription forKey:@"description"];
            [jsResult setObject:[NSNumber numberWithBool:result.paymentMethod.isDefault] forKey:@"isDefault"];

            resolve(jsResult);
            // Use the BTDropInResult properties to update your UI
            // result.paymentOptionType
            // result.paymentMethod
            // result.paymentIcon
            // result.paymentDescription
        }
    }];

    [self.reactRoot presentViewController:dropIn animated:YES completion:nil];
}

- (UIViewController*)reactRoot {
    UIViewController *root  = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *maybeModal = root.presentedViewController;

    UIViewController *modalRoot = root;

    if (maybeModal != nil) {
        modalRoot = maybeModal;
    }

    return modalRoot;
}

@end
