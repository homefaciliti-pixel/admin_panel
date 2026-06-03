class DashboardModel {
  final int totalUsers;
  final int totalCategories;
  final int totalServices;
  final int totalPartners;
  final int totalOrders;
  final int todayOrders;
  final int completeOrders;
  final int assignedOrders;
  final int cancelOrders;
  final int totalSupporters;
  final String subscriptionEarning;
  final String orderEarning;
  final int rawSubscriptionEarning;
  final int rawOrderEarning;

  DashboardModel({
    required this.totalUsers,
    required this.totalCategories,
    required this.totalServices,
    required this.totalPartners,
    required this.totalOrders,
    required this.todayOrders,
    required this.completeOrders,
    required this.assignedOrders,
    required this.cancelOrders,
    required this.totalSupporters,
    required this.subscriptionEarning,
    required this.orderEarning,
    required this.rawSubscriptionEarning,
    required this.rawOrderEarning,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalUsers: json['totalUsers'] ?? 0,
      totalCategories: json['totalCategories'] ?? 0,
      totalServices: json['totalServices'] ?? 0,
      totalPartners: json['totalPartners'] ?? 0,
      totalOrders: json['totalOrders'] ?? 0,
      todayOrders: json['todayOrders'] ?? 0,
      completeOrders: json['completeOrders'] ?? 0,
      assignedOrders: json['assignedOrders'] ?? 0,
      cancelOrders: json['cancelOrders'] ?? 0,
      totalSupporters: json['totalSupporters'] ?? 0,
      subscriptionEarning: json['subscriptionEarning'] ?? '₹0',
      orderEarning: json['orderEarning'] ?? '₹0',
      rawSubscriptionEarning: json['rawSubscriptionEarning'] ?? 0,
      rawOrderEarning: json['rawOrderEarning'] ?? 0,
    );
  }
}