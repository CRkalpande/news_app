import 'dart:convert';

import 'package:collection/collection.dart';


class Source {
  final dynamic id;
  final String? name;

  const Source({this.id, this.name});

  @override
  String toString() => 'Source(id: $id, name: $name)';

  factory Source.fromMap(Map<String, dynamic> data) => Source(
        id: data['id'] as dynamic,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Source].
  factory Source.fromJson(String data) {
    return Source.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Source] to a JSON string.
  String toJson() => json.encode(toMap());

  Source copyWith({
    dynamic id,
    String? name,
  }) {
    return Source(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Source) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
