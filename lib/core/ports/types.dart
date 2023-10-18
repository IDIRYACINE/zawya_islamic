import 'package:flutter/material.dart';
import 'package:zawya_islamic/core/aggregates/group.dart';
import 'package:zawya_islamic/core/entities/export.dart';
import 'package:zawya_islamic/core/entities/quran.dart';

typedef SuratCllaback = void Function(Surat? surat);
typedef DataLoaderCallback = void Function(BuildContext context);
typedef OnGroupSelectedCallback = void Function(Group? group);
typedef OnDaySelectedCallback = void Function(Day? day);
typedef WeekDaySchedules = List<List<GroupScheduleEntry>>;
typedef WidgetBuilderWithNoContext = Widget Function();
