import 'package:admin_panel/core/App_permission/app_permission.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service_Api/settings/city_auth.dart';
import '../../service_Api/settings/state_auth.dart';
import '../../service_model/settings_model/city_model.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      /// Screen open hote hi cities fetch hon
      create: (_) => CityAuth()..fetchCities(),
      child: Consumer<CityAuth>(
        builder: (context, vm, child) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// =====================================
                /// HEADER
                /// =====================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "City",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Home > Settings > City",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    /// ADD BUTTON
                    ElevatedButton.icon(
                      onPressed: () {
                        _showAddDialog(context, vm);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff111827),
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text("Add New"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// =====================================
                /// SEARCH + ENTRIES
                /// =====================================
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// ENTRIES DROPDOWN
                      Row(
                        children: [
                          const Text("Show"),
                          const SizedBox(width: 10),
                          DropdownButton<int>(
                            value: vm.selectedEntries,
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
                          const SizedBox(width: 10),
                          const Text("entries"),
                        ],
                      ),

                      /// SEARCH BOX
                      SizedBox(
                        width: 260,
                        child: TextField(
                          onChanged: vm.searchCity,
                          decoration: InputDecoration(
                            hintText: "Search City",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// =====================================
                /// TABLE
                /// =====================================
                if (vm.isLoading)
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (vm.errorMessage != null)
                  Expanded(
                    child: Center(
                      child: Text(
                        vm.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Column(
                          children: [
                            /// TABLE HEADER
                            Container(
                              padding: const EdgeInsets.all(14),
                              color: Colors.blue.shade50,
                              child: const Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text("ID"),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text("CITY NAME"),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text("STATE NAME"),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("STATUS"),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text("ACTION"),
                                  ),
                                ],
                              ),
                            ),

                            /// TABLE BODY
                            Expanded(
                              child: ListView.builder(
                                itemCount: vm.paginatedCities.length,
                                itemBuilder: (context, index) {
                                  final item = vm.paginatedCities[index];

                                  return Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(item.id.toString()),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(item.cityName),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Text(item.stateName),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Switch(
                                            value: item.status,
                                            onChanged: (value) {
                                              vm.toggleStatus(item.id, value);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit),
                                                onPressed: () {
                                                  _showEditDialog(
                                                    context,
                                                    vm,
                                                    item,
                                                  );
                                                },
                                              ),
                                              if(AppPermission.isSuperAdmin)
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  _showDeleteDialog(
                                                    context,
                                                    vm,
                                                    item,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                /// =====================================
                /// PAGINATION
                /// =====================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: vm.previousPage,
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Text("${vm.currentPage}"),
                    IconButton(
                      onPressed: vm.nextPage,
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// =====================================
  /// ADD DIALOG
  /// =====================================
  void _showAddDialog(
      BuildContext context,
      CityAuth vm,
      ) {
    final cityController = TextEditingController();
    String? selectedState;

    /// StateAuth ko yahan read kar lo
    final stateVm = context.read<StateAuth>();

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add City"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// CITY NAME
                  TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      labelText: "City Name",
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// STATE DROPDOWN from StateAuth
                  DropdownButtonFormField<String>(
                    value: selectedState,
                    decoration: const InputDecoration(
                      labelText: "State Name",
                    ),
                    items: stateVm.allStates.map((state) {
                      return DropdownMenuItem<String>(
                        value: state.name,
                        child: Text(state.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedState = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final cityName = cityController.text.trim();

                    if (cityName.isNotEmpty && selectedState != null) {
                      await vm.addCity(
                        cityName: cityName,
                        stateName: selectedState!,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// =====================================
  /// EDIT DIALOG
  /// =====================================
  void _showEditDialog(
      BuildContext context,
      CityAuth vm,
      CityModel item,
      ) {
    final cityController = TextEditingController(text: item.cityName);
    String? selectedState = item.stateName;

    /// StateAuth ko yahan read kar lo
    final stateVm = context.read<StateAuth>();

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Edit City"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// CITY NAME
                  TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      labelText: "City Name",
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// STATE DROPDOWN from StateAuth
                  DropdownButtonFormField<String>(
                    value: selectedState,
                    decoration: const InputDecoration(
                      labelText: "State Name",
                    ),
                    items: stateVm.allStates.map((state) {
                      return DropdownMenuItem<String>(
                        value: state.name,
                        child: Text(state.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedState = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final cityName = cityController.text.trim();

                    if (cityName.isNotEmpty && selectedState != null) {
                      await vm.updateCity(
                        id: item.id,
                        cityName: cityName,
                        stateName: selectedState!,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Update"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// =====================================
  /// DELETE DIALOG
  /// =====================================
  void _showDeleteDialog(
      BuildContext context,
      CityAuth vm,
      CityModel item,
      ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete City"),
          content: Text('Do you want to delete "${item.cityName}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await vm.deleteCity(item.id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}