import 'package:logger/logger.dart';

class JLogger {
  static final logger = Logger(printer: PrettyPrinter(
      stackTraceBeginIndex: 1
  ), level: Level.debug);

  static void d(String msg) {
    logger.d(msg);
  }
}
