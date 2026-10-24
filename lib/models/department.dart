import 'api_item.dart';

class Department implements ApiItem {
  @override
  final int id;
  final String name;
  @override
  final String? description;
  final int? population;
  final double? surface;
  final String? phonePrefix;

  Department({
    required this.id,
    required this.name,
    this.description,
    this.population,
    this.surface,
    this.phonePrefix,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json['id'] ?? 0,
        name: json['name'] ?? 'Sin nombre',
        description: json['description'],
        population: (json['population'] as num?)?.toInt(),
        surface: (json['surface'] as num?)?.toDouble(),
        phonePrefix: json['phonePrefix']?.toString(),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'population': population,
        'surface': surface,
        'phonePrefix': phonePrefix,
      };

  @override
  String get title => name;
  @override
  String? get subtitle => population != null ? 'Población: $population' : null;
  @override
  String? get imageUrl => null;
  @override
  Map<String, String> get details => {
        if (population != null) 'Población': '$population',
        if (surface != null) 'Superficie (km²)': '$surface',
        if (phonePrefix != null) 'Prefijo telefónico': phonePrefix!,
      };
}
