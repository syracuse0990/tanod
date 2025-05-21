import 'package:flutter/scheduler.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tanod_tractor/data/repositories/static_provider/interface/static_repository.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/static_page_data_model.dart';
import '../../../../../data/repositories/static_provider/impl/remote_static_provider.dart';

class StaticPageController extends GetxController with BaseController {
  IStaticRepository? iStaticRepository;
  RxList<StaticPageDataModel>? pagesList = <StaticPageDataModel>[].obs;
  var titleController = TextEditingController();
  HtmlEditorController htmlEditorController = HtmlEditorController();

  var detailDataModel = Rxn<StaticPageDataModel>();

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      iStaticRepository = Get.put(RemoteStaticProvider());

      hitApiToGetAllPages();
    });
    super.onInit();
  }

  showDetailsOnTab(StaticPageDataModel? staticPageDataModel) {
    if (staticPageDataModel != null) {
      titleController.text = staticPageDataModel?.title ?? "";
      update();
    }
  }

  showPopUpMenuButton({onDetailTab, onDeleteTab, onEditTab}) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            if (onDetailTab != null) {
              onDetailTab!();
            }
          },
          value: 1,
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

  Future hitApiToGetAllPages() async {
    pagesList?.clear();
    showLoading("Loading");

    await iStaticRepository?.getAllStaticList().then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        pagesList?.addAll(value.data?.pages ?? []);
        pagesList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToDeletePage({index, id}) async {
    showLoading("Loading");

    await iStaticRepository?.deletePageState(map: {'id': id}).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        pagesList?.removeAt(index);
        pagesList?.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToGetDetails({pageType}) async {
    showLoading("Loading");

    await iStaticRepository
        ?.pageDetails(map: {"page_type": pageType}).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        detailDataModel.value = value?.data;
        detailDataModel.refresh();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }

  Future hitApiToCreateNewPage(StaticPageDataModel? staticPageDataModel) async {
    if (titleController.text.isEmpty) {
      showToast(message: AppStrings.titleIsEmpty);
      return;
    } /*else if (htmlEditorController.getText().toString().trim().isNotEmpty) {
      showToast(message: AppStrings.pleaseEnterDescription);
      return;
    }*/
    Map<String, dynamic> map = {};
    map['id'] = staticPageDataModel?.id;
    map['title'] = titleController.text;
    map['description'] = await htmlEditorController.getText();
    map['page_type'] = staticPageDataModel?.pageType;

    showLoading("Loading");

    await iStaticRepository?.updateStaticPage(map: map).then((value) {
      hideLoading();
      if (value != null && value.data != null) {
        Get.back();
      }
    }).onError((error, stackTrace) {
      hideLoading();
      showToast(message: error?.toString());
    });
  }
}
