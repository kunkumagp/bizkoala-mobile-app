// To parse this JSON data, do
//
//     final quotation = quotationFromJson(jsonString);

import 'dart:convert';

Quotation quotationFromJson(String str) => Quotation.fromJson(json.decode(str));

String quotationToJson(Quotation data) => json.encode(data.toJson());

class Quotation {
  int id;
  String title;
  String note;
  String tax;
  String date;
  int customerId;
  int send;

  Quotation({
    this.id,
    this.title,
    this.note,
    this.tax,
    this.date,
    this.customerId,
    this.send,
  });

  factory Quotation.fromJson(Map<String, dynamic> json) => Quotation(
        id: json["id"],
        title: json["title"] == null ? null : json["title"],
        note: json["note"] == null ? null : json["note"],
        tax: json["tax"] == null ? null : json["tax"],
        date: json["date"] == null ? null : json["date"],
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        send: json["send"] == null ? null : json["send"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title == null ? null : title,
        "note": note == null ? null : note,
        "tax": tax == null ? null : tax,
        "date": date == null ? null : date,
        "customer_id": customerId == null ? null : customerId,
        "send": send == null ? null : send,
      };
}
