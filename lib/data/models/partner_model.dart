class PartnerModel {
  /// basic info
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String city;
  final String state;
  final String locality;
  final String address;
  final String image;

  /// status flags
  bool status; // active / inactive
  bool isApproved; // approved / pending

  /// additional details
  final String gender;
  final String experience;
  final List<String> services;

  /// kyc
  final String aadhaarNumber;
  final String panNumber;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final List<String> documents;

  /// document images
  final String policeVerificationImage;
  final String aadhaarImage;
  final String panImage;

  /// wallet / earnings
  final double walletBalance;
  final double totalEarnings;
  final double withdrawnAmount;

  /// booking stats
  final int totalBookings;
  final int completedBookings;
  final int cancelledBookings;
  final int pendingBookings;

  /// reviews
  final double rating;
  final int totalReviews;

  /// profile created date
  final String createdAt;

  final String? latitude;
  final String? longitude;
  final String? locationTime;

  PartnerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.city,
    required this.state,
    required this.locality,
    required this.address,
    required this.image,
    required this.status,
    required this.isApproved,
    required this.gender,
    required this.experience,
    required this.services,
    required this.aadhaarNumber,
    required this.panNumber,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.documents,
    this.policeVerificationImage = '',
    this.aadhaarImage = '',
    this.panImage = '',
    required this.walletBalance,
    required this.totalEarnings,
    required this.withdrawnAmount,
    required this.totalBookings,
    required this.completedBookings,
    required this.cancelledBookings,
    required this.pendingBookings,
    required this.rating,
    required this.totalReviews,
    required this.createdAt,
    this.latitude,
    this.longitude,
    this.locationTime,
  });

  /// helper for updates
  PartnerModel copyWith({
    int? id,
    String? name,
    String? email,
    String? mobile,
    String? city,
    String? state,
    String? locality,
    String? address,
    String? image,
    bool? status,
    bool? isApproved,
    String? gender,
    String? experience,
    List<String>? services,
    String? aadhaarNumber,
    String? panNumber,
    String? bankName,
    String? accountNumber,
    String? ifscCode,
    List<String>? documents,
    String? policeVerificationImage,
    String? aadhaarImage,
    String? panImage,
    double? walletBalance,
    double? totalEarnings,
    double? withdrawnAmount,
    int? totalBookings,
    int? completedBookings,
    int? cancelledBookings,
    int? pendingBookings,
    double? rating,
    int? totalReviews,
    String? createdAt,
    String? latitude,
    String? longitude,
    String? locationTime,
  }) {
    return PartnerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      city: city ?? this.city,
      state: state ?? this.state,
      locality: locality ?? this.locality,
      address: address ?? this.address,
      image: image ?? this.image,
      status: status ?? this.status,
      isApproved: isApproved ?? this.isApproved,
      gender: gender ?? this.gender,
      experience: experience ?? this.experience,
      services: services ?? this.services,
      aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
      panNumber: panNumber ?? this.panNumber,
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      documents: documents ?? this.documents,
      policeVerificationImage: policeVerificationImage ?? this.policeVerificationImage,
      aadhaarImage: aadhaarImage ?? this.aadhaarImage,
      panImage: panImage ?? this.panImage,
      walletBalance: walletBalance ?? this.walletBalance,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      withdrawnAmount: withdrawnAmount ?? this.withdrawnAmount,
      totalBookings: totalBookings ?? this.totalBookings,
      completedBookings: completedBookings ?? this.completedBookings,
      cancelledBookings: cancelledBookings ?? this.cancelledBookings,
      pendingBookings: pendingBookings ?? this.pendingBookings,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      createdAt: createdAt ?? this.createdAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationTime: locationTime ?? this.locationTime,
    );
  }
}