import 'package:get/get.dart';

import '../../../../app/util/export_file.dart';

class TicketController extends GetxController{
  RxBool isUpdating = false.obs;


  var scrollController = ScrollController();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();



  showPopUpMenuButton({assignTxt,onAssignedTab,onDetailTab, onDeleteTab, onEditTab}) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            if (onDetailTab != null) {
              onDetailTab!();
            }
          },
          value: 0,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.details),
        ),
        PopupMenuItem(
          onTap: () {
            if (onEditTab != null) {
              onEditTab!();
            }
          },
          value: 1,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.editTxt),
        ),



        PopupMenuItem(
          onTap: () {
            if (onDeleteTab != null) {
              onDeleteTab!();
            }
          },
          value: 2,
          // row has two child icon and text.
          child: TractorText(text: AppStrings.deleteTxt),
        )
      ],
    );
  }

}