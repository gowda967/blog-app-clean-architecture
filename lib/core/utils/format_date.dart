import 'package:intl/intl.dart';

String formatDateByDDMMYYYY(DateTime date) {
  return DateFormat("d MM,yyyy").format(date);
}
