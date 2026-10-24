abstract class ApiItem {
  int get id;
  String get title;
  String? get subtitle;
  String? get imageUrl;
  String? get description;
  Map<String, String> get details;
  Map<String, dynamic> toJson();
}
