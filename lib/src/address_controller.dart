import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_address_form/src/models/address.dart';

class AddressController extends ChangeNotifier {
  Address address = const Address();

  final TextEditingController zipcode = TextEditingController();
  final TextEditingController houseNumber = TextEditingController();
  final TextEditingController suffix = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController city = TextEditingController();

  final Function()? onChangeInputCallback;

  AddressController(this.onChangeInputCallback);

  Address get getAddress => address;

  void setAddress(
    String zipcode,
    String street,
    int housenumber,
    String suffix,
    String city,
  ) {
    address = address.copyWith(
      zipcode: zipcode,
      street: street,
      housenumber: housenumber,
      suffix: suffix,
      city: city,
    );
    notifyListeners();
  }

  void onChangeInput() {
    onChangeInputCallback?.call();
  }
}
