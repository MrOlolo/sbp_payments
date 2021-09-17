import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sbp_platform_interface/sbp_platform_interface.dart';

class SbpPayments {

  /// Returns true if launch bank chooser widget is successful.
  static Future<bool> showBanks(String url) async {
    final Uri uri = Uri.parse(url.trimLeft());
    final bool isWebURL = uri.scheme == 'http' || uri.scheme == 'https';
    if (!isWebURL) {
      throw PlatformException(
          code: 'NOT_A_WEB_SCHEME',
          message:
          'You need to pass in a web URL. This $url is not a web URL.');
    }
    return SbpPaymentsPlatform.instance.showBanks(url);
  }

  /// Returns true if open url is successful.
  static Future<bool> openWithBank(String bankScheme, String url) async {
    final Uri uri = Uri.parse(url.trimLeft());
    final bool isWebURL = uri.scheme == 'http' || uri.scheme == 'https';
    if (!isWebURL) {
      throw PlatformException(
          code: 'NOT_A_WEB_SCHEME',
          message:
          'You need to pass in a web URL. This $url is not a web URL.');
    }
    return SbpPaymentsPlatform.instance.openWithBank(bankScheme, url);
  }
}
