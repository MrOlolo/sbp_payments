import 'dart:async';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sbp_platform_interface/method_channel/method_channel_sbp_payments.dart';

abstract class SbpPaymentsPlatform extends PlatformInterface {
  /// Constructs a SbpPaymentsPlatform.
  SbpPaymentsPlatform() : super(token: _token);

  static final Object _token = Object();

  static SbpPaymentsPlatform _instance = MethodChannelSbpPayments();


  /// The default instance of [SbpPaymentsPlatform] to use.
  ///
  /// Defaults to [MethodChannelSbpPayments].
  static SbpPaymentsPlatform get instance => _instance;


  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [SbpPaymentsPlatform] when they register themselves.
  static set instance(SbpPaymentsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Open native bank chooser widget.
  ///
  /// Returns `true` if the given [url] was successfully opened
  Future<bool> showBanks(String url) {
    throw UnimplementedError('showBanks() has not been implemented.');
  }

  /// Returns `true` if the given [url] was successfully opened
  Future<bool> openWithBank(String bankScheme, String url) {
    throw UnimplementedError('openWithBank() has not been implemented.');
  }
}
