class DashboardAmcModel {
  final int totalAmc;
  final int activeAmc;
  final int expiredAmc;
  final int totalVisits;
  final int todayVisits;
  final int pendingVisits;
  final double revenue;
  final int completedVisits;
  final double pendingPayment;
  final double partnerPayout;
  final double todayCollection;

DashboardAmcModel({
    required this.totalAmc,
    required this.activeAmc,
    required this.expiredAmc,
    required this.totalVisits,
    required this.todayVisits,
    required this.pendingVisits,
    required this.revenue,
  required this.completedVisits,
  required this.pendingPayment,
  required this.partnerPayout,
  required this.todayCollection,
  });

  factory DashboardAmcModel.fromJson(Map<String, dynamic> json) {
    return DashboardAmcModel(
      totalAmc: int.tryParse(json['totalAmc'].toString()) ?? 0,
      activeAmc: int.tryParse(json['activeAmc'].toString()) ?? 0,
      expiredAmc: int.tryParse(json['expiredAmc'].toString()) ?? 0,
      totalVisits: int.tryParse(json['totalVisits'].toString()) ?? 0,
      todayVisits: int.tryParse(json['todayVisits'].toString()) ?? 0,
      pendingVisits: int.tryParse(json['pendingVisits'].toString()) ?? 0,
      revenue: double.tryParse(json['revenue'].toString()) ?? 0.0,
      completedVisits:
      int.tryParse(json['completedVisits'].toString()) ?? 0,

      pendingPayment:
      double.tryParse(json['pendingPayment'].toString()) ?? 0,

      partnerPayout:
      double.tryParse(json['partnerPayout'].toString()) ?? 0,

      todayCollection:
      double.tryParse(json['todayCollection'].toString()) ?? 0,
    );
  }
}