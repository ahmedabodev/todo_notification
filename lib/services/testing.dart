import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/Utlits.dart';

Future<void> createPlantFoodNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
          '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
      body: 'Florist at 123 Main St. has 2 in stock',
      bigPicture: 'asset://assets/notification_map.png',
      notificationLayout: NotificationLayout.BigPicture,

    ),
      actionButtons: [
        NotificationActionButton(
          key: "open",
          label: "Open File",
        ),

      ]

  );
}

Future<void> createWaterReminderNotification({
  required bool repeats,
  required int timeOfDayhour,
  required int timeOfDayminute,
  required int day,
  required int month,
  required int year,
  required String title,
  required String note,
}) async {
  await AwesomeNotifications().createNotification(

    content: NotificationContent(
      displayOnBackground: true,
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: title,
      body: note,

      notificationLayout: NotificationLayout.Default,
    ),

    actionButtons: [
      NotificationActionButton(
        key: "open1",
        label: "Go to Task",
      ),

    ],

    schedule: NotificationCalendar(
      day: day,
      month: month,
      year: year,
      hour: timeOfDayhour,
      minute: timeOfDayminute,
      second: 0,
      millisecond: 0,
      repeats: true,



    ),


  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}
Future<void> cancelScheduledNotificationsbyid(id) async {
  await AwesomeNotifications().cancelSchedule(id);
}
Future<void> showScheduledNotificationsbyid() async {
  await AwesomeNotifications().listScheduledNotifications(

  );
}