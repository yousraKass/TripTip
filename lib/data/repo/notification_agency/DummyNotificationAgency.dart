import 'AbstractNotificationAgency.dart';

class Dummynotificationagency extends Abstractnotificationagency {
  final List<Map<String, dynamic>> notifications = [
    {
      "id": 1,
      "is_read": false,
      "created_at": "12/12/2012",
      "content": "this is a notification",
      "image": "assets/images/here.jpg"
    },
    {
      "id": 2,
      "is_read": true,
      "created_at": "13/12/2012",
      "content": "this is a notification",
      "image": "assets/images/golang.png"
    },
    {
      "id": 3,
      "is_read": true,
      "created_at": "13/12/2012",
      "content": "this is a notification",
      "image": "assets/images/here.jpg"
    },
    {
      "id": 4,
      "is_read": false,
      "created_at": "13/12/2012",
      "content": "this is a notification",
      "image": "assets/images/here.jpg"
    },
    {
      "id": 5,
      "is_read": false,
      "created_at": "13/12/2012",
      "content": "this is a notification",
      "image": "assets/images/here.jpg"
    },
    {
      "id": 6,
      "is_read": false,
      "created_at": "13/12/2012",
      "content": "this is a notification",
      "image": "assets/images/here.jpg"
    },
    {
      "id": 7,
      "is_read": false,
      "created_at": "13/12/2012",
      "content": "this is a notification",
      "image": "assets/images/here.jpg"
    },
    {
      "id": 8,
      "is_read": true,
      "created_at": "13/12/2012",
      "content": "this is a notification",
      "image": "assets/images/here.jpg"
    },
    {
      "id": 9,
      "is_read": true,
      "created_at": "13/12/2012",
      "content": "this is a notification",
      "image": "assets/images/here.jpg"
    },
  ];

  Future<List<Map<String,dynamic>>> GetNotifications() async {
    await Future.delayed(Duration(seconds: 2));
    return notifications;
  }

  Future<bool> SetNotificationRead(int index) async {
    await Future.delayed(Duration(seconds: 2));
    notifications[index]["is_read"] = !notifications[index]["is_read"];
    return true;
  }

  Future<bool> AddNotification(Map<String, dynamic> notification) async {
    await Future.delayed(Duration(seconds: 2));
    notifications.add(notification);
    return true;
  }
}
