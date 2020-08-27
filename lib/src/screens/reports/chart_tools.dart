import 'package:charts_flutter/flutter.dart' as charts;

final monthFormatter = charts.BasicNumericTickFormatterSpec(
    (num value) => _getAbbreviatedMonth(value));

String _getAbbreviatedMonth(num value) {
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

String getMonth(num value) {
  switch (value) {
    case 1:
      return 'January';
      break;
    case 2:
      return 'February';
      break;
    case 3:
      return 'March';
      break;
    case 4:
      return 'April';
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
      return 'August';
      break;
    case 9:
      return 'September';
      break;
    case 10:
      return 'October';
      break;
    case 11:
      return 'November';
      break;
    case 12:
      return 'December';
      break;
    default:
      return '';
  }
}
