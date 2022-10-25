import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_address_form/flutter_address_form.dart';

void main() {
  testWidgets('Render App with AddressForm Widget', (tester) async {
    final RegExp zipcodeRegExp = RegExp(r'^[1-9][0-9]{3}\s?[a-zA-Z]{2}$');
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: AddressForm(
            onSubmit: (value) => value,
            controller: AddressController(
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
              onAutoComplete: (address) {
                return address;
              },
              cityValidator: (text) {
                if (text.isEmpty) {
                  return 'Can\'t be empty';
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  });
}
