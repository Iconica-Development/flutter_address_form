import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_address_form/src/address_controller.dart';
import 'package:flutter_address_form/src/models/address.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({Key? key}) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final AddressController _addressController = AddressController(() {});

  final RegExp _zipcodeRegExp = RegExp(r'^[1-9][0-9]{3}\s?[a-zA-Z]{2}$');

  @override
  void initState() {
    _addressController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressFormTextField(
          controller: _addressController.zipcode,
          validator: (text) {
            if (text.isEmpty) {
              return 'Can\'t be empty';
            }
            if (!_zipcodeRegExp.hasMatch(text)) {
              return 'Invalid zipcode';
            }
            return null;
          },
          label: const Text('Postcode'),
        ),
        Flexible(
          child: Row(
            children: [
              AddressFormTextField(
                controller: _addressController.houseNumber,
                validator: (text) {
                  if (text.isEmpty) {
                    return 'Can\'t be empty';
                  }
                  if (text.length >= 3 || int.tryParse(text) == null) {
                    return 'Invalid number';
                  }
                  return null;
                },
                label: const Text('Huisnummer'),
              ),
              AddressFormTextField(
                controller: _addressController.suffix,
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
                label: const Text('Toevoeging'),
              ),
            ],
          ),
        ),
        AddressFormTextField(
          controller: _addressController.street,
          validator: (text) {
            if (text.isEmpty) {
              return 'Can\'t be empty';
            }
            return null;
          },
          label: const Text('Straatnaam'),
        ),
        AddressFormTextField(
          controller: _addressController.city,
          validator: (text) {
            if (text.isEmpty) {
              return 'Can\'t be empty';
            }
            return null;
          },
          label: const Text('Woonplaats'),
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
    super.dispose();
  }
}

class AddressFormTextField extends StatefulWidget {
  final Widget label;
  final TextEditingController controller;
  final String? Function(String) validator;
  const AddressFormTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  State<AddressFormTextField> createState() => _AddressFormTextFieldState();
}

class _AddressFormTextFieldState extends State<AddressFormTextField> {
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
                    label: widget.label,
                    border: const OutlineInputBorder(),
                    errorText: _errorText),
              ),
            ),
          );
        });
  }
}
