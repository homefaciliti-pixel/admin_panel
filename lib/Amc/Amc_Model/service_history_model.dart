class ServiceHistoryModel {
  final String bookingId;
  final String serviceName;
  final String partnerName;
  final String visitDate;
  final String visitTime;
  final String status;
  final String notes;
  final double rating;

  const ServiceHistoryModel({
    required this.bookingId,
    required this.serviceName,
    required this.partnerName,
    required this.visitDate,
    required this.visitTime,
    required this.status,
    required this.notes,
    required this.rating,
  });
}