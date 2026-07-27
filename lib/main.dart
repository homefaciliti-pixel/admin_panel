import 'package:admin_panel/Amc/AMC_ViewModel/dashboard_viewmodel/admin_amc_dashboard_viewmodel.dart';
import 'package:admin_panel/Amc/AMC_ViewModel/expired/expired_amc_viewmodel.dart';
import 'package:admin_panel/Amc/AMC_ViewModel/expired/renew_amc_viewmodel.dart';
import 'package:admin_panel/Amc/AMC_ViewModel/orders/amc_view_model.dart';
import 'package:admin_panel/service_Api/Activepartners/active_partner_auth.dart';
import 'package:admin_panel/service_Api/Dashboard/dashboard_auth.dart';
import 'package:admin_panel/service_Api/Earnings/Bookings/booking_auth.dart';
import 'package:admin_panel/service_Api/Earnings/Subscriptions/subscription_auth.dart';
import 'package:admin_panel/service_Api/Order/order_auth.dart';
import 'package:admin_panel/service_Api/country%20provider/country_provider.dart';
import 'package:admin_panel/service_Api/pages/page_auth.dart';
import 'package:admin_panel/service_Api/partner/partner_auth.dart';
import 'package:admin_panel/service_Api/services/services_auth.dart';
import 'package:admin_panel/service_Api/settings/banner_auth.dart';
import 'package:admin_panel/service_Api/settings/city_auth.dart';
import 'package:admin_panel/service_Api/settings/state_auth.dart';
import 'package:admin_panel/service_Api/support_auth.dart';
import 'package:admin_panel/service_Api/users/user_auth.dart';
import 'package:admin_panel/service_Api/categories/categories_auth.dart';
import 'package:admin_panel/service_Api/settings/notification_viewmodel.dart';
import 'package:admin_panel/service_Api/settings/review_viewmodel.dart';
import 'package:admin_panel/viewmodels/auth/login_viewmodel.dart';
import 'package:admin_panel/viewmodels/profile/manage%20Admins/admin_viewmodel.dart';
import 'package:admin_panel/viewmodels/profile/permission_viewmodel.dart';
import 'package:admin_panel/viewmodels/profile/profile_viewmodel.dart';
import 'package:admin_panel/viewmodels/reports_viewmodels/reports_viewmodel.dart';
import 'package:admin_panel/views/auth%20screen/login_screen.dart';
import 'package:admin_panel/views/mainScreen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Amc/AMC_ViewModel/assign partner viewmodel/assign_partner_viewmodel.dart';
import 'Amc/AMC_ViewModel/dashboard_viewmodel/active_amc_viewmodel.dart';
import 'Amc/AMC_ViewModel/book_service/book_service_viewmodel.dart';
import 'Amc/AMC_ViewModel/dashboard_viewmodel/recent_order_viewmodel.dart';
import 'Amc/AMC_ViewModel/dashboard_viewmodel/today_visit_viewmodel.dart';
import 'Amc/AMC_ViewModel/partner Payment/partner_payment_viewmodel.dart';
import 'Amc/AMC_ViewModel/reports/report_viewmodel.dart';
import 'Amc/AMC_ViewModel/service_history/service_history_viewmodel.dart';
import 'core/App_permission/app_permission.dart';
import 'utils/app_scroll_behavior.dart';
import 'service_Api/settings/navigation_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

  final role = prefs.getString("role") ?? "";

  AppPermission.role = role;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DashboardViewModel()..fetchDashboard(),
        ),

        /// navigation provider
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),

        /// partner provider
        ChangeNotifierProvider(create: (_) => PartnerAuth()),

        ChangeNotifierProvider(create: (_) => BookingAuth()),

        ChangeNotifierProvider(create: (_) => SubscriptionAuth()),

        ChangeNotifierProvider(create: (_) => UserViewmodel()),

        ChangeNotifierProvider(create: (_) => ServiceAuth()..fetchServices()),

        ChangeNotifierProvider(
          create: (_) => AuthCategories()..fetchCategories(),
        ),

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

        ChangeNotifierProvider(create: (_) => ProfileViewModel()),

        ChangeNotifierProvider(create: (_) => AdminViewModel()),

        ChangeNotifierProvider(create: (_) => SupportAuth()),

        ChangeNotifierProvider(create: (_) => PermissionViewModel()),

        ChangeNotifierProvider(
          create: (_) => CountryProvider()..getCountries(),
        ),
        ChangeNotifierProvider(
          create: (_) => ActiveAmcViewModel()..fetchActiveAmc(),
        ),
        ChangeNotifierProvider(create: (_) => DashboardAmcViewModel()),

        ChangeNotifierProvider(create: (_) => BookServiceViewModel()),

        ChangeNotifierProvider(create: (_) => ServiceHistoryViewModel()),

        ChangeNotifierProvider(create: (_) => ExpiredAmcViewModel()),
        ChangeNotifierProvider(create: (_) => RenewAmcViewModel()),
        ChangeNotifierProvider(create: (_) => AmcOrderViewModel()),

        ChangeNotifierProvider(create: (_) => PartnerPaymentViewModel()),
        ChangeNotifierProvider(create: (_) => RecentOrderViewModel()),
        ChangeNotifierProvider(create: (_) => VisitViewModel()),
        ChangeNotifierProvider(create: (_) => AssignPartnerViewModel()),
        ChangeNotifierProvider(
          create: (_) => AmcReportViewModel(),
        ),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Admin Panel",
      scrollBehavior: AppScrollBehavior(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
      home: isLoggedIn ? const MainScreen() : const LoginScreen(),
    );
  }
}
