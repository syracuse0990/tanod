import 'dart:io';

import 'package:tanod_tractor/data/models/success_model.dart';
import 'package:tanod_tractor/data/models/ticket_model.dart';

import '../../../models/add_update_feedback_model.dart';
import '../../../models/feedback_detail_model.dart';


abstract class ITicketRepository {
  Future<TicketModel> getAllFeedBackList({map}) {
    throw UnimplementedError();
  }


}
