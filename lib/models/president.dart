import 'api_item.dart';

class President implements ApiItem {
  @override
  final int id;
  final String name;
  final String lastName;
  final String? image;
  final String? politicalParty;
  final String? startPeriodDate;
  final String? endPeriodDate;
  @override
  final String? description;

  President({
    required this.id,
    required this.name,
    required this.lastName,
    this.image,
    this.politicalParty,
    this.startPeriodDate,
    this.endPeriodDate,
    this.description,
  });

  factory President.fromJson(Map<String, dynamic> json) => President(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        lastName: json['lastName'] ?? '',
        image: json['image'],
        politicalParty: json['politicalParty'],
        startPeriodDate: json['startPeriodDate'],
        endPeriodDate: json['endPeriodDate'],
        description: json['description'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastName': lastName,
        'image': image,
        'politicalParty': politicalParty,
        'startPeriodDate': startPeriodDate,
        'endPeriodDate': endPeriodDate,
        'description': description,
      };

  @override
  String get title => '$name $lastName'.trim();
  @override
  String? get subtitle => politicalParty;
  @override
  String? get imageUrl => image;
  @override
  Map<String, String> get details => {
        if (politicalParty != null) 'Partido': politicalParty!,
        if (startPeriodDate != null) 'Inicio': startPeriodDate!.split('T').first,
        if (endPeriodDate != null) 'Fin': endPeriodDate!.split('T').first,
      };
}
