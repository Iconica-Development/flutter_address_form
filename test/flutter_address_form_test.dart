import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_address_form/flutter_address_form.dart';

void main() {
  late RegExp zipcodeRegExp;

  setUp(() {
    // Testing with Dutch ZipCode
    zipcodeRegExp = RegExp(r'^[1-9][0-9]{3}\s?[a-zA-Z]{2}$');
  });
  testWidgets('Render App with AddressForm Widget', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: AddressForm(
            onSubmit: (value) => value,
            controller: AddressController(
              zipCodeValidator: (text) {
                if (text != null) {
                  if (text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  if (!zipcodeRegExp.hasMatch(text)) {
                    return 'Invalid zipcode';
                  }
                }
                return null;
              },
              housenumberValidator: (text) {
                if (text != null) {
                  if (text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  if (text.length >= 3 || int.tryParse(text) == null) {
                    return 'Invalid number';
                  }
                }
                return null;
              },
              suffixValidator: (text) {
                if (text != null) {
                  if (text.isNotEmpty && RegExp(r'/^[a-z]*$/').hasMatch(text)) {
                    return 'Invalid prefix';
                  }
                }
                return null;
              },
              streetValidator: (text) {
                if (text != null) {
                  if (text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                }
                return null;
              },
              cityValidator: (text) {
                if (text != null) {
                  if (text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                }
                return null;
              },
              onAutoComplete: (address) {
                return address;
              },
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  });
}
