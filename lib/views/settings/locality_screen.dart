import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service_Api/settings/city_auth.dart';
import '../../service_Api/settings/locality_auth.dart';
import '../../service_Api/settings/state_auth.dart';
import '../../service_model/settings_model/locality_model.dart';


class LocalityScreen extends StatelessWidget {
  const LocalityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      /// Screen open hote hi localities fetch
      create: (_) => LocalityAuth()..fetchLocalities(),
      child: Consumer<LocalityAuth>(
        builder: (context, vm, child) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Locality",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Home > Settings > Locality",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
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

                /// SEARCH + ENTRIES
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
                      SizedBox(
                        width: 260,
                        child: TextField(
                          onChanged: vm.searchLocality,
                          decoration: InputDecoration(
                            hintText: "Search Locality",
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

                /// TABLE
                if (vm.isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
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
                            Container(
                              padding: const EdgeInsets.all(14),
                              color: Colors.blue.shade50,
                              child: const Row(
                                children: [
                                  Expanded(flex: 1, child: Text("ID")),
                                  Expanded(flex: 3, child: Text("LOCALITY")),
                                  Expanded(flex: 3, child: Text("CITY")),
                                  Expanded(flex: 3, child: Text("STATE")),
                                  Expanded(flex: 2, child: Text("STATUS")),
                                  Expanded(flex: 2, child: Text("ACTION")),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: vm.paginatedLocalities.length,
                                itemBuilder: (context, index) {
                                  final item = vm.paginatedLocalities[index];

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
                                          flex: 3,
                                          child: Text(item.localityName),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(item.cityName),
                                        ),
                                        Expanded(
                                          flex: 3,
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

                /// PAGINATION
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

  /// ================================
  /// ADD DIALOG
  /// ================================
  void _showAddDialog(BuildContext context, LocalityAuth vm) {
    final localityController = TextEditingController();
    String? selectedState;
    String? selectedCity;

    final stateVm = context.read<StateAuth>();
    final cityVm = context.read<CityAuth>();

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            final availableCities = cityVm.allCities
                .where((c) => selectedState == null || c.stateName == selectedState)
                .toList();

            return AlertDialog(
              title: const Text("Add Locality"),
              content: SizedBox(
                width: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: localityController,
                      decoration: const InputDecoration(
                        labelText: "Locality Name",
                      ),
                    ),
                    const SizedBox(height: 14),

                    /// STATE searchable picker
                    _SearchPickerField(
                      label: "State Name",
                      value: selectedState,
                      hint: "Search state",
                      items: stateVm.allStates.map((e) => e.name).toList(),
                      onSelected: (value) {
                        setState(() {
                          selectedState = value;
                          selectedCity = null; // state change => city reset
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    /// CITY searchable picker
                    _SearchPickerField(
                      label: "City Name",
                      value: selectedCity,
                      hint: selectedState == null
                          ? "Select state first"
                          : "Search city",
                      items: availableCities.map((e) => e.cityName).toList(),
                      enabled: selectedState != null,
                      onSelected: (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final localityName = localityController.text.trim();

                    if (localityName.isNotEmpty &&
                        selectedState != null &&
                        selectedCity != null) {
                      await vm.addLocality(
                        localityName: localityName,
                        cityName: selectedCity!,
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

  /// ================================
  /// EDIT DIALOG
  /// ================================
  void _showEditDialog(
      BuildContext context,
      LocalityAuth vm,
      LocalityModel item,
      ) {
    final localityController = TextEditingController(text: item.localityName);
    String? selectedState = item.stateName;
    String? selectedCity = item.cityName;

    final stateVm = context.read<StateAuth>();
    final cityVm = context.read<CityAuth>();

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            final availableCities = cityVm.allCities
                .where((c) => selectedState == null || c.stateName == selectedState)
                .toList();

            return AlertDialog(
              title: const Text("Edit Locality"),
              content: SizedBox(
                width: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: localityController,
                      decoration: const InputDecoration(
                        labelText: "Locality Name",
                      ),
                    ),
                    const SizedBox(height: 14),

                    /// STATE searchable picker
                    _SearchPickerField(
                      label: "State Name",
                      value: selectedState,
                      hint: "Search state",
                      items: stateVm.allStates.map((e) => e.name).toList(),
                      onSelected: (value) {
                        setState(() {
                          selectedState = value;
                          selectedCity = null;
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    /// CITY searchable picker
                    _SearchPickerField(
                      label: "City Name",
                      value: selectedCity,
                      hint: selectedState == null
                          ? "Select state first"
                          : "Search city",
                      items: availableCities.map((e) => e.cityName).toList(),
                      enabled: selectedState != null,
                      onSelected: (value) {
                        setState(() {
                          selectedCity = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final localityName = localityController.text.trim();

                    if (localityName.isNotEmpty &&
                        selectedState != null &&
                        selectedCity != null) {
                      await vm.updateLocality(
                        id: item.id,
                        localityName: localityName,
                        cityName: selectedCity!,
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

  /// ================================
  /// DELETE DIALOG
  /// ================================
  void _showDeleteDialog(
      BuildContext context,
      LocalityAuth vm,
      LocalityModel item,
      ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Locality"),
          content: Text('Do you want to delete "${item.localityName}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await vm.deleteLocality(item.id);
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

/// =====================================================
/// SEARCHABLE PICKER FIELD
/// Click karega to searchable dialog open hoga
/// =====================================================
class _SearchPickerField extends StatelessWidget {
  final String label;
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String> onSelected;
  final bool enabled;

  const _SearchPickerField({
    required this.label,
    required this.value,
    required this.hint,
    required this.items,
    required this.onSelected,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !enabled
          ? null
          : () async {
        final selected = await _showSearchDialog(
          context: context,
          title: label,
          hint: hint,
          items: items,
          selectedValue: value,
        );

        if (selected != null) {
          onSelected(selected);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        child: Text(
          value ?? hint,
          style: TextStyle(
            color: value == null ? Colors.grey.shade600 : Colors.black,
          ),
        ),
      ),
    );
  }

  /// Search dialog for dropdown-like selection
  Future<String?> _showSearchDialog({
    required BuildContext context,
    required String title,
    required String hint,
    required List<String> items,
    String? selectedValue,
  }) async {
    String search = '';

    return showDialog<String>(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            final filtered = items
                .where((e) => e.toLowerCase().contains(search.toLowerCase()))
                .toList();

            return AlertDialog(
              title: Text(title),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: hint,
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: (v) {
                        setState(() {
                          search = v;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: filtered.isEmpty
                          ? const Center(child: Text("No result"))
                          : ListView.builder(
                        shrinkWrap: true,
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          final isSelected = item == selectedValue;

                          return ListTile(
                            title: Text(item),
                            trailing: isSelected
                                ? const Icon(Icons.check)
                                : null,
                            onTap: () {
                              Navigator.pop(context, item);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}