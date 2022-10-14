class Address {
  Address({
    this.zipcode,
    this.street,
    this.housenumber,
    this.suffix,
    this.city,
  });

  final String? zipcode;
  final String? street;
  final int? housenumber;
  final String? suffix;
  final String? city;

  Address copyWith({
    String? zipcode,
    String? street,
    int? housenumber,
    String? suffix,
    String? city,
  }) =>
      Address(
        zipcode: zipcode ?? this.zipcode,
        street: street ?? this.street,
        housenumber: housenumber ?? this.housenumber,
        suffix: suffix ?? this.suffix,
        city: city ?? this.city,
      );
}
