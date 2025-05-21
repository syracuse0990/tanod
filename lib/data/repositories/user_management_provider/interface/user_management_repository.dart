import 'package:tanod_tractor/data/models/success_model.dart';

import '../../../models/admin_user_detail_model.dart';
import '../../../models/admin_user_model.dart';

abstract class IUserManagementRepository {
  Future<AdminUserModel> getAllUserList({map}) {
    throw UnimplementedError();
  }


  Future<SuccessModel> deleteUser({map}) {
    throw UnimplementedError();
  }

  Future<AdminUserDetailsModel>  userDetails({map}) {
    throw UnimplementedError();
  }


  Future<AdminUserDetailsModel>  updateUserDetails({formData}) {
    throw UnimplementedError();
  }


}
