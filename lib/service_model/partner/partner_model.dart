class PartnerModel {
  final int id;

  final String name;
  final String email;
  final String mobile;

  final String city;
  final String state;
  final String locality;
  final String address;

  /// Profile image
  final String image;

  /// KYC images
  final String aadhaarFrontImage;
  final String aadhaarBackImage;
  final String panCardImage;

  final bool status;
  final bool isApproved;

  final String gender;
  final String experience;
  final List<String> services;

  final String aadhaarNumber;
  final String panNumber;

  final String bankName;
  final String accountNumber;
  final String ifscCode;

  final List<String> documents;

  final double walletBalance;
  final double totalEarnings;
  final double withdrawnAmount;

  final int totalBookings;
  final int completedBookings;
  final int cancelledBookings;
  final int pendingBookings;

  final double rating;
  final int totalReviews;

  final String createdAt;
  final String policeVerificationImage;

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
    required this.aadhaarFrontImage,
    required this.aadhaarBackImage,
    required this.panCardImage,
    required this.policeVerificationImage,
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
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    String safeString(dynamic value) => value == null ? '' : value.toString();

    return PartnerModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: safeString(json['name']),
      email: safeString(json['email']),
      mobile: safeString(json['mobile']),
      city: safeString(json['city']),
      state: safeString(json['state']),
      locality: safeString(json['locality']),
      address: safeString(json['address']),
      image: safeString(json['image']),

      aadhaarFrontImage: safeString(json['aadharFront']).isNotEmpty
          ? safeString(json['aadharFront'])
          : safeString(json['aadhaarImage']),

      aadhaarBackImage: safeString(json['aadharBack']),
      panCardImage: safeString(json['panImage']),

      status: json['status'] == true,
      isApproved: json['isApproved'] == true,
      gender: safeString(json['gender']),
      experience: safeString(json['experience']),

      services: (json['services'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],

      aadhaarNumber: safeString(json['aadhaarNumber']),
      panNumber: safeString(json['panNumber']),
      bankName: safeString(json['bankName']),
      accountNumber: safeString(json['accountNumber']),
      ifscCode: safeString(json['ifscCode']),

      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],

      walletBalance: (json['walletBalance'] as num?)?.toDouble() ?? 0.0,
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      withdrawnAmount: (json['withdrawnAmount'] as num?)?.toDouble() ?? 0.0,
      totalBookings: (json['totalBookings'] as num?)?.toInt() ?? 0,
      completedBookings: (json['completedBookings'] as num?)?.toInt() ?? 0,
      cancelledBookings: (json['cancelledBookings'] as num?)?.toInt() ?? 0,
      pendingBookings: (json['pendingBookings'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: (json['totalReviews'] as num?)?.toInt() ?? 0,
      createdAt: safeString(json['createdAt']),
      policeVerificationImage: safeString(json['policeVerificationImage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'city': city,
      'state': state,
      'locality': locality,
      'address': address,
      'image': image,
      'aadhaarFrontImage': aadhaarFrontImage,
      'aadhaarBackImage': aadhaarBackImage,
      'policeVerificationImage': policeVerificationImage,
      'panCardImage': panCardImage,
      'status': status,
      'isApproved': isApproved,
      'gender': gender,
      'experience': experience,
      'services': services,
      'aadhaarNumber': aadhaarNumber,
      'panNumber': panNumber,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
      'documents': documents,
      'walletBalance': walletBalance,
      'totalEarnings': totalEarnings,
      'withdrawnAmount': withdrawnAmount,
      'totalBookings': totalBookings,
      'completedBookings': completedBookings,
      'cancelledBookings': cancelledBookings,
      'pendingBookings': pendingBookings,
      'rating': rating,
      'totalReviews': totalReviews,
      'createdAt': createdAt,
    };
  }

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
    String? aadhaarFrontImage,
    String? aadhaarBackImage,
    String? panCardImage,
    String? policeVerificationImage,
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
      aadhaarFrontImage: aadhaarFrontImage ?? this.aadhaarFrontImage,
      aadhaarBackImage: aadhaarBackImage ?? this.aadhaarBackImage,
      panCardImage: panCardImage ?? this.panCardImage,
      policeVerificationImage: policeVerificationImage ?? this.policeVerificationImage,
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
    );
  }
}