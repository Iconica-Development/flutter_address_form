import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_address_form/src/models/address_model.dart';

class AddressForm extends StatelessWidget {
  AddressForm({
    Key? key,
    this.zipCodeLabel = const Text('Zipcode'),
    this.housenumberLabel = const Text('Housenumber'),
    this.suffixLabel = const Text('Suffix'),
    this.streetLabel = const Text('Street'),
    this.cityLabel = const Text('City'),
    required this.zipCodeValidator,
    required this.housenumberValidator,
    required this.suffixValidator,
    required this.streetValidator,
    required this.cityValidator,
    AddressController? controller,
  }) {
    _addressController =
        controller ?? AddressController(onAutoComplete: (model) => model);
  }

  final Widget zipCodeLabel;
  final Widget housenumberLabel;
  final Widget suffixLabel;
  final Widget streetLabel;
  final Widget cityLabel;

  final String? Function(String) zipCodeValidator;
  final String? Function(String) housenumberValidator;
  final String? Function(String) suffixValidator;
  final String? Function(String) streetValidator;
  final String? Function(String) cityValidator;

  late final AddressController _addressController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressFormTextField(
          controller: _addressController._zipcodeController,
          validator: zipCodeValidator,
          label: zipCodeLabel,
        ),
        Flexible(
          child: Row(
            children: [
              AddressFormTextField(
                controller: _addressController._housenumberController,
                validator: housenumberValidator,
                label: housenumberLabel,
              ),
              AddressFormTextField(
                controller: _addressController._suffixController,
                validator: suffixValidator,
                label: suffixLabel,
              ),
            ],
          ),
        ),
        AddressFormTextField(
          controller: _addressController._streetController,
          validator: streetValidator,
          label: streetLabel,
        ),
        AddressFormTextField(
          controller: _addressController._cityController,
          validator: cityValidator,
          label: cityLabel,
        ),
      ],
    );
  }
}

class AddressFormTextField extends StatelessWidget {
  final Widget label;
  final TextEditingController controller;
  final String? Function(String) validator;
  const AddressFormTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  String? get _errorText => validator(controller.value.text);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          return Flexible(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    label: label,
                    border: const OutlineInputBorder(),
                    errorText: _errorText),
              ),
            ),
          );
        });
  }
}

class AddressController extends ChangeNotifier {
  final AddressModel? initialValue;
  final FutureOr<AddressModel> Function(AddressModel)? onAutoComplete;

  AddressController({this.initialValue, this.onAutoComplete}) {
    _model = initialValue ??
        const AddressModel(
          zipcode: null,
          street: null,
          housenumber: null,
          suffix: null,
          city: null,
        );

    _zipcodeController.addListener(_update);
    _streetController.addListener(_update);
    _housenumberController.addListener(_update);
    _suffixController.addListener(_update);
    _cityController.addListener(_update);
  }

  late AddressModel _model;

  late final _zipcodeController =
      TextEditingController(text: initialValue?.zipcode);
  late final _streetController =
      TextEditingController(text: initialValue?.street);
  late final _housenumberController =
      TextEditingController(text: initialValue?.housenumber.toString());
  late final _suffixController =
      TextEditingController(text: initialValue?.suffix);
  late final _cityController = TextEditingController(text: initialValue?.city);

  AddressModel get model => _model;

  void _update() async {
    AddressModel updatedModel = _model.copyWith(
        zipcode: _zipcodeController.text,
        street: _streetController.text,
        housenumber: int.tryParse(_housenumberController.text),
        suffix: _suffixController.text,
        city: _cityController.text);
    _model = await onAutoComplete?.call(updatedModel) ?? updatedModel;

    if (_model.zipcode != updatedModel.zipcode) {
      _zipcodeController.text = _model.zipcode ?? '';
    }
    if (_model.street != updatedModel.street) {
      _streetController.text = _model.street ?? '';
    }
    if (_model.housenumber != updatedModel.housenumber) {
      _housenumberController.text = _model.housenumber?.toString() ?? '';
    }
    if (_model.suffix != updatedModel.suffix) {
      _suffixController.text = _model.suffix ?? '';
    }
    if (_model.city != updatedModel.city) {
      _cityController.text = _model.city ?? '';
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _zipcodeController.dispose();
    _streetController.dispose();
    _housenumberController.dispose();
    _suffixController.dispose();
    _cityController.dispose();
  }
}
