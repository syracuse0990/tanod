
import '../../../../app/util/export_file.dart';
import '../../../models/admin_user_model.dart';
import '../../../models/success_model.dart';

abstract class ISubAdminRepository {
  Future<AdminUserDetailsModel> createNewSubAdmin({map}) {
    throw UnimplementedError();
  }

  Future<AdminUserModel> getAllUserList({map}) {
    throw UnimplementedError();
  }

  Future<SuccessModel> deleteUser({map}) {
    throw UnimplementedError();
  }

  Future<AdminUserDetailsModel> userDetails({map}) {
    throw UnimplementedError();
  }

  Future<AdminUserDetailsModel> updateSubAdmin({map}) {
    throw UnimplementedError();
  }

  Future<TractorGroupModel> getAllGroupList({map}) {
    throw UnimplementedError();
  }

  Future<AssignedModel> assignGroupToSubAdmin({map}) {
    throw UnimplementedError();
  }

}
