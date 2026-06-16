import 'package:admin_panel/service_Api/Activepartners/active_partner_auth.dart';
import 'package:admin_panel/service_Api/Earnings/Bookings/booking_auth.dart';
import 'package:admin_panel/service_Api/Earnings/Subscriptions/subscription_auth.dart';
import 'package:admin_panel/service_Api/Order/order_auth.dart';
import 'package:admin_panel/service_Api/pages/page_auth.dart';
import 'package:admin_panel/service_Api/partner/partner_auth.dart';
import 'package:admin_panel/service_Api/services/services_auth.dart';
import 'package:admin_panel/service_Api/settings/banner_auth.dart';
import 'package:admin_panel/service_Api/settings/city_auth.dart';
import 'package:admin_panel/service_Api/settings/state_auth.dart';
import 'package:admin_panel/service_Api/users/user_auth.dart';
import 'package:admin_panel/viewmodels/Settings_ViewModels/notification_viewmodel.dart';
import 'package:admin_panel/viewmodels/Settings_ViewModels/review_viewmodel.dart';
import 'package:admin_panel/viewmodels/auth/login_viewmodel.dart';
import 'package:admin_panel/viewmodels/reports_viewmodels/reports_viewmodel.dart';
import 'package:admin_panel/views/auth%20screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/app_scroll_behavior.dart';
import 'viewmodels/navigation_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        /// navigation provider
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),

        /// partner provider
        ChangeNotifierProvider(create: (_) => PartnerAuth()),

        ChangeNotifierProvider(create: (_) => BookingAuth()),
        ChangeNotifierProvider(create: (_) => SubscriptionAuth()),

        ChangeNotifierProvider(create: (_) => UserViewmodel()),

        ChangeNotifierProvider(create: (_) => ServiceAuth()..fetchServices()),

        ChangeNotifierProvider(create: (_) => OrderAuth()..fetchOrders()),

        ChangeNotifierProvider(create: (_) => PageAuth()),

        ChangeNotifierProvider(create: (_) => BannerAuth()),

        ChangeNotifierProvider(create: (_) => StateAuth()..fetchStates()),

        ChangeNotifierProvider(create: (_) => CityAuth()..fetchCities()),

        ChangeNotifierProvider(create: (_) => ReviewViewModel()),

        ChangeNotifierProvider(create: (_) => NotificationViewModel()),

        ChangeNotifierProvider(create: (_) => ReportsViewModel()),

        ChangeNotifierProvider(create: (_) => LoginViewModel()),

        ChangeNotifierProvider(create: (_) => ActivePartnerAuth()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Admin Panel",
      scrollBehavior: AppScrollBehavior(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: const LoginScreen(),
    );
  }
}
