import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddressForm extends StatefulWidget {
  AddressForm({Key? key}) : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final TextEditingController _zipcodeController = TextEditingController();
  final RegExp _zipcodeRegExp = RegExp(r'^[1-9][0-9]{3}\s?[a-zA-Z]{2}$');
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          _createField(
            label: 'Postcode',
            controller: _zipcodeController,
          ),
          Flexible(
            child: Row(
              children: [
                _createField(
                  label: 'Huisnummer',
                  controller: TextEditingController(),
                ),
                _createField(
                  label: 'Toevoeging',
                  controller: TextEditingController(),
                ),
              ],
            ),
          ),
          _createField(
            label: 'Straatnaam',
            controller: TextEditingController(),
          ),
          _createField(
            label: 'Woonplaats',
            controller: TextEditingController(),
          )
        ],
      ),
    );
  }

  Widget _createField(
      {required String label, required TextEditingController controller}) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          validator: (value) {
            print(_zipcodeRegExp.hasMatch(value!));
          },
          decoration: InputDecoration(
            label: Text(label),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
