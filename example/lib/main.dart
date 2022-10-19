import 'package:flutter/material.dart';
import 'package:flutter_address_form/flutter_address_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AddressFormExample(),
    );
  }
}

class AddressFormExample extends StatelessWidget {
  AddressFormExample({Key? key}) : super(key: key);

  final RegExp zipcodeRegExp = RegExp(r'^[1-9][0-9]{3}\s?[a-zA-Z]{2}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddressForm(
        zipCodeValidator: (text) {
          if (text.isEmpty) {
            return 'Can\'t be empty';
          }
          if (!zipcodeRegExp.hasMatch(text)) {
            return 'Invalid zipcode';
          }
          return null;
        },
        housenumberValidator: (text) {
          if (text.isEmpty) {
            return 'Can\'t be empty';
          }
          if (text.length >= 3 || int.tryParse(text) == null) {
            return 'Invalid number';
          }
          return null;
        },
        suffixValidator: (text) {
          if (text.isNotEmpty && RegExp(r'/^[a-z]*$/').hasMatch(text)) {
            return 'Invalid prefix';
          }
          return null;
        },
        streetValidator: (text) {
          if (text.isEmpty) {
            return 'Can\'t be empty';
          }
          return null;
        },
        cityValidator: (text) {
          if (text.isEmpty) {
            return 'Can\'t be empty';
          }
          return null;
        },
        controller: AddressController(onAutoComplete: (address) {
          return address;
        }),
      ),
    );
  }
}
