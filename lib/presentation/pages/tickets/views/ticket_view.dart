import 'package:tanod_tractor/presentation/pages/tickets/controllers/ticket_controller.dart';

import '../../../../app/util/export_file.dart';
import 'add_update_ticket_view.dart';
import 'ticket_tile_view.dart';

class TicketView extends GetView<TicketController> {
  const TicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add,color: AppColors.white,),
          backgroundColor: AppColors.primary,
          onPressed: () {
            Get.to(() => AddUpdateTicketView(
              isUpdating: false,
            ));
  
          },
        ),
        appBar: TractorBackArrowBar(
          firstLabel: 'Tickets',
          firstTextStyle: TextStyle(
            fontFamily: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500)
                .fontFamily,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
        body: Column(
          children: [
            TicketListView()
          ],
        ));
  }
}
