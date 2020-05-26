#import "AddCalendarOcPlugin.h"
#import <EventKit/EventKit.h>

@implementation AddCalendarOcPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"www.loself.com/add_calendar_oc"
            binaryMessenger:[registrar messenger]];
  AddCalendarOcPlugin* instance = [[AddCalendarOcPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"add_calendar" isEqualToString:call.method]) {
      [self addCalendar:call];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)addCalendar:(FlutterMethodCall*)call {
    NSString *title = [self tempString:call.arguments[@"title"]];
    NSString *notes = [self tempString:call.arguments[@"notes"]];
    NSString *startTime = [self tempString:call.arguments[@"start_time"]];
    NSString *endTime = [self tempString:call.arguments[@"end_time"]];
    NSString *location = [self tempString:call.arguments[@"location"]];
    BOOL allDay = [call.arguments[@"all_day"] boolValue];
    NSLog(@"%@ %@ %@ %@ %@",title,notes,startTime,endTime,location);
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    [eventDB requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
         if (granted && NULL == error) { //授权是否成功
             dispatch_async(dispatch_get_main_queue(), ^{
                    EKEvent *event  = [EKEvent eventWithEventStore:eventDB]; //创建一个日历事件
                        event.title = title;
                        event.notes = notes;
                        event.allDay = allDay;
                        event.timeZone = timeZone;
                        event.startDate =  [NSDate dateWithTimeIntervalSince1970:[self milliseconds:startTime]];
                        event.endDate =  [NSDate dateWithTimeIntervalSince1970:[self milliseconds:endTime]];
                       if (NULL != location) {
                           event.location = location;
                       }
                 
                        [self presentPage:event witheventStore:eventDB];
             });

          }
     }];
}

- (void)presentPage:(EKEvent * )event witheventStore:(EKEventStore *)eventStore {
    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (authStatus == EKAuthorizationStatusAuthorized) {
        [self presentEventCalendarDetailModal: event witheventStore:eventStore];
    }
}

- (void)presentEventCalendarDetailModal:(EKEvent * )event witheventStore:(EKEventStore *)eventStore {
    EKEventEditViewController *eventModalVC = [[EKEventEditViewController alloc] init];
    eventModalVC.event = event;
    eventModalVC.eventStore = eventStore;
    eventModalVC.editViewDelegate = self;
    eventModalVC.modalPresentationStyle = UIModalPresentationFullScreen;
    FlutterViewController *controller = (FlutterViewController *) [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [controller presentViewController:eventModalVC animated:YES completion:nil];
}

- (NSString *)tempString:(id)text {
    return (NULL == text || nil == text) ? @"":text;
}

// 计算时间
- (NSTimeInterval )milliseconds:(NSString *)time {
    double second = [time doubleValue];
    NSTimeInterval seconds = second/1000.0;
    return seconds;
}

#pragma mark - eventEditDelegates -
- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action{
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
