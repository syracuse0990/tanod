import 'package:tanod_tractor/data/models/success_model.dart';

import '../../../models/admin_static_detail_model.dart';
import '../../../models/static_model.dart';

abstract class IStaticRepository {
  Future<StaticPageModel> getAllStaticList({map}) {
    throw UnimplementedError();
  }

  Future<SuccessModel> deletePageState({map}) {
    throw UnimplementedError();
  }

  Future<AdminStaticDetailModel> pageDetails({map}) {
    throw UnimplementedError();
  }

  Future<AdminStaticDetailModel> updateStaticPage({map}) {
    throw UnimplementedError();
  }


}
