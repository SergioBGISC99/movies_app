import 'package:cinemapedia/config/enums/months.dart';
import 'package:cinemapedia/config/enums/weekdays.dart';

class Formatters {
  static DateTime now = DateTime.now();

  static String weekday = getWeekdayName(now.weekday);
  static String month = getMonthName(now.month);

  static String formattedDate = "$weekday, $month";
}

String getWeekdayName(int day) {
  switch (day) {
    case 0:
      return Weekday.domingo.nombre;
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
    default:
      return '';
  }
}

String getMonthName(int month) {
  switch (month) {
    case 0:
      return Month.enero.nombre;
    case 1:
      return Month.febrero.nombre;
    case 2:
      return Month.marzo.nombre;
    case 3:
      return Month.abril.nombre;
    case 4:
      return Month.mayo.nombre;
    case 5:
      return Month.junio.nombre;
    case 6:
      return Month.julio.nombre;
    case 7:
      return Month.agosto.nombre;
    case 8:
      return Month.septiembre.nombre;
    case 9:
      return Month.octubre.nombre;
    case 10:
      return Month.noviembre.nombre;
    case 11:
      return Month.diciembre.nombre;
    default:
      return '';
  }
}
