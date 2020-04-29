// To parse this JSON data, do
//
//     final currency = currencyFromJson(jsonString);

import 'dart:convert';

Currency currencyFromJson(String str) => Currency.fromJson(json.decode(str));

String currencyToJson(Currency data) => json.encode(data.toJson());

class Currency {
  int id;
  String country;
  String currency;
  String code;
  String symbol;

  Currency({
    this.id,
    this.country,
    this.currency,
    this.code,
    this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        country: json["country"] == null ? null : json["country"],
        currency: json["currency"] == null ? null : json["currency"],
        code: json["code"] == null ? null : json["code"],
        symbol: json["symbol"] == null ? null : json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country == null ? null : country,
        "currency": currency == null ? null : currency,
        "code": code == null ? null : code,
        "symbol": symbol == null ? null : symbol,
      };
}
