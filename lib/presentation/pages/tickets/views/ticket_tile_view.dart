import 'package:tanod_tractor/presentation/pages/tickets/controllers/ticket_controller.dart';
import 'package:tanod_tractor/presentation/pages/tickets/models/ticket_model.dart';
import '../../../../app/util/export_file.dart';

class TicketListView extends GetView<TicketController> {
  const TicketListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value && controller.tickets.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.tickets.isEmpty) {
          return const Center(
            child: Text(
              "No tickets found.",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (!controller.isLoading.value &&
                scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              controller.loadTickets(loadMore: true);
            }
            return false;
          },
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
            itemCount: controller.tickets.length +
                (controller.isLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.tickets.length) {
                final ticket = controller.tickets[index];
                return TicketTileViewItem(ticket: ticket);
              } else {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        );
      }),
    );
  }
}

class TicketTileViewItem extends StatelessWidget {
  final Ticket ticket;
  const TicketTileViewItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          // Optional: navigate to ticket details
        },
        child: Padding(
          padding: EdgeInsets.all(14.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading icon/avatar
              CircleAvatar(
                radius: 22.r,
                backgroundColor: AppColors.primary.withOpacity(0.15),
                child: Icon(
                  Icons.receipt_long,
                  color: AppColors.primary,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),

              // Ticket info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      ticket.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey[700],
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                        SizedBox(width: 4.w),
                        Text(
                          ticket.createdAt,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // Popup menu
              Align(
                alignment: Alignment.topRight,
                child: Get.find<TicketController>().showPopUpMenuButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
