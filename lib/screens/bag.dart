// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'cart_screen/models/Gaz.dart';

class EmailSenderModel {
  String? service_id;
  String? template_id;
  String? public_key;
  TemplateParams? templateParams;
  List<Gaz>? gases;

  EmailSenderModel(
      {required this.service_id,
      required this.template_id,
      required this.public_key,
      required this.templateParams,
      required this.gases});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'service_id': service_id,
      'template_id': template_id,
      'public_key': public_key,
      'templateParams': templateParams?.toJson(),
      'gases': gases!.map((x) => x.toMap()).toList(),
    };
  }

  factory EmailSenderModel.fromMap(Map<String, dynamic> map) {
    return EmailSenderModel(
      service_id: map['service_id'] != null ? map['service_id'] as String : null,
      template_id:
          map['template_id'] != null ? map['template_id'] as String : null,
      public_key: map['userId'] != null ? map['public_key'] as String : null,
      templateParams: map['templateParams'] != null
          ? TemplateParams.fromMap(
              map['templateParams'] as Map<String, dynamic>)
          : null,
      gases: map['gases'] != null
          ? List<Gaz>.from(
              (map['gases'] as List<int>).map<Gaz?>(
                (x) => Gaz.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailSenderModel.fromJson(String source) =>
      EmailSenderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TemplateParams {
  String? fromName;
  String? fromEmail;
  String? total;
  String? image;
  String? size;
  String? quantity;
  String? price;

  TemplateParams({
    this.fromName,
    this.fromEmail,
    this.total,
    this.image,
    this.size,
    this.quantity,
    this.price,
  });

  factory TemplateParams.fromMap(Map<String, dynamic> json) => TemplateParams(
        fromName: json["from_name"],
        fromEmail: json["from_email"],
        total: json["total"],
        image: json["image"],
        size: json["size"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "from_name": fromName,
        "from_email": fromEmail,
        "total": total,
        "image": image,
        "size": size,
        "quantity": quantity,
        "price": price,
      };
}
