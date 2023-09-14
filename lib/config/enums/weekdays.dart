import 'package:intl/intl.dart';

enum Weekday { domingo, lunes, martes, miercoles, jueves, viernes, sabado }

extension WeekdayExtension on Weekday {
  String get nombre {
    switch (this) {
      case Weekday.domingo:
        return DateFormat('EEEE').format(DateTime.now());
      case Weekday.lunes:
        return DateFormat('EEEE').format(DateTime.now());
      case Weekday.martes:
        return DateFormat('EEEE').format(DateTime.now());
      case Weekday.miercoles:
        return DateFormat('EEEE').format(DateTime.now());
      case Weekday.jueves:
        return DateFormat('EEEE').format(DateTime.now());
      case Weekday.viernes:
        return DateFormat('EEEE').format(DateTime.now());
      case Weekday.sabado:
        return DateFormat('EEEE').format(DateTime.now());
      default:
        return '';
    }
  }
}
