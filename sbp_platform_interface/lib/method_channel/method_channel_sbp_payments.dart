import 'package:flutter/services.dart';
import 'package:sbp_platform_interface/sbp_platform_interface.dart';

/// The method channel used to interact with the native platform.
const MethodChannel _channel = MethodChannel('github.com/MrOlolo/sbp_payments');

class MethodChannelSbpPayments extends SbpPaymentsPlatform {
  @override
  Future<bool> showBanks(String url) {
    return _channel.invokeMethod<bool>(
      'showBanks',
      <String, Object>{'url': url},
    ).then((value) => value ?? false);
  }

  @override
  Future<bool> openWithBank(String bankScheme, String url) async {
    return _channel.invokeMethod<bool>(
      'openWithBank',
      <String, Object>{'url': url, 'scheme': bankScheme},
    ).then((value) => value ?? false);
  }

  @override
  Future<bool> showBanksCustom(String url,
      {required int backgroundCode, required int textCode}) {
    return _channel.invokeMethod<bool>(
      'showBanksCustom',
      <String, Object>{
        'url': url,
        'background': backgroundCode,
        'text': textCode
      },
    ).then((value) => value ?? false);
  }
}
