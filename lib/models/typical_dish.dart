import 'api_item.dart';

class TypicalDish implements ApiItem {
  @override
  final int id;
  final String name;
  @override
  final String? description;
  final String? ingredients;
  final String? image;

  TypicalDish({
    required this.id,
    required this.name,
    this.description,
    this.ingredients,
    this.image,
  });

  factory TypicalDish.fromJson(Map<String, dynamic> json) => TypicalDish(
        id: json['id'] ?? 0,
        name: json['name'] ?? 'Sin nombre',
        description: json['description'],
        ingredients: json['ingredients'],
        image: json['imageUrl'] ?? json['image'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'ingredients': ingredients,
        'imageUrl': image,
      };

  @override
  String get title => name;
  @override
  String? get subtitle => null;
  @override
  String? get imageUrl => image;
  @override
  Map<String, String> get details => {
        if (ingredients != null) 'Ingredientes': ingredients!,
      };
}
