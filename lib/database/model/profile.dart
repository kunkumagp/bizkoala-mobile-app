// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  int id;
  int systemId;
  int currencyId;
  String email;
  String companyName;
  String address;
  String telephone;
  String logo;

  Profile({
    this.id,
    this.systemId,
    this.currencyId,
    this.email,
    this.companyName,
    this.address,
    this.telephone,
    this.logo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        systemId: json["system_id"] == null ? null : json["system_id"],
        currencyId: json["currency_id"] == null ? null : json["currency_id"],
        email: json["email"] == null ? null : json["email"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        address: json["address"] == null ? null : json["address"],
        telephone: json["telephone"] == null ? null : json["telephone"],
        logo: json["logo"] == null ? null : json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "system_id": systemId == null ? null : systemId,
        "currency_id": currencyId == null ? null : currencyId,
        "email": email == null ? null : email,
        "company_name": companyName == null ? null : companyName,
        "address": address == null ? null : address,
        "telephone": telephone == null ? null : telephone,
        "logo": logo == null ? null : logo,
      };
}
