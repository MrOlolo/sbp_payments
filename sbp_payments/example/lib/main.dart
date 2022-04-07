import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbp_payments/sbp_payments.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _sbpLinkExample =
      'https://qr.nspk.ru/AS100001ORTF4GAF80KPJ53K186D9A3G?type=01&bank=100000000007&crc=0C8A';
  final _tinkoffSbpSchemeIOS = 'bank100000000004';
  final _tinkoffSbpSchemeAndroid = 'com.idamob.tinkoff.android';

  Future<void> chooseBankForPayment() async {
    bool? res;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      res = await SbpPayments.showBanks(_sbpLinkExample);
      print('chooseBankForPayment: status $res');
    } on PlatformException catch (e) {
      print('Failed to open sbp widget. $e');
    }
  }

  Future<void> chooseBankForPaymentCustom() async {
    bool? res;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      res = await SbpPayments.showBanksCustom(_sbpLinkExample,
          backgroundColorCode: 0xFF291970, textColorCode: 0xFFFFFFFF);
      print('chooseBankForPayment: status $res');
    } on PlatformException catch (e) {
      print('Failed to open sbp widget. $e');
    }
  }

  Future<void> openPaymentWithBank() async {
    bool? res;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var scheme;
      if (Platform.isIOS) {
        scheme = _tinkoffSbpSchemeIOS;
      } else if (Platform.isAndroid) {
        scheme = _tinkoffSbpSchemeAndroid;
      } else {
        scheme = 'https://www.tinkoff.ru/';
      }
      res = await SbpPayments.openWithBank(scheme, _sbpLinkExample);
      print('openPaymentWithBank: status $res');
    } on PlatformException catch (e) {
      print('Failed to open bank. $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                onPressed: () async {
                  await chooseBankForPayment();
                },
                child: Text('Choose bank and pay')),
            TextButton(
                onPressed: () async {
                  await chooseBankForPaymentCustom();
                },
                child: Text('Choose bank and pay with custom settings')),
            TextButton(
                onPressed: () async {
                  await openPaymentWithBank();
                },
                child: Text('Pay with Tinkoff Bank'))
          ],
        ),
      ),
    );
  }
}
