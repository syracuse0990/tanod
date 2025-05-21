
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:tanod_tractor/data/models/file_exoort_model.dart';
import 'package:tanod_tractor/data/models/ticket_model.dart';

import '../../../../app/util/export_file.dart';
import '../../../../app/util/util.dart';
import '../../../models/add_update_feedback_model.dart';
import '../../../models/feedback_detail_model.dart';
import '../../../models/feedback_model.dart';
import '../../../models/success_model.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/ticket_repository.dart';

class RemoteTicketProvider extends DioBaseProvider implements ITicketRepository {
  @override
  Future<TicketModel> getAllFeedBackList({map}) {
    // TODO: implement getAllFeedBackList
    throw UnimplementedError();
  }




}
