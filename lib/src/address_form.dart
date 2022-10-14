import 'package:flutter/material.dart';
import 'package:flutter_address_form/src/models/address.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({Key? key}) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _prefixController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final RegExp _zipcodeRegExp = RegExp(r'^[1-9][0-9]{3}\s?[a-zA-Z]{2}$');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressFormTextField(
          controller: _zipcodeController,
          validator: (text) {
            if (text.isEmpty) {
              return 'Can\'t be empty';
            }
            if (!_zipcodeRegExp.hasMatch(text)) {
              return 'Invalid zipcode';
            }
            return null;
          },
          label: 'Postcode',
        ),
        Flexible(
          child: Row(
            children: [
              AddressFormTextField(
                controller: _houseNumberController,
                validator: (text) {
                  if (text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  if (text.length >= 3 || int.tryParse(text) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
                label: 'Huisnummer',
              ),
              AddressFormTextField(
                controller: _prefixController,
                validator: (text) {
                  if (text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  if (RegExp(r'/^[a-z]*$/').hasMatch(text) &&
                      text.length != 1) {
                    return 'Invalid prefix';
                  }
                  return null;
                },
                label: 'Toevoeging',
              ),
            ],
          ),
        ),
        AddressFormTextField(
          controller: _streetController,
          validator: (text) {
            if (text.isEmpty) {
              return 'Can\'t be empty';
            }
            return null;
          },
          label: 'Straatnaam',
        ),
        AddressFormTextField(
          controller: _cityController,
          validator: (text) {
            if (text.isEmpty) {
              return 'Can\'t be empty';
            }
            return null;
          },
          label: 'Woonplaats',
        ),
        TextButton(
          onPressed: () {},
          child: Text('Test'),
        )
      ],
    );
  }

  @override
  void dispose() {
    _zipcodeController.dispose();
    _houseNumberController.dispose();
    _prefixController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}

class AddressFormTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String) validator;
  AddressFormTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  State<AddressFormTextField> createState() => _AddressFormTextFieldState();
}

class _AddressFormTextFieldState extends State<AddressFormTextField> {
  final Address addressModel = Address();

  String? get _errorText {
    final text = widget.controller.value.text;
    return widget.validator(text);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.controller,
        builder: (context, value, _) {
          return Flexible(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                    label: Text(widget.label),
                    border: const OutlineInputBorder(),
                    errorText: _errorText),
              ),
            ),
          );
        });
  }
}
