import 'package:flutter/material.dart';
import 'dart:async';

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
  final _tinkoffSbpScheme = 'bank100000000004';

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

  Future<void> openPaymentWithBank() async {
    bool? res;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      res = await SbpPayments.openWithBank(_tinkoffSbpScheme, _sbpLinkExample);
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
                child: Text('choose bank and pay')),
            TextButton(
                onPressed: () async {
                  await openPaymentWithBank();
                },
                child: Text('pay with Tinkoff Bank'))
          ],
        ),
      ),
    );
  }
}
