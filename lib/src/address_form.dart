import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_address_form/src/models/address_model.dart';

/// A widget that creates a form with different address fields widgets.
/// Returns a `AddressModel` Object from a `AddressController`.
class AddressForm extends StatefulWidget {
  AddressForm({
    super.key,
    AddressController? controller,
    this.zipCodeDecoration = const InputDecoration(label: Text('Zipcode')),
    this.housenumberDecoration =
        const InputDecoration(label: Text('Housenumber')),
    this.suffixDecoration = const InputDecoration(label: Text('Suffix')),
    this.streetDecoration = const InputDecoration(label: Text('Street')),
    this.cityDecoration = const InputDecoration(label: Text('City')),
    required this.onSubmit,
  }) {
    _addressController = controller ??
        AddressController(
          onAutoComplete: (model) => model,
          zipCodeValidator: (text) => null,
          cityValidator: (text) => null,
          housenumberValidator: (text) => null,
          streetValidator: (text) => null,
          suffixValidator: (text) => null,
        );
  }

  final InputDecoration zipCodeDecoration;
  final InputDecoration housenumberDecoration;
  final InputDecoration suffixDecoration;
  final InputDecoration streetDecoration;
  final InputDecoration cityDecoration;

  final ValueChanged<String> onSubmit;

  /// Controls the `AddressModel`
  late final AddressController _addressController;

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          AddressFormTextField(
            validator: widget._addressController.zipCodeValidator,
            controller: widget._addressController._zipcodeController,
            fieldDecoration: widget.zipCodeDecoration,
          ),
          Flexible(
            child: Row(
              children: [
                AddressFormTextField(
                  validator: widget._addressController.housenumberValidator,
                  controller: widget._addressController._housenumberController,
                  fieldDecoration: widget.housenumberDecoration,
                ),
                AddressFormTextField(
                  validator: widget._addressController.suffixValidator,
                  controller: widget._addressController._suffixController,
                  fieldDecoration: widget.suffixDecoration,
                ),
              ],
            ),
          ),
          AddressFormTextField(
            validator: widget._addressController.streetValidator,
            controller: widget._addressController._streetController,
            fieldDecoration: widget.streetDecoration,
          ),
          AddressFormTextField(
            validator: widget._addressController.cityValidator,
            controller: widget._addressController._cityController,
            fieldDecoration: widget.cityDecoration,
          ),
        ],
      ),
    );
  }
}

class AddressFormTextField extends StatelessWidget {
  AddressFormTextField(
      {super.key,
      required this.fieldDecoration,
      required this.controller,
      required this.validator});

  final TextEditingController controller;
  final InputDecoration fieldDecoration;
  final String? Function(String) validator;

  late InputDecoration _addressFieldDecoration;

  String? get _errorText => validator(controller.value.text);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        _addressFieldDecoration =
            fieldDecoration.copyWith(errorText: _errorText);
        return Flexible(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: _addressFieldDecoration,
            ),
          ),
        );
      },
    );
  }
}

class AddressController extends ChangeNotifier {
  /// An optional value to initialize the form field to, or null otherwise.
  final AddressModel? initialValue;

  /// When the form changes, the function passes the current `AddressModel` as an argument and gives the possibility to manipulate and return a `AddressModel`.
  final FutureOr<AddressModel> Function(AddressModel)? onAutoComplete;

  AddressController(
      {this.initialValue,
      this.onAutoComplete,
      required this.zipCodeValidator,
      required this.housenumberValidator,
      required this.suffixValidator,
      required this.streetValidator,
      required this.cityValidator}) {
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

  final String? Function(String) zipCodeValidator;
  final String? Function(String) housenumberValidator;
  final String? Function(String) suffixValidator;
  final String? Function(String) streetValidator;
  final String? Function(String) cityValidator;

  late final _zipcodeController =
      TextEditingController(text: initialValue?.zipcode);
  late final _streetController =
      TextEditingController(text: initialValue?.street);
  late final _housenumberController =
      TextEditingController(text: initialValue?.housenumber);
  late final _suffixController =
      TextEditingController(text: initialValue?.suffix);
  late final _cityController = TextEditingController(text: initialValue?.city);

  AddressModel get model => _model;

  bool validate() {
    if (zipCodeValidator.call(_zipcodeController.text) == null &&
        streetValidator.call(_streetController.text) == null &&
        housenumberValidator.call(_housenumberController.text) == null &&
        suffixValidator.call(_suffixController.text) == null &&
        cityValidator.call(_cityController.text) == null) {
      return true;
    } else {
      return false;
    }
  }

  void _update() async {
    AddressModel updatedModel = _model.copyWith(
        zipcode: _zipcodeController.text,
        street: _streetController.text,
        housenumber: _housenumberController.text,
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
      _housenumberController.text = _model.housenumber ?? '';
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
