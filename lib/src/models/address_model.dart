import 'package:flutter/material.dart' show immutable;

@immutable
class AddressModel {
  const AddressModel({
    this.zipcode,
    this.street,
    this.housenumber,
    this.suffix,
    this.city,
  });

  final String? zipcode;
  final String? street;
  final String? housenumber;
  final String? suffix;
  final String? city;

  AddressModel copyWith({
    String? zipcode,
    String? street,
    String? housenumber,
    String? suffix,
    String? city,
  }) =>
      AddressModel(
        zipcode: zipcode ?? this.zipcode,
        street: street ?? this.street,
        housenumber: housenumber ?? this.housenumber,
        suffix: suffix ?? this.suffix,
        city: city ?? this.city,
      );
}
