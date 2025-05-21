import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'app/util/export_file.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
          view: CalendarView.month,
          onTap: (CalendarTapDetails? details){

            if (details!.targetElement == CalendarElement.appointment) {
              dynamic appointments = details.appointments;
              final String subject =
              details.appointments![0].subject.toString();
              final dynamic startTime = details.appointments![0].startTime;
              final dynamic endTime = details.appointments![0].endTime;

              print("check all infor ${appointments}");
            }


          },
          dataSource: MeetingDataSource(_getDataSource()),
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ));
  }

  List _getDataSource() {
    final List meetings = [];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting(
        'Third conference ', startTime, endTime,Colors.yellow, false));

    meetings.add(Meeting(
        'second conference ', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

  class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List source) {
  appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
  return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
  return appointments![index].to;
  }

  @override
  String getSubject(int index) {
  return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
  return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
  return appointments![index].isAllDay;
  }

  }

  class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  }