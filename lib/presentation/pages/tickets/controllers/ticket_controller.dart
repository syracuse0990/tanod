import 'dart:convert';

import 'package:tanod_tractor/data/providers/network/dio_base_provider.dart';
import 'package:tanod_tractor/data/providers/network/dio_exceptions.dart';
import 'package:tanod_tractor/presentation/pages/tickets/models/ticket_model.dart';

import '../../../../app/util/export_file.dart';

class TicketController extends DioBaseProvider{
  RxBool isUpdating = false.obs;



  var scrollController = ScrollController();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  var tickets = <Ticket>[].obs;
  var isLoading = false.obs;
  var pageNo = 1;
  var totalPages = 1;

    @override
  void onInit() {
    super.onInit();
    loadTickets();
  }

  Future<void> loadTickets({bool loadMore = false}) async {
    if (loadMore && pageNo >= totalPages) return;

    isLoading.value = true;

    try {
      final response = await dio.get(
        APIEndpoint.ticketListUrl,
        queryParameters: {"page_no": pageNo}, // adjust if your API uses `page`
      );

      final ticketsResponse = TicketsResponse.fromJson(response.data);

      totalPages = ticketsResponse.data.totalPages;

      if (loadMore) {
        tickets.addAll(ticketsResponse.data.tickets);
      } else {
        tickets.assignAll(ticketsResponse.data.tickets);
      }

      pageNo++;
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTicket() async{
    var body = {
      "title": titleController.text,
      "description": descriptionController.text,
    };
    try {

      var response = await dio.post(APIEndpoint.createTicketUrl, data: jsonEncode(body) );


     
     
    } catch (e) {

      // showToast(message: NetworkExceptions.getDioException(e));
      // rethrow;
    }
  }
  

  showPopUpMenuButton({assignTxt,onAssignedTab,onDetailTab, onDeleteTab, onEditTab}) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            if (onDetailTab != null) {
              onDetailTab!();
            }
          },
          value: 0,
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

}