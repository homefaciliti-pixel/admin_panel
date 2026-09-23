class DashboardModel {
  final bool success;
  final List<DashboardCardModel> data;

  DashboardModel({
    required this.success,
    required this.data,
  });

  factory DashboardModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return DashboardModel(
      success: json['success'] == true,
      data: json['data'] is List
          ? (json['data'] as List)
          .whereType<Map>()
          .map(
            (item) => DashboardCardModel.fromJson(
          Map<String, dynamic>.from(item),
        ),
      )
          .toList()
          : [],
    );
  }
}


class DashboardCardModel {
  final String name;
  final int totalAmount;
  final String imageIcon;

  DashboardCardModel({
    required this.name,
    required this.totalAmount,
    required this.imageIcon,
  });

  factory DashboardCardModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return DashboardCardModel(
      name: json['name']?.toString() ?? '',
      totalAmount: _parseInt(
        json['totalAmount'],
      ),
      imageIcon: json['imageIcon']?.toString() ?? '',
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(
      value?.toString() ?? '',
    ) ??
        0;
  }
}