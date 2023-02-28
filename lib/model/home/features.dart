import 'dart:convert';

class Feature {
  String bg_name;

  Feature(
    this.bg_name,
  );
  
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'bg_name': bg_name});
  
    return result;
  }

  factory Feature.fromMap(Map<String, dynamic> map) {
    return Feature(
      map['bg_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Feature.fromJson(String source) => Feature.fromMap(json.decode(source));
}
