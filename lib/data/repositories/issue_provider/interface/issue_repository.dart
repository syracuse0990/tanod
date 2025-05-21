import 'package:tanod_tractor/data/models/success_model.dart';

import '../../../models/add_update_issue_model.dart';
import '../../../models/issue_model.dart';

abstract class IIssueRepository {
  Future<IssueTypeModel> getAllIssueTypeList({map}) {
    throw UnimplementedError();
  }



  Future<AddUpdateIssueModel> addNewIssue({map}) {
    throw UnimplementedError();
  }

  Future<AddUpdateIssueModel> updateNewIssue({map}) {
    throw UnimplementedError();
  }

  Future<SuccessModel> deleteIssueTitle({map}) {
    throw UnimplementedError();
  }
}
