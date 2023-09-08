import 'package:intl/intl.dart';

enum Month {
  enero,
  febrero,
  marzo,
  abril,
  mayo,
  junio,
  julio,
  agosto,
  septiembre,
  octubre,
  noviembre,
  diciembre
}

extension MonthExtension on Month {
  String get nombre {
    switch (this) {
      case Month.enero:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.febrero:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.marzo:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.abril:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.mayo:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.junio:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.julio:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.agosto:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.septiembre:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.octubre:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.noviembre:
        return DateFormat.MMMM().format(DateTime.now());
      case Month.diciembre:
        return DateFormat.MMMM().format(DateTime.now());
      default:
        return '';
    }
  }
}
