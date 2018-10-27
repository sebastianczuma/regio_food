import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';

@JsonSerializable(nullable: false, createToJson: false)
class Details {
  final String url;
  final String name;
  final String look;
  final String shape;
  final String size;
  final String color;
  final String consistency;
  final String taste;
  final String other;
  final String tradition;
  final String category;

  Details({this.url,
    this.name,
    this.look,
    this.shape,
    this.size,
    this.color,
    this.consistency,
    this.taste,
    this.other,
    this.tradition,
    this.category});

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
}
