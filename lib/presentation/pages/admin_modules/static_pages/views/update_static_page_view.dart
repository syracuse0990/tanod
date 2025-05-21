import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tanod_tractor/presentation/pages/admin_modules/static_pages/controller/static_page_controller.dart';

import '../../../../../app/util/export_file.dart';
import '../../../../../data/models/static_page_data_model.dart';

class CreateStaticPageView extends GetView<StaticPageController> {
  StaticPageDataModel? staticPageDataModel;

  CreateStaticPageView({this.staticPageDataModel, super.key}) {
    controller.showDetailsOnTab(staticPageDataModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TractorBackArrowBar(
        firstLabel: AppStrings.createStaticPages,
        firstTextStyle: TextStyle(
          fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
              .fontFamily,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TractorText(text: AppStrings.titleTxt),
            _titleTextFieldWidget,
            SizedBox(
              height: 20.h,
            ),
            const TractorText(text: AppStrings.description),
            SizedBox(
              height: 10.h,
            ),
            _descriptionTextFieldWidget,
            SizedBox(
              height: 100.h,
            ),
            TractorButton(
              text: AppStrings.submit,
              //: AppStrings.update,
              onTap: () {
                controller.hitApiToCreateNewPage(staticPageDataModel);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget get _titleTextFieldWidget => TractorTextfeild(
        controller: controller.titleController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.name,
        hint: AppStrings.titleTxt,
      );

  Widget get _descriptionTextFieldWidget => SizedBox(
        child: HtmlEditor(
          controller: controller.htmlEditorController, //required
          htmlEditorOptions: HtmlEditorOptions(
            shouldEnsureVisible: true,
            inputType: HtmlInputType.email,
            hint: "Your text here...",
            initialText: staticPageDataModel?.description??"sd"
          ),
          otherOptions: OtherOptions(
            height: 400,
          ),
        ),
      );
}
