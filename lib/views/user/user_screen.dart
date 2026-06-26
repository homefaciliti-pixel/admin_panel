import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service_Api/users/user_auth.dart';
import '../../widgets/common/app_table_shimmer.dart';
import '../../widgets/userTable/user_table.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late TextEditingController _searchTextController;
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _mobileController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _mobileController = TextEditingController();
    _addressController = TextEditingController();
  }
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      context.read<UserViewmodel>().fetchUsers();
      _loaded = true;
    }
  }


  @override
  void dispose() {
    _searchTextController.dispose();
    _idController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    _addressController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewmodel>(
      builder: (context, vm, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// PAGE HEADER
              Row(
                children: [
                  const Text(
                    "Users",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Home > users",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  const Spacer(),

                  /// SEARCH FIELD
                  SizedBox(
                    width: 220,
                    child: TextField(
                      controller: _searchTextController,
                      onChanged: vm.searchUser,
                      decoration: InputDecoration(
                        hintText: "Search User",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// FILTER TOGGLE BUTTON
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: vm.toggleFilters,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: vm.showFilters
                              ? const Color(0xff111827)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: vm.showFilters
                                ? const Color(0xff111827)
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Icon(
                          vm.showFilters
                              ? Icons.filter_list_off
                              : Icons.filter_list,
                          color: vm.showFilters
                              ? Colors.white
                              : Colors.grey.shade700,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// DYNAMIC ADVANCED FILTERS PANEL
              if (vm.showFilters) ...[
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildFilterField(
                        controller: _idController,
                        hint: "Filter by ID",
                        icon: Icons.badge_outlined,
                        onChanged: vm.searchById,
                      ),
                      _buildFilterField(
                        controller: _nameController,
                        hint: "Filter by Name",
                        icon: Icons.person_outline,
                        onChanged: vm.searchByName,
                      ),
                      _buildFilterField(
                        controller: _mobileController,
                        hint: "Filter by Mobile",
                        icon: Icons.phone_outlined,
                        onChanged: vm.searchByMobile,
                      ),
                      _buildFilterField(
                        controller: _addressController,
                        hint: "Filter by Address",
                        icon: Icons.home_outlined,
                        onChanged: vm.searchByAddress,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          _searchTextController.clear();
                          _idController.clear();
                          _nameController.clear();
                          _mobileController.clear();
                          _addressController.clear();
                          vm.clearAllFilters();
                        },
                        icon: const Icon(
                          Icons.clear_all_rounded,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        label: const Text(
                          "Clear Filters",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 25),

              /// LOADING STATE
              if (vm.isLoading)
                const Expanded(
                  child: AppTableShimmer(
                    rows: 8,
                    columns: 8,
                  ),
                )
              /// ERROR STATE
              else if (vm.errorMessage != null)
                Expanded(
                  child: Center(
                    child: Text(
                      vm.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                )
              /// TABLE + PAGINATION
              else ...[
                /// USER TABLE
                Expanded(
                  child: UserTable(users: vm.paginatedUsers, vm: vm),
                ),

                const SizedBox(height: 10),

                /// PAGINATION BAR
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Show",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButton<int>(
                              value: vm.selectedEntries,
                              underline: const SizedBox(),
                              items: [10, 20, 50, 100].map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text("$e"),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  vm.changeEntries(value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("entries"),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: vm.previousPage,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const Icon(Icons.chevron_left),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xff111827),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "${vm.currentPage}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: vm.nextPage,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const Icon(Icons.chevron_right),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  /// Helper filter textfield builder
  Widget _buildFilterField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required ValueChanged<String> onChanged,
  }) {
    return SizedBox(
      width: 175,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, size: 16, color: Colors.grey.shade500),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xff111827)),
          ),
        ),
      ),
    );
  }
}
