// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:admin_panel/data/models/Settings models/city_model.dart';
// import 'package:admin_panel/data/models/Settings models/notification_model.dart';
// import 'package:admin_panel/data/models/Settings models/review_model.dart';
// import 'package:admin_panel/data/models/Settings models/state_model.dart';

// class ApiService {
//   // Base URL for the local Express API Server (change if hosted remotely)
//   static const String baseUrl = 'http://localhost:3000/api';
//   // Helper headers
//   static Map<String, String> get _headers => {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//   };
//   // ==========================================
//   // 1. DASHBOARD API
//   // ==========================================
//   Future<Map<String, dynamic>?> getDashboardStats() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/dashboard'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           final Map<String, dynamic> resultMap = {};
//
//           for (var item in list) {
//             final name = item['name'] as String?;
//             final totalAmount = item['totalAmount'];
//
//             if (name == 'Total Users') {
//               resultMap['totalUsers'] = totalAmount is num ? totalAmount.toInt() : 0;
//             } else if (name == 'Total Categories') {
//               resultMap['totalCategories'] = totalAmount is num ? totalAmount.toInt() : 0;
//             } else if (name == 'Total Services') {
//               resultMap['totalServices'] = totalAmount is num ? totalAmount.toInt() : 0;
//             } else if (name == 'Total Partners') {
//               resultMap['totalPartners'] = totalAmount is num ? totalAmount.toInt() : 0;
//             } else if (name == 'Total Orders') {
//               resultMap['totalOrders'] = totalAmount is num ? totalAmount.toInt() : 0;
//             } else if (name == 'Today Orders') {
//               resultMap['todayOrders'] = totalAmount is num ? totalAmount.toInt() : 0;
//             } else if (name == 'Complete Orders') {
//               resultMap['completeOrders'] = totalAmount is num ? totalAmount.toInt() : 0;
//             } else if (name == 'Assigned Orders') {
//               resultMap['assignedOrders'] = totalAmount is num ? totalAmount.toInt() : 0;
//             } else if (name == 'Cancel Orders') {
//               resultMap['cancelOrders'] = totalAmount is num ? totalAmount.toInt() : 0;
//             } else if (name == 'Total Supporters') {
//               resultMap['totalSupporters'] = totalAmount is num ? totalAmount.toInt() : 0;
//             } else if (name == 'Subscription Earnings') {
//               resultMap['subscriptionEarning'] = '₹${totalAmount ?? 0}';
//             } else if (name == 'Order Earnings') {
//               resultMap['orderEarning'] = '₹${totalAmount ?? 0}';
//             }
//           }
//           return resultMap;
//         }
//       }
//     } catch (e) {
//       print('ApiService - getDashboardStats Error: $e');
//     }
//     return null;
//   }
//   // ==========================================
//   // 2. USERS API
//   // ==========================================
//   Future<List<UserModel>> getUsers() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/users'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => UserModel(
//             id: item['id'],
//             name: item['name'] ?? '',
//             email: item['email'] ?? '',
//             mobile: item['mobile'] ?? '',
//             address: item['address'] ?? '',
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getUsers Error: $e');
//     }
//     return [];
//   }
//   Future<UserModel?> addUser(String name, String email, String mobile, String address) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/users'),
//         headers: _headers,
//         body: jsonEncode({
//           'name': name,
//           'email': email,
//           'mobile': mobile,
//           'address': address,
//         }),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return UserModel(
//             id: data['id'],
//             name: data['name'],
//             email: data['email'],
//             mobile: data['mobile'],
//             address: data['address'],
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - addUser Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deleteUser(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/users/$id'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         return json['success'] == true;
//       }
//     } catch (e) {
//       print('ApiService - deleteUser Error: $e');
//     }
//     return false;
//   }
//   // ==========================================
//   // 3. CATEGORIES API
//   // ==========================================
//   Future<List<CategoryModel>> getCategories() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/categories'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => CategoryModel(
//             id: item['id'],
//             title: item['title'] ?? '',
//             parent: item['parent'] ?? '',
//             image: item['image'] ?? '',
//             status: item['status'] == true,
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getCategories Error: $e');
//     }
//     return [];
//   }
//   Future<CategoryModel?> addCategory(String title, String parent, String image, bool status) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/categories'),
//         headers: _headers,
//         body: jsonEncode({
//           'title': title,
//           'parent': parent,
//           'image': image,
//           'status': status,
//         }),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return CategoryModel(
//             id: data['id'],
//             title: data['title'],
//             parent: data['parent'],
//             image: data['image'],
//             status: data['status'] == true,
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - addCategory Error: $e');
//     }
//     return null;
//   }
//   Future<CategoryModel?> updateCategory(int id, {String? title, String? parent, String? image, bool? status}) async {
//     try {
//       final body = <String, dynamic>{};
//       if (title != null) body['title'] = title;
//       if (parent != null) body['parent'] = parent;
//       if (image != null) body['image'] = image;
//       if (status != null) body['status'] = status;
//       final response = await http.put(
//         Uri.parse('$baseUrl/categories/$id'),
//         headers: _headers,
//         body: jsonEncode(body),
//       );
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return CategoryModel(
//             id: data['id'],
//             title: data['title'],
//             parent: data['parent'],
//             image: data['image'],
//             status: data['status'] == true,
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - updateCategory Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deleteCategory(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/categories/$id'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         return json['success'] == true;
//       }
//     } catch (e) {
//       print('ApiService - deleteCategory Error: $e');
//     }
//     return false;
//   }
//   // ==========================================
//   // 4. SERVICES API
//   // ==========================================
//   Future<List<ServiceModel>> getServices() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/services'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => ServiceModel(
//             id: item['id'],
//             title: item['title'] ?? '',
//             price: (item['price'] as num).toDouble(),
//             image: item['image'] ?? '',
//             description: item['description'] ?? '',
//             status: item['status'] == true,
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getServices Error: $e');
//     }
//     return [];
//   }
//   Future<ServiceModel?> addService(String title, double price, String image, String description, bool status) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/services'),
//         headers: _headers,
//         body: jsonEncode({
//           'title': title,
//           'price': price,
//           'image': image,
//           'description': description,
//           'status': status,
//         }),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return ServiceModel(
//             id: data['id'],
//             title: data['title'],
//             price: (data['price'] as num).toDouble(),
//             image: data['image'],
//             description: data['description'],
//             status: data['status'] == true,
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - addService Error: $e');
//     }
//     return null;
//   }
//   Future<ServiceModel?> updateService(int id, {String? title, double? price, String? image, String? description, bool? status}) async {
//     try {
//       final body = <String, dynamic>{};
//       if (title != null) body['title'] = title;
//       if (price != null) body['price'] = price;
//       if (image != null) body['image'] = image;
//       if (description != null) body['description'] = description;
//       if (status != null) body['status'] = status;
//       final response = await http.put(
//         Uri.parse('$baseUrl/services/$id'),
//         headers: _headers,
//         body: jsonEncode(body),
//       );
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return ServiceModel(
//             id: data['id'],
//             title: data['title'],
//             price: (data['price'] as num).toDouble(),
//             image: data['image'],
//             description: data['description'],
//             status: data['status'] == true,
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - updateService Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deleteService(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/services/$id'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         return json['success'] == true;
//       }
//     } catch (e) {
//       print('ApiService - deleteService Error: $e');
//     }
//     return false;
//   }
//   // ==========================================
//   // 5. ORDERS API
//   // ==========================================
//   Future<List<OrderModel>> getOrders() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/orders'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => OrderModel(
//             id: item['id'],
//             serviceRequestNumber: item['serviceRequestNumber'] ?? '',
//             serviceName: item['serviceName'] ?? '',
//             serviceAmount: (item['serviceAmount'] as num).toDouble(),
//             slotTime: item['slotTime'] ?? '',
//             serviceDate: item['serviceDate'] ?? '',
//             city: item['city'] ?? '',
//             locality: item['locality'] ?? '',
//             status: item['status'] ?? '',
//             vendorName: item['vendorName'] ?? '',
//             address: item['address'] ?? '',
//             createdAt: item['createdAt'] ?? '',
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getOrders Error: $e');
//     }
//     return [];
//   }
//   Future<OrderModel?> addOrder(OrderModel order) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/orders'),
//         headers: _headers,
//         body: jsonEncode({
//           'serviceRequestNumber': order.serviceRequestNumber,
//           'serviceName': order.serviceName,
//           'serviceAmount': order.serviceAmount,
//           'slotTime': order.slotTime,
//           'serviceDate': order.serviceDate,
//           'city': order.city,
//           'locality': order.locality,
//           'status': order.status,
//           'vendorName': order.vendorName,
//           'address': order.address,
//           'createdAt': order.createdAt,
//         }),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return OrderModel(
//             id: data['id'],
//             serviceRequestNumber: data['serviceRequestNumber'],
//             serviceName: data['serviceName'],
//             serviceAmount: (data['serviceAmount'] as num).toDouble(),
//             slotTime: data['slotTime'],
//             serviceDate: data['serviceDate'],
//             city: data['city'],
//             locality: data['locality'],
//             status: data['status'],
//             vendorName: data['vendorName'],
//             address: data['address'],
//             createdAt: data['createdAt'],
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - addOrder Error: $e');
//     }
//     return null;
//   }
//   Future<OrderModel?> updateOrder(int id, {String? status, String? vendorName, String? slotTime, String? serviceDate, String? city, String? locality, String? address}) async {
//     try {
//       final body = <String, dynamic>{};
//       if (status != null) body['status'] = status;
//       if (vendorName != null) body['vendorName'] = vendorName;
//       if (slotTime != null) body['slotTime'] = slotTime;
//       if (serviceDate != null) body['serviceDate'] = serviceDate;
//       if (city != null) body['city'] = city;
//       if (locality != null) body['locality'] = locality;
//       if (address != null) body['address'] = address;
//       final response = await http.put(
//         Uri.parse('$baseUrl/orders/$id'),
//         headers: _headers,
//         body: jsonEncode(body),
//       );
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return OrderModel(
//             id: data['id'],
//             serviceRequestNumber: data['serviceRequestNumber'],
//             serviceName: data['serviceName'],
//             serviceAmount: (data['serviceAmount'] as num).toDouble(),
//             slotTime: data['slotTime'],
//             serviceDate: data['serviceDate'],
//             city: data['city'],
//             locality: data['locality'],
//             status: data['status'],
//             vendorName: data['vendorName'],
//             address: data['address'],
//             createdAt: data['createdAt'],
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - updateOrder Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deleteOrder(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/orders/$id'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         return json['success'] == true;
//       }
//     } catch (e) {
//       print('ApiService - deleteOrder Error: $e');
//     }
//     return false;
//   }
//   // ==========================================
//   // 6. PARTNERS API
//   // ==========================================
//   Future<List<PartnerModel>> getPartners() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/partners'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => PartnerModel(
//             id: item['id'],
//             name: item['name'] ?? '',
//             email: item['email'] ?? '',
//             mobile: item['mobile'] ?? '',
//             city: item['city'] ?? '',
//             state: item['state'] ?? '',
//             locality: item['locality'] ?? '',
//             address: item['address'] ?? '',
//             image: item['image'] ?? '',
//             status: item['status'] == true,
//             isApproved: item['isApproved'] == true,
//             gender: item['gender'] ?? '',
//             experience: item['experience'] ?? '',
//             services: List<String>.from(item['services'] ?? []),
//             aadhaarNumber: item['aadhaarNumber'] ?? '',
//             panNumber: item['panNumber'] ?? '',
//             bankName: item['bankName'] ?? '',
//             accountNumber: item['accountNumber'] ?? '',
//             ifscCode: item['ifscCode'] ?? '',
//             documents: List<String>.from(item['documents'] ?? []),
//             walletBalance: (item['walletBalance'] as num).toDouble(),
//             totalEarnings: (item['totalEarnings'] as num).toDouble(),
//             withdrawnAmount: (item['withdrawnAmount'] as num).toDouble(),
//             totalBookings: item['totalBookings'] ?? 0,
//             completedBookings: item['completedBookings'] ?? 0,
//             cancelledBookings: item['cancelledBookings'] ?? 0,
//             pendingBookings: item['pendingBookings'] ?? 0,
//             rating: (item['rating'] as num).toDouble(),
//             totalReviews: item['totalReviews'] ?? 0,
//             createdAt: item['createdAt'] ?? '',
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getPartners Error: $e');
//     }
//     return [];
//   }
//   Future<PartnerModel?> addPartner(PartnerModel partner) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/partners'),
//         headers: _headers,
//         body: jsonEncode({
//           'name': partner.name,
//           'email': partner.email,
//           'mobile': partner.mobile,
//           'city': partner.city,
//           'state': partner.state,
//           'locality': partner.locality,
//           'address': partner.address,
//           'image': partner.image,
//           'gender': partner.gender,
//           'experience': partner.experience,
//           'services': partner.services,
//           'aadhaarNumber': partner.aadhaarNumber,
//           'panNumber': partner.panNumber,
//           'bankName': partner.bankName,
//           'accountNumber': partner.accountNumber,
//           'ifscCode': partner.ifscCode,
//           'documents': partner.documents,
//         }),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           // Convert lists and numerical values appropriately
//           return PartnerModel(
//             id: data['id'],
//             name: data['name'],
//             email: data['email'],
//             mobile: data['mobile'],
//             city: data['city'],
//             state: data['state'],
//             locality: data['locality'],
//             address: data['address'],
//             image: data['image'],
//             status: data['status'] == true,
//             isApproved: data['isApproved'] == true,
//             gender: data['gender'],
//             experience: data['experience'],
//             services: List<String>.from(data['services'] ?? []),
//             aadhaarNumber: data['aadhaarNumber'],
//             panNumber: data['panNumber'],
//             bankName: data['bankName'],
//             accountNumber: data['accountNumber'],
//             ifscCode: data['ifscCode'],
//             documents: List<String>.from(data['documents'] ?? []),
//             walletBalance: (data['walletBalance'] as num).toDouble(),
//             totalEarnings: (data['totalEarnings'] as num).toDouble(),
//             withdrawnAmount: (data['withdrawnAmount'] as num).toDouble(),
//             totalBookings: data['totalBookings'],
//             completedBookings: data['completedBookings'],
//             cancelledBookings: data['cancelledBookings'],
//             pendingBookings: data['pendingBookings'],
//             rating: (data['rating'] as num).toDouble(),
//             totalReviews: data['totalReviews'],
//             createdAt: data['createdAt'],
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - addPartner Error: $e');
//     }
//     return null;
//   }
//   Future<PartnerModel?> updatePartner(int id, Map<String, dynamic> updateFields) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/partners/$id'),
//         headers: _headers,
//         body: jsonEncode(updateFields),
//       );
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return PartnerModel(
//             id: data['id'],
//             name: data['name'],
//             email: data['email'],
//             mobile: data['mobile'],
//             city: data['city'],
//             state: data['state'],
//             locality: data['locality'],
//             address: data['address'],
//             image: data['image'],
//             status: data['status'] == true,
//             isApproved: data['isApproved'] == true,
//             gender: data['gender'],
//             experience: data['experience'],
//             services: List<String>.from(data['services'] ?? []),
//             aadhaarNumber: data['aadhaarNumber'],
//             panNumber: data['panNumber'],
//             bankName: data['bankName'],
//             accountNumber: data['accountNumber'],
//             ifscCode: data['ifscCode'],
//             documents: List<String>.from(data['documents'] ?? []),
//             walletBalance: (data['walletBalance'] as num).toDouble(),
//             totalEarnings: (data['totalEarnings'] as num).toDouble(),
//             withdrawnAmount: (data['withdrawnAmount'] as num).toDouble(),
//             totalBookings: data['totalBookings'],
//             completedBookings: data['completedBookings'],
//             cancelledBookings: data['cancelledBookings'],
//             pendingBookings: data['pendingBookings'],
//             rating: (data['rating'] as num).toDouble(),
//             totalReviews: data['totalReviews'],
//             createdAt: data['createdAt'],
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - updatePartner Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deletePartner(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/partners/$id'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         return json['success'] == true;
//       }
//     } catch (e) {
//       print('ApiService - deletePartner Error: $e');
//     }
//     return false;
//   }
//   // ==========================================
//   // 7. EARNINGS API
//   // ==========================================
//   Future<List<BookingEarningModel>> getBookingEarnings() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/earnings/bookings'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => BookingEarningModel(
//             id: item['id'],
//             transactionId: item['transactionId'] ?? '',
//             serviceAmount: (item['serviceAmount'] as num).toDouble(),
//             paymentMethod: item['paymentMethod'] ?? '',
//             extraServiceAmount: (item['extraServiceAmount'] as num).toDouble(),
//             extraServicePaymentMethod: item['extraServicePaymentMethod'] ?? '',
//             totalAmount: (item['totalAmount'] as num).toDouble(),
//             orderDate: item['orderDate'] ?? '',
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getBookingEarnings Error: $e');
//     }
//     return [];
//   }
//   Future<BookingEarningModel?> addBookingEarning(BookingEarningModel earning) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/earnings/bookings'),
//         headers: _headers,
//         body: jsonEncode({
//           'transactionId': earning.transactionId,
//           'serviceAmount': earning.serviceAmount,
//           'paymentMethod': earning.paymentMethod,
//           'extraServiceAmount': earning.extraServiceAmount,
//           'extraServicePaymentMethod': earning.extraServicePaymentMethod,
//           'totalAmount': earning.totalAmount,
//           'orderDate': earning.orderDate,
//         }),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return BookingEarningModel(
//             id: data['id'],
//             transactionId: data['transactionId'],
//             serviceAmount: (data['serviceAmount'] as num).toDouble(),
//             paymentMethod: data['paymentMethod'],
//             extraServiceAmount: (data['extraServiceAmount'] as num).toDouble(),
//             extraServicePaymentMethod: data['extraServicePaymentMethod'],
//             totalAmount: (data['totalAmount'] as num).toDouble(),
//             orderDate: data['orderDate'],
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - addBookingEarning Error: $e');
//     }
//     return null;
//   }
//   Future<List<SubscriptionEarningModel>> getSubscriptionEarnings() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/earnings/subscriptions'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => SubscriptionEarningModel(
//             id: item['id'],
//             partnerName: item['partnerName'] ?? '',
//             amount: (item['amount'] as num).toDouble(),
//             paymentMethod: item['paymentMethod'] ?? '',
//             purchaseDate: item['purchaseDate'] ?? '',
//             status: item['status'] ?? '',
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getSubscriptionEarnings Error: $e');
//     }
//     return [];
//   }
//   Future<SubscriptionEarningModel?> addSubscriptionEarning(SubscriptionEarningModel earning) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/earnings/subscriptions'),
//         headers: _headers,
//         body: jsonEncode({
//           'partnerName': earning.partnerName,
//           'amount': earning.amount,
//           'paymentMethod': earning.paymentMethod,
//           'purchaseDate': earning.purchaseDate,
//           'status': earning.status,
//         }),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return SubscriptionEarningModel(
//             id: data['id'],
//             partnerName: data['partnerName'],
//             amount: (data['amount'] as num).toDouble(),
//             paymentMethod: data['paymentMethod'],
//             purchaseDate: data['purchaseDate'],
//             status: data['status'],
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - addSubscriptionEarning Error: $e');
//     }
//     return null;
//   }
//   // ==========================================
//   // 8. PAGES API
//   // ==========================================
//   Future<List<PageModel>> getPages() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/pages'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => PageModel(
//             id: item['id'],
//             title: item['title'] ?? '',
//             description: item['description'] ?? '',
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getPages Error: $e');
//     }
//     return [];
//   }
//   Future<PageModel?> updatePage(int id, String title, String description) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/pages/$id'),
//         headers: _headers,
//         body: jsonEncode({
//           'title': title,
//           'description': description,
//         }),
//       );
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return PageModel(
//             id: data['id'],
//             title: data['title'],
//             description: data['description'],
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - updatePage Error: $e');
//     }
//     return null;
//   }
//   // ==========================================
//   // 9. CONFIGURATION & SETTINGS APIs
//   // ==========================================
//   // --- BANNERS ---
//   Future<List<BannerModel>> getBanners() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/settings/banners'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => BannerModel(
//             id: item['id'],
//             title: item['title'] ?? '',
//             image: item['image'] ?? '',
//             status: item['status'] == true,
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getBanners Error: $e');
//     }
//     return [];
//   }
//   Future<BannerModel?> addBanner(String title, String image, bool status) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/settings/banners'),
//         headers: _headers,
//         body: jsonEncode({'title': title, 'image': image, 'status': status}),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return BannerModel(id: data['id'], title: data['title'], image: data['image'], status: data['status'] == true);
//         }
//       }
//     } catch (e) {
//       print('ApiService - addBanner Error: $e');
//     }
//     return null;
//   }
//   Future<BannerModel?> updateBanner(int id, {String? title, String? image, bool? status}) async {
//     try {
//       final body = <String, dynamic>{};
//       if (title != null) body['title'] = title;
//       if (image != null) body['image'] = image;
//       if (status != null) body['status'] = status;
//       final response = await http.put(Uri.parse('$baseUrl/settings/banners/$id'), headers: _headers, body: jsonEncode(body));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return BannerModel(id: data['id'], title: data['title'], image: data['image'], status: data['status'] == true);
//         }
//       }
//     } catch (e) {
//       print('ApiService - updateBanner Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deleteBanner(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/settings/banners/$id'), headers: _headers);
//       return jsonDecode(response.body)['success'] == true;
//     } catch (e) {
//       print('ApiService - deleteBanner Error: $e');
//     }
//     return false;
//   }
//   // --- STATES ---
//   Future<List<StateModel>> getStates() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/settings/states'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => StateModel(
//             id: item['id'],
//             name: item['name'] ?? '',
//             status: item['status'] == true,
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getStates Error: $e');
//     }
//     return [];
//   }
//   Future<StateModel?> addState(String name, bool status) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/settings/states'),
//         headers: _headers,
//         body: jsonEncode({'name': name, 'status': status}),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return StateModel(id: data['id'], name: data['name'], status: data['status'] == true);
//         }
//       }
//     } catch (e) {
//       print('ApiService - addState Error: $e');
//     }
//     return null;
//   }
//   Future<StateModel?> updateState(int id, {String? name, bool? status}) async {
//     try {
//       final body = <String, dynamic>{};
//       if (name != null) body['name'] = name;
//       if (status != null) body['status'] = status;
//       final response = await http.put(Uri.parse('$baseUrl/settings/states/$id'), headers: _headers, body: jsonEncode(body));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return StateModel(id: data['id'], name: data['name'], status: data['status'] == true);
//         }
//       }
//     } catch (e) {
//       print('ApiService - updateState Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deleteState(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/settings/states/$id'), headers: _headers);
//       return jsonDecode(response.body)['success'] == true;
//     } catch (e) {
//       print('ApiService - deleteState Error: $e');
//     }
//     return false;
//   }
//   // --- CITIES ---
//   Future<List<CityModel>> getCities() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/settings/cities'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => CityModel(
//             id: item['id'],
//             cityName: item['cityName'] ?? '',
//             stateName: item['stateName'] ?? '',
//             status: item['status'] == true,
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getCities Error: $e');
//     }
//     return [];
//   }
//   Future<CityModel?> addCity(String cityName, String stateName, bool status) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/settings/cities'),
//         headers: _headers,
//         body: jsonEncode({'cityName': cityName, 'stateName': stateName, 'status': status}),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return CityModel(id: data['id'], cityName: data['cityName'], stateName: data['stateName'], status: data['status'] == true);
//         }
//       }
//     } catch (e) {
//       print('ApiService - addCity Error: $e');
//     }
//     return null;
//   }
//   Future<CityModel?> updateCity(int id, {String? cityName, String? stateName, bool? status}) async {
//     try {
//       final body = <String, dynamic>{};
//       if (cityName != null) body['cityName'] = cityName;
//       if (stateName != null) body['stateName'] = stateName;
//       if (status != null) body['status'] = status;
//       final response = await http.put(Uri.parse('$baseUrl/settings/cities/$id'), headers: _headers, body: jsonEncode(body));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return CityModel(id: data['id'], cityName: data['cityName'], stateName: data['stateName'], status: data['status'] == true);
//         }
//       }
//     } catch (e) {
//       print('ApiService - updateCity Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deleteCity(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/settings/cities/$id'), headers: _headers);
//       return jsonDecode(response.body)['success'] == true;
//     } catch (e) {
//       print('ApiService - deleteCity Error: $e');
//     }
//     return false;
//   }
//   // --- LOCALITIES ---
//   Future<List<LocalityModel>> getLocalities() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/settings/localities'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => LocalityModel(
//             id: item['id'],
//             localityName: item['localityName'] ?? '',
//             cityName: item['cityName'] ?? '',
//             stateName: item['stateName'] ?? '',
//             status: item['status'] == true,
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getLocalities Error: $e');
//     }
//     return [];
//   }
//   Future<LocalityModel?> addLocality(String localityName, String cityName, String stateName, bool status) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/settings/localities'),
//         headers: _headers,
//         body: jsonEncode({'localityName': localityName, 'cityName': cityName, 'stateName': stateName, 'status': status}),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return LocalityModel(
//               id: data['id'], localityName: data['localityName'], cityName: data['cityName'], stateName: data['stateName'], status: data['status'] == true);
//         }
//       }
//     } catch (e) {
//       print('ApiService - addLocality Error: $e');
//     }
//     return null;
//   }
//   Future<LocalityModel?> updateLocality(int id, {String? localityName, String? cityName, String? stateName, bool? status}) async {
//     try {
//       final body = <String, dynamic>{};
//       if (localityName != null) body['localityName'] = localityName;
//       if (cityName != null) body['cityName'] = cityName;
//       if (stateName != null) body['stateName'] = stateName;
//       if (status != null) body['status'] = status;
//       final response = await http.put(Uri.parse('$baseUrl/settings/localities/$id'), headers: _headers, body: jsonEncode(body));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return LocalityModel(
//               id: data['id'], localityName: data['localityName'], cityName: data['cityName'], stateName: data['stateName'], status: data['status'] == true);
//         }
//       }
//     } catch (e) {
//       print('ApiService - updateLocality Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deleteLocality(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/settings/localities/$id'), headers: _headers);
//       return jsonDecode(response.body)['success'] == true;
//     } catch (e) {
//       print('ApiService - deleteLocality Error: $e');
//     }
//     return false;
//   }
//   // --- REVIEWS ---
//   Future<List<ReviewModel>> getReviews() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/settings/reviews'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => ReviewModel(
//             id: item['id'],
//             userName: item['userName'] ?? '',
//             partnerName: item['partnerName'] ?? '',
//             serviceName: item['serviceName'] ?? '',
//             rating: (item['rating'] as num).toDouble(),
//             reviewText: item['reviewText'] ?? '',
//             status: item['status'] == true,
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getReviews Error: $e');
//     }
//     return [];
//   }
//   Future<ReviewModel?> addReview(ReviewModel review) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/settings/reviews'),
//         headers: _headers,
//         body: jsonEncode({
//           'userName': review.userName,
//           'partnerName': review.partnerName,
//           'serviceName': review.serviceName,
//           'rating': review.rating,
//           'reviewText': review.reviewText,
//           'status': review.status,
//         }),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return ReviewModel(
//             id: data['id'],
//             userName: data['userName'],
//             partnerName: data['partnerName'],
//             serviceName: data['serviceName'],
//             rating: (data['rating'] as num).toDouble(),
//             reviewText: data['reviewText'],
//             status: data['status'] == true,
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - addReview Error: $e');
//     }
//     return null;
//   }
//   Future<ReviewModel?> updateReviewStatus(int id, bool status) async {
//     try {
//       final response = await http.put(
//         Uri.parse('$baseUrl/settings/reviews/$id'),
//         headers: _headers,
//         body: jsonEncode({'status': status}),
//       );
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return ReviewModel(
//             id: data['id'],
//             userName: data['userName'],
//             partnerName: data['partnerName'],
//             serviceName: data['serviceName'],
//             rating: (data['rating'] as num).toDouble(),
//             reviewText: data['reviewText'],
//             status: data['status'] == true,
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - updateReviewStatus Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deleteReview(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/settings/reviews/$id'), headers: _headers);
//       return jsonDecode(response.body)['success'] == true;
//     } catch (e) {
//       print('ApiService - deleteReview Error: $e');
//     }
//     return false;
//   }
//   // --- NOTIFICATIONS ---
//   Future<List<NotificationModel>> getNotifications() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/settings/notifications'), headers: _headers);
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final list = json['data'] as List;
//           return list.map((item) => NotificationModel(
//             id: item['id'],
//             title: item['title'] ?? '',
//             message: item['message'] ?? '',
//             audience: item['audience'] ?? '',
//             createdAt: item['createdAt'] ?? '',
//             status: item['status'] == true,
//             isSent: item['isSent'] == true,
//             sentAt: item['sentAt'] ?? '',
//           )).toList();
//         }
//       }
//     } catch (e) {
//       print('ApiService - getNotifications Error: $e');
//     }
//     return [];
//   }
//   Future<NotificationModel?> addNotification(String title, String message, String audience, bool status) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$baseUrl/settings/notifications'),
//         headers: _headers,
//         body: jsonEncode({'title': title, 'message': message, 'audience': audience, 'status': status}),
//       );
//       if (response.statusCode == 201) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return NotificationModel(
//             id: data['id'],
//             title: data['title'],
//             message: data['message'],
//             audience: data['audience'],
//             createdAt: data['createdAt'],
//             status: data['status'] == true,
//             isSent: data['isSent'] == true,
//             sentAt: data['sentAt'] ?? '',
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - addNotification Error: $e');
//     }
//     return null;
//   }
//   Future<NotificationModel?> updateNotification(int id, {bool? status, bool? isSent}) async {
//     try {
//       final body = <String, dynamic>{};
//       if (status != null) body['status'] = status;
//       if (isSent != null) body['isSent'] = isSent;
//       final response = await http.put(Uri.parse('$baseUrl/settings/notifications/$id'), headers: _headers, body: jsonEncode(body));
//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['success'] == true) {
//           final data = json['data'];
//           return NotificationModel(
//             id: data['id'],
//             title: data['title'],
//             message: data['message'],
//             audience: data['audience'],
//             createdAt: data['createdAt'],
//             status: data['status'] == true,
//             isSent: data['isSent'] == true,
//             sentAt: data['sentAt'] ?? '',
//           );
//         }
//       }
//     } catch (e) {
//       print('ApiService - updateNotification Error: $e');
//     }
//     return null;
//   }
//   Future<bool> deleteNotification(int id) async {
//     try {
//       final response = await http.delete(Uri.parse('$baseUrl/settings/notifications/$id'), headers: _headers);
//       return jsonDecode(response.body)['success'] == true;
//     } catch (e) {
//       print('ApiService - deleteNotification Error: $e');
//     }
//     return false;
//   }
// }