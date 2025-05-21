import 'dart:io';

import '../../../../../app/util/export_file.dart';

class MultipleImageView extends StatelessWidget {
  List<File>? imageList = [];
  Function? onPlusTab;
  Function(int)? onCancelTab;

  MultipleImageView(
      {this.onPlusTab, this.imageList, this.onCancelTab, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (onPlusTab != null) {
              onPlusTab!();
            }
          },
          child: Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.primary),
            child: Icon(
              Icons.add,
              color: AppColors.white,
              size: 30,
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: SizedBox(
            height: 75.h,
            child: ListView.builder(
                itemCount: imageList?.length ?? 0,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Stack(
                      children: [
                        Container(
                          height: 80.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColors.transparentColor),
                        ),
                        Container(
                          // padding: EdgeInsets.all(3.r),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColors.primary, width: 1),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child:
                                imageList![index].path.toString().startsWith("http")
                                    ? cacheNetworkImage(url:
                                        imageList![index].path,
                                        height: 80.h,
                                        width: 70.w,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        imageList![index],
                                        height: 80.h,
                                        width: 70.w,
                                        fit: BoxFit.fill,
                                      ),
                          ),
                        ),

                        /*   ClipRRect(
                          child: Image.asset(
                            AppPngAssets.noImageFound,
                            height: 80.h,
                            width: 70.w,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),*/

                        Positioned(
                          child: GestureDetector(
                            onTap: () {
                              if (onCancelTab != null) {
                                onCancelTab!(index);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5.r),
                              child: Icon(
                                Icons.delete,
                                size: 22,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          right: -3,
                        )
                      ],
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
