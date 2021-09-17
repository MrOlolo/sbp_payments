#import "SbpPaymentsPlugin.h"
#if __has_include(<sbp_payments/sbp_payments-Swift.h>)
#import <sbp_payments/sbp_payments-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sbp_payments-Swift.h"
#endif

@implementation SbpPaymentsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSbpPaymentsPlugin registerWithRegistrar:registrar];
}
@end
