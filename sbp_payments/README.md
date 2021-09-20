# sbp_payments

Flutter plugin which helps to handle sbp payment links and open it with specific bank app.
Supports iOS and Android

<p float="left">
 <img src="https://raw.githubusercontent.com/MrOlolo/sbp_payments/master/assets/sbp_android.jpg" height="600" alt="Android widget">
 <img src="https://raw.githubusercontent.com/MrOlolo/sbp_payments/master/assets/sbp_ios.png" height="600" alt="iOS widget">
</p>

## Usage
To use this plugin, add `sbp_payments` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

## Installation

### iOS
Add URL schemes as `LSApplicationQueriesSchemes` entries in your `Info.plist` file:

```
 <key>LSApplicationQueriesSchemes</key>
  <array>
    <string>bank100000000000</string>
    <string>bank100000000001</string>
    ...
    <string>bank100000000999</string>
    <string>bank100000001000</string>
  </array>
```
That's need for UIApplication.shared.canOpenURL method worked correctly. You can copy and paste all lines from [example](https://github.com/MrOlolo/sbp_payments/blob/db6da2b2f31af67fd4d00c4a0ada37e378bc984e/sbp_payments/example/ios/Runner/Info.plist#L44).

See [`-[UIApplication canOpenURL:]`](https://developer.apple.com/documentation/uikit/uiapplication/1622952-canopenurl) for more details.

### Example

``` dart
import 'package:flutter/material.dart';
import 'package:sbp_payments/sbp_payments.dart';

final _sbpLinkExample =
      'https://qr.nspk.ru/AS100001ORTF4GAF80KPJ53K186D9A3G?type=01&bank=100000000007&crc=0C8A';

void main() => runApp(
      const MaterialApp(
        home: Material(
          child: Center(
            child: RaisedButton(
              onPressed: _showBanks,
              child: Text('Show SBP widget'),
            ),
          ),
        ),
      ),
    );

void _showBanks() async => await SbpPayments.showBanks(_sbpLinkExample);
```


