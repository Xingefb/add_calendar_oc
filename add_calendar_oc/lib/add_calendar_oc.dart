import 'dart:async';

import 'package:flutter/services.dart';

class AddCalendarOc {
  static const MethodChannel _channel =
      const MethodChannel('www.loself.com/add_calendar_oc');
  // title \description\location\
  static Future addCalendar(
    String title,
    String notes, {
    DateTime startTime,
    DateTime endTime,
    String lication,
    bool allDay,
  }) async {
    await _channel.invokeMethod('add_calendar', {
      'title': title,
      'notes': notes,
      'start_time': startTime.millisecondsSinceEpoch.toString(),
      'end_time': endTime.millisecondsSinceEpoch.toString(),
      'location': lication ?? '',
      'all_day': allDay ?? false
    });
  }
}
