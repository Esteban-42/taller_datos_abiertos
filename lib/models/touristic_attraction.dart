import 'api_item.dart';

class TouristicAttraction implements ApiItem {
  @override
  final int id;
  final String name;
  @override
  final String? description;
  final List<String> images;
  final double? latitude;
  final double? longitude;

  TouristicAttraction({
    required this.id,
    required this.name,
    this.description,
    this.images = const [],
    this.latitude,
    this.longitude,
  });

  factory TouristicAttraction.fromJson(Map<String, dynamic> json) =>
      TouristicAttraction(
        id: json['id'] ?? 0,
        name: json['name'] ?? 'Sin nombre',
        description: json['description'],
        images: (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'images': images,
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  String get title => name;
  @override
  String? get subtitle =>
      latitude != null && longitude != null ? 'Lat: $latitude, Lng: $longitude' : null;
  @override
  String? get imageUrl => images.isNotEmpty ? images.first : null;
  @override
  Map<String, String> get details => {
        if (latitude != null) 'Latitud': '$latitude',
        if (longitude != null) 'Longitud': '$longitude',
        if (images.length > 1) 'Imágenes disponibles': '${images.length}',
      };
}
