

import 'package:tanod_tractor/app/util/export_file.dart';

class RecipientModel {
  final String group;
  final String tractor;
  final String device;
  final String recipient;
  final String dateTagged;

  RecipientModel({
    required this.group,
    required this.tractor,
    required this.device,
    required this.recipient,
    required this.dateTagged,
  });
}

class FCAController extends GetxController {
  var recipients = <RecipientModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    print("FCAController init");
  }

  void loadRecipients() {
    // For now, test data
    recipients.value = [
      RecipientModel(
        group: "Laguna",
        tractor: "869066062212940",
        device: "869066062212940",
        recipient: "Paula Grace Aquino",
        dateTagged: "2025-08-14 07:13",
      ),
      RecipientModel(
        group: "Test User",
        tractor: "869066062212940",
        device: "869066062212940",
        recipient: "Ronald",
        dateTagged: "2025-08-14 07:08",
      ),
      RecipientModel(
        group: "Laguna",
        tractor: "869066062217154",
        device: "869066062217154",
        recipient: "Navs",
        dateTagged: "2025-08-14 06:20",
      ),
    ];
  }
}
