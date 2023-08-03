import 'dart:convert';

import 'package:collection/collection.dart';

import 'article.dart';


class Model {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  const Model({this.status, this.totalResults, this.articles});

  @override
  String toString() {
    return 'Model(status: $status, totalResults: $totalResults, articles: $articles)';
  }

  factory Model.fromMap(Map<String, dynamic> data) => Model(
        status: data['status'] as String?,
        totalResults: data['totalResults'] as int?,
        articles: (data['articles'] as List<dynamic>?)
            ?.map((e) => Article.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'totalResults': totalResults,
        'articles': articles?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Model].
  factory Model.fromJson(String data) {
    return Model.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Model] to a JSON string.
  String toJson() => json.encode(toMap());

  Model copyWith({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) {
    return Model(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Model) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      status.hashCode ^ totalResults.hashCode ^ articles.hashCode;
}
