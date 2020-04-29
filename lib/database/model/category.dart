// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  int id;
  int parentId;
  String name;
  String label;
  String details;

  Category({
    this.id,
    this.parentId,
    this.name,
    this.label,
    this.details,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        name: json["name"] == null ? null : json["name"],
        label: json["label"] == null ? null : json["label"],
        details: json["details"] == null ? null : json["details"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId == null ? null : parentId,
        "name": name == null ? null : name,
        "label": label == null ? null : label,
        "details": details == null ? null : details,
      };
}
