// models/search_history_model.dart
class SearchHistoryModel {
  final String id;
  final String userId;
  final String searchTerm;
  final DateTime createdAt;
  final DateTime updatedAt;

  SearchHistoryModel({
    required this.id,
    required this.userId,
    required this.searchTerm,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      searchTerm: json['searchTerm'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'searchTerm': searchTerm,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class SearchHistoryResponse {
  final bool success;
  final String message;
  final List<SearchHistoryModel> data;

  SearchHistoryResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SearchHistoryResponse.fromJson(Map<String, dynamic> json) {
    return SearchHistoryResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<SearchHistoryModel>.from(
              json['data'].map((x) => SearchHistoryModel.fromJson(x)))
          : [],
    );
  }
}

class SearchHistoryCreateResponse {
  final bool success;
  final String message;
  final SearchHistoryModel data;

  SearchHistoryCreateResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SearchHistoryCreateResponse.fromJson(Map<String, dynamic> json) {
    return SearchHistoryCreateResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: SearchHistoryModel.fromJson(json['data']),
    );
  }
}
