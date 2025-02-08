abstract class Abstractnotificationagency{
  Future<List<Map<String,dynamic>>> GetNotifications();
  Future<bool> SetNotificationRead(int index); 
  Future<bool> AddNotification(Map<String, dynamic> notificatio); 
}