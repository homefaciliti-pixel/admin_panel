class AmcReportModel {
  final int totalSubscriptions;
  final double totalRevenue;
  final int totalVisits;
  final double totalPayoutsReleased;

  const AmcReportModel({
    required this.totalSubscriptions,
    required this.totalRevenue,
    required this.totalVisits,
    required this.totalPayoutsReleased,
  });

  factory AmcReportModel.fromJson(Map<String, dynamic> json) {
    return AmcReportModel(
      totalSubscriptions: json["totalSubscriptions"] ?? 0,
      totalRevenue: double.tryParse(json["totalRevenue"].toString()) ?? 0,
      totalVisits: json["totalVisits"] ?? 0,
      totalPayoutsReleased:
          double.tryParse(json["totalPayoutsReleased"].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalSubscriptions": totalSubscriptions,
      "totalRevenue": totalRevenue,
      "totalVisits": totalVisits,
      "totalPayoutsReleased": totalPayoutsReleased,
    };
  }
}
