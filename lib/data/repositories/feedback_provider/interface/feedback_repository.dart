import 'dart:io';

import 'package:tanod_tractor/data/models/success_model.dart';

import '../../../models/add_update_feedback_model.dart';
import '../../../models/feedback_detail_model.dart';
import '../../../models/feedback_model.dart';
import '../../../models/file_exoort_model.dart';

abstract class IFeedbackRepository {
  Future<FeedbackModel> getAllFeedBackList({map}) {
    throw UnimplementedError();
  }



  Future<AddUpdateFeedbackModel> addNewFeedback({map,List<File>? imageList}) {
    throw UnimplementedError();
  }

  Future<AddUpdateFeedbackModel> updateFeedback({map,List<File>? imageList}) {
    throw UnimplementedError();
  }

  Future<SuccessModel> deleteIssueTitle({map}) {
    throw UnimplementedError();
  }

  Future<SuccessModel> addFarmerConclusion({map}) {
    throw UnimplementedError();
  }


  Future<AdminFeedbackDetailModel> feedbackDetails({map}) {
    throw UnimplementedError();
  }

}
