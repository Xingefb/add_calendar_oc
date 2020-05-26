import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:add_calendar_oc/add_calendar_oc.dart';

void main() {
  const MethodChannel channel = MethodChannel('add_calendar_oc');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await AddCalendarOc.platformVersion, '42');
  // });
}
