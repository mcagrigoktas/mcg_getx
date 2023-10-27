import 'get_main.dart';

///VoidCallback from logs
typedef LogWriterCallback = void Function(String text, {bool isError});

/// default logger from GetX
void defaultLogWriterCallback(String value, {bool isError = false}) {
  // if (isError || Get.isLogEnable) developer.log(value, name: 'GETX');
  if (isError || Get.isLogEnable) print('GETX: $value');
}
