import 'package:flutter/cupertino.dart';

import '../../Amc_Model/active_amc_model.dart';

class CustomerInfoCard extends StatelessWidget {

  final ActiveAmcModel amc;

  final bool showStatus;

  final String title;

  const CustomerInfoCard({
    super.key,
    required this.amc,
    this.showStatus = false,
    this.title = "Customer Information",
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}