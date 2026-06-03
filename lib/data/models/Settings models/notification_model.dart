class NotificationModel {
  /// unique notification id
  final int id;

  /// notification title
  final String title;

  /// notification message/body
  final String message;

  /// target audience
  /// example: All Users / All Partners / Selected
  final String audience;

  /// created date
  final String createdAt;

  /// active / inactive
  bool status;

  // sent /not sent
  bool isSent;

  ///sent time
  String sentAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.audience,
    required this.createdAt,
    required this.status,
    this.isSent =false,
    this.sentAt ="",

  });

  /// copyWith
  ///
  /// edit/update ke kaam aata hai
  NotificationModel copyWith({
    int? id,
    String? title,
    String? message,
    String? audience,
    String? createdAt,
    bool? status,
    bool? isSent,
    String? sentAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      audience: audience ?? this.audience,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      isSent: isSent ?? this.isSent,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}