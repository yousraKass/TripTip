import 'package:flutter/material.dart';
import 'package:triptip/main.dart';
import 'package:triptip/views/themes/colors.dart';
import 'package:triptip/views/themes/style.dart';
import 'package:triptip/views/widgets/logos.dart';
import '../../widgets/notification_card_agency.dart';
import 'package:triptip/views/widgets/BottomNavigationBarAgency.dart';


class NotificationsAgency extends StatefulWidget {
  const NotificationsAgency({super.key});

  static const pageRoute = "/notification_agency";
  @override
  State<NotificationsAgency> createState() => _NotificationsAgencyState();
}

class _NotificationsAgencyState extends State<NotificationsAgency> {
  late Future<List<Map<String, dynamic>>> agency_notifications;

  @override
  Widget build(BuildContext context) {
    agency_notifications = notifications.GetNotifications();

    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: back_btn(context),
          title: Text(
            "Notifications",
            style: navbarTitle,
          ),
        ),
        bottomNavigationBar: BottomNavigationBarExampleAgency(),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: agency_notifications,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else {
                      return GetNotificationsList(snapshot.data!);
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  ListView GetNotificationsList(List<Map<String, dynamic>> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            notifications.SetNotificationRead(index);
            // redirect to the notification source here 
            setState(() {});
          },
          child: NotificationCard(
              title: data[index]["content"],
              time: data[index]["created_at"],
              image: data[index]["image"],
              is_read: data[index]["is_read"]),
        );
      },
    );
  }
}
