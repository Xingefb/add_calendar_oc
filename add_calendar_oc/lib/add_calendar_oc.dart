import 'dart:async';

import 'package:flutter/services.dart';

class AddCalendarOc {
  static const MethodChannel _channel =
      const MethodChannel('www.loself.com/add_calendar_oc');
  // title \description\location\
  static Future addCalendar(
    String title,
    String notes, {
    String startTime,
    String endTime,
    String lication,
    bool allDay,
  }) async {
    await _channel.invokeMethod('add_calendar', {
      'title': title,
      'notes': notes,
      'start_time': startTime,
      'end_time': endTime,
      'location': lication ?? '',
      'all_day': allDay ?? false
    });
  }
}
