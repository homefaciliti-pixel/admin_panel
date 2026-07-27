class BookServiceModel {
  String customerId;
  String amcId;
  String serviceId;
  String partnerId;
  String date;
  String timeSlot;
  String priority;
  String instruction;

  BookServiceModel({
    required this.customerId,
    required this.amcId,
    required this.serviceId,
    required this.partnerId,
    required this.date,
    required this.timeSlot,
    required this.priority,
    required this.instruction,
  });

  Map<String, dynamic> toJson() {
    return {
      "customerId": customerId,
      "amcId": amcId,
      "serviceId": serviceId,
      "partnerId": partnerId,
      "date": date,
      "timeSlot": timeSlot,
      "priority": priority,
      "instruction": instruction,
    };
  }
}