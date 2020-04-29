// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  int id;
  String name;
  String email;
  String address;
  String telephone;

  Customer({
    this.id,
    this.name,
    this.email,
    this.address,
    this.telephone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : json["address"],
        telephone: json["telephone"] == null ? null : json["telephone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "telephone": telephone == null ? null : telephone,
      };
}
