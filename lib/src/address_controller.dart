import 'package:flutter/foundation.dart';

class AddressController extends ChangeNotifier {
  final String zipcode;
  final int houseNumber;
  final String prefix;
  final String street;
  final String city;

  AddressController(this.zipcode, this.houseNumber, this.prefix, this.street, this.city);

  
}
