import 'package:charts_flutter/flutter.dart' as charts;

final monthFormatter =
    charts.BasicNumericTickFormatterSpec((num value) => _getMonth(value));

String _getMonth(num value) {
  switch (value) {
    case 1:
      return 'Jan';
      break;
    case 2:
      return 'Feb';
      break;
    case 3:
      return 'Mar';
      break;
    case 4:
      return 'Apr';
      break;
    case 5:
      return 'May';
      break;
    case 6:
      return 'June';
      break;
    case 7:
      return 'July';
      break;
    case 8:
      return 'Aug';
      break;
    case 9:
      return 'Sept';
      break;
    case 10:
      return 'Oct';
      break;
    case 11:
      return 'Nov';
      break;
    case 12:
      return 'Dec';
      break;
    default:
      return '';
  }
}
