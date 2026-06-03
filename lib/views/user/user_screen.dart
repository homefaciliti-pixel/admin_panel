import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service_Api/users/user_auth.dart';
import '../../viewmodels/user_viewmodel.dart';
import '../../widgets/userTable/user_table.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      /// Screen open hote hi users fetch
      create: (_) => UserViewmodel()..fetchUsers(),
      child: Consumer<UserViewmodel>(
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
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "Home > users",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),

                    /// SEARCH FIELD
                    SizedBox(
                      width: 220,
                      child: TextField(
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
                  ],
                ),

                const SizedBox(height: 25),

                /// LOADING STATE
                if (vm.isLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                /// ERROR STATE
                else if (vm.errorMessage != null)
                  Expanded(
                    child: Center(
                      child: Text(
                        vm.errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                /// TABLE + PAGINATION
                else ...[
                    /// USER TABLE
                    Expanded(
                      child: UserTable(
                        users: vm.paginatedUsers,
                        vm: vm,
                      ),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
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
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
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
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
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
      ),
    );
  }
}