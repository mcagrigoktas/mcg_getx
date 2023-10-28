import '../../instance_manager.dart';

///VoidCallback from logs
typedef LogWriterCallback = void Function(String text, {bool isError});

void defaultLogWriterCallback(String value, {bool isError = false}) {
  if (isError || GetConst.isLogEnable) print('GETX: $value');
}
