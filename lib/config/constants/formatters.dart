import 'package:cinemapedia/config/enums/months.dart';
import 'package:cinemapedia/config/enums/weekdays.dart';

class Formatters {
  static DateTime now = DateTime.now();

  static String weekday = getWeekdayName(now.weekday);
  static String month = getMonthName(now.month);
  static String day = getDayTermination(now.day);

  static String formattedDate = "$weekday, $month ${now.day}$day";
}

String getWeekdayName(int day) {
  switch (day) {
    case 1:
      return Weekday.lunes.nombre;
    case 2:
      return Weekday.martes.nombre;
    case 3:
      return Weekday.miercoles.nombre;
    case 4:
      return Weekday.jueves.nombre;
    case 5:
      return Weekday.viernes.nombre;
    case 6:
      return Weekday.sabado.nombre;
    case 7:
      return Weekday.domingo.nombre;
    default:
      return '';
  }
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return Month.enero.nombre;
    case 2:
      return Month.febrero.nombre;
    case 3:
      return Month.marzo.nombre;
    case 4:
      return Month.abril.nombre;
    case 5:
      return Month.mayo.nombre;
    case 6:
      return Month.junio.nombre;
    case 7:
      return Month.julio.nombre;
    case 8:
      return Month.agosto.nombre;
    case 9:
      return Month.septiembre.nombre;
    case 10:
      return Month.octubre.nombre;
    case 11:
      return Month.noviembre.nombre;
    case 12:
      return Month.diciembre.nombre;
    default:
      return '';
  }
}

String getDayTermination(int day) {
  switch (day) {
    case 1:
    case 21:
    case 31:
      return 'st';
    case 2:
    case 22:
      return 'nd';
    case 3:
    case 23:
      return 'td';
    default:
      return 'th';
  }
}
