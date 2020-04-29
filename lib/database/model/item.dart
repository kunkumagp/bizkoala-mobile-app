// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

Item itemsFromJson(String str) => Item.fromJson(json.decode(str));

String itemsToJson(Item data) => json.encode(data.toJson());

class Item {
  int id;
  int categoryId;
  String code;
  String name;
  String price;
  String details;
  bool isActivy;

  Item({
    this.id,
    this.categoryId,
    this.code,
    this.name,
    this.price,
    this.details,
    this.isActivy,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        details: json["details"] == null ? null : json["details"],
        isActivy: json["is_activy"] == null ? null : json["is_activy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId == null ? null : categoryId,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "details": details == null ? null : details,
        "is_activy": isActivy == null ? null : isActivy,
      };
}
