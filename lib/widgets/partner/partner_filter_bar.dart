import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service_Api/partner/partner_auth.dart';

class PartnerFilterBar extends StatelessWidget {
  final bool isPending;

  const PartnerFilterBar({
    super.key,

    this.isPending = false,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<PartnerAuth>(
      builder: (context, vm, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [

              /// SEARCH
              SizedBox(
                height: 46,
                child: TextField(
                  onChanged: isPending
                      ? vm.searchPendingPartner
                      : vm.searchPartner,
                  decoration: InputDecoration(
                    hintText:
                    "Search Name / Mobile / Partner ID",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    isDense: true,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [

                  _dropdown(
                    title: "Category",
                    value: vm.selectedCategory,
                    items: vm.categoryOptions,
                    onChanged: vm.changeCategoryFilter,
                  ),

                  _dropdown(
                    title: "State",
                    value: vm.selectedState,
                    items: vm.stateOptions,
                    onChanged: vm.changeStateFilter,
                  ),

                  _dropdown(
                    title: "City",
                    value: vm.selectedCity,
                    items: vm.cityOptions,
                    onChanged: vm.changeCityFilter,
                  ),

                  _dropdown(
                    title: "Locality",
                    value: vm.selectedLocality,
                    items: vm.localityOptions,
                    onChanged: vm.changeLocalityFilter,
                  ),

                  if (isPending)
                    _dropdown(
                      title: "Pending",
                      value: vm.selectedPendingDate,
                      items: const [
                        "today",
                        "yesterday",
                        "last7",
                        "all",
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          vm.changePendingDateFilter(v);
                        }
                      },
                    ),

                  SizedBox(
                    height: 46,
                    child: FilledButton.icon(
                      onPressed: vm.resetFilters,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Reset"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _dropdown({
    required String title,
    required List<String> items,
    required String? value,
    required Function(String?) onChanged,
  }) {
    return SizedBox(
      width: 210,
      child: DropdownSearch<String>(
        items: (String filter, LoadProps? loadProps) => items,
        selectedItem: value,

        // 👇 YE HI SAHI HAI
        onChanged: (String? value) {
          onChanged(value);
        },

        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            labelText: title,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: const TextFieldProps(
            decoration: InputDecoration(
              hintText: "Search...",
            ),
          ),
        ),
      ),
    );

  }


}