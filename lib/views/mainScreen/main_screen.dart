import 'package:admin_panel/views/Earning%20screens/subscriptions_earning_screen.dart';
import 'package:admin_panel/views/Pages/pages_screen.dart';
import 'package:admin_panel/views/auth%20screen/login_screen.dart';
import 'package:admin_panel/views/category/category_screen.dart';
import 'package:admin_panel/views/orderScreen/order_screen.dart';
import 'package:admin_panel/views/profile%20screen/profile_screen.dart';
import 'package:admin_panel/views/services/services_screen.dart';
import 'package:admin_panel/views/settings/banner_screen.dart';
import 'package:admin_panel/views/settings/city_screen.dart';
import 'package:admin_panel/views/settings/locality_screen.dart';
import 'package:admin_panel/views/settings/reviews_screen.dart';
import 'package:admin_panel/views/settings/state_screen.dart';
import 'package:admin_panel/views/support_Screens/support_screen.dart';
import 'package:admin_panel/views/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_colors.dart';
import '../../service_Api/settings/navigation_viewmodel.dart';
import '../../widgets/drawer/admin_drawer.dart';
import '../Earning screens/booking_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../partner/active_partners.dart';
import '../partner/partner_screen.dart';
import '../partner/pending_partner_screen.dart';
import '../reports/reports_screen.dart';
import '../settings/notifications_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String adminName = "Admin";
  String adminRole = "Admin";

  @override
  void initState() {
    super.initState();
    _loadAdmin();
  }

  Future<void> _loadAdmin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      adminName = prefs.getString("name") ?? "Admin";

      final role = prefs.getString("role") ?? "admin";

      adminRole = role == "super_admin" ? "Super Admin" : "Admin";
    });
  }

  Widget getScreen(String page) {
    switch (page) {
      case "Dashboard":
        return const DashboardScreen();

      case "Category":
        return const CategoryScreen();

      case "Approved Partners":
        return const PartnerScreen();

      case "Pending Approval":
        return const PendingPartnerScreen();

      case "Bookings":
        return const BookingScreen();

      case "Subscriptions":
        return const SubscriptionsEarningScreen();

      case "Users":
        return const UserScreen();

      case "Services":
        return const ServiceScreen();

      case "Orders":
        return const OrdersScreen();

      case "Pages":
        return const PagesScreen();

      case "Banner":
        return const BannerScreen();

      case "State":
        return const StateScreen();

      case "City":
        return const CityScreen();

      case "Locality":
        return const LocalityScreen();

      case "Reviews&Ratings":
        return const ReviewsScreen();

      case "Notifications":
        return const NotificationsScreen();

      case "Reports":
        return const ReportsScreen();

      case "Login":
        return const LoginScreen();

      case "Active Partners":
        return const ActivePartnerScreen();

      case "Support":
        return const SupportScreen();

      default:
        return Center(
          child: Text(
            page,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NavigationViewModel>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth > 900;

        return Scaffold(
          backgroundColor: AppColors.background,
          drawer: isDesktop ? null : const Drawer(child: AdminDrawer()),
          body: Row(
            children: [
              if (isDesktop) const SizedBox(width: 260, child: AdminDrawer()),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 72,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1F5A93), Color(0xFF59B14C)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          if (!isDesktop)
                            Builder(
                              builder: (context) => IconButton(
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              ),
                            ),
                          const Spacer(),
                          const Text(
                            "Admin Panel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const Spacer(),
                          if (constraints.maxWidth > 600)
                            Container(
                              width: isDesktop ? 280 : 180,
                              height: 44,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.14),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.12),
                                ),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: 20,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Search...",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            IconButton(
                              icon: const Icon(Icons.search, color: Colors.white70),
                              onPressed: () {},
                            ),
                          const SizedBox(width: 16),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProfileScreen(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white24,
                                      width: 2,
                                    ),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xff1E3A8A),
                                    ),
                                  ),
                                ),
                                if (isDesktop) ...[
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        adminName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        adminRole,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: AppColors.background,
                        child: getScreen(vm.currentPage),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
