// To parse this JSON data, do
//
//     final quoteDetail = quoteDetailFromJson(jsonString);

import 'dart:convert';

QuoteDetail quoteDetailFromJson(String str) =>
    QuoteDetail.fromJson(json.decode(str));

String quoteDetailToJson(QuoteDetail data) => json.encode(data.toJson());

class QuoteDetail {
  int id;
  int quoteId;
  int itemId;
  String price;
  int quantity;

  QuoteDetail({
    this.id,
    this.quoteId,
    this.itemId,
    this.price,
    this.quantity,
  });

  factory QuoteDetail.fromJson(Map<String, dynamic> json) => QuoteDetail(
        id: json["id"],
        quoteId: json["quote_id"] == null ? null : json["quote_id"],
        itemId: json["item_id"] == null ? null : json["item_id"],
        price: json["price"] == null ? null : json["price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quote_id": quoteId == null ? null : quoteId,
        "item_id": itemId == null ? null : itemId,
        "price": price == null ? null : price,
        "quantity": quantity == null ? null : quantity,
      };
}
