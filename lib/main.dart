import 'package:flutter/material.dart';
import 'principal.dart';
import 'common/bluetooth_control_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: PagPrincipal(),
      home: BluetoothControlPage(),
    );
  }
}
