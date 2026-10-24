import 'api_item.dart';

double? _toDouble(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString().replaceAll(',', '.'));
}

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
        id: (json['id'] as num?)?.toInt() ?? 0,
        name: json['name']?.toString() ?? 'Sin nombre',
        description: json['description']?.toString(),
        images: (json['images'] as List?)
                ?.map((e) => e is Map
                    ? (e['url'] ?? e['imageUrl'] ?? '').toString()
                    : e.toString())
                .where((s) => s.isNotEmpty)
                .toList() ??
            [],
        latitude: _toDouble(json['latitude']),
        longitude: _toDouble(json['longitude']),
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
