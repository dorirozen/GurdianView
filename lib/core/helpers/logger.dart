import 'package:logger/logger.dart';

/*
how to use :
final logger = MyLogger('MyHomePageState');
  logger.debug('debug');
  logger.info('info');
 */
class MyLogger {
  final String name;
  late final Logger _logger;
  MyLogger(this.name)
      : _logger = Logger(
          printer: MyLogPrinter(name),
        );
  void note(String message) {
    _logger.t(message);
  }

  void info(String message) {
    _logger.i(message);
  }

  void warning(String message) {
    _logger.w(message);
  }

  void debug(String message) {
    _logger.d(message);
  }

  void wtf(String message) {
    _logger.f(message);
  }

  void error(String message, [dynamic error]) {
    _logger.e(message, error: error, stackTrace: StackTrace.current);
  }
}

class MyLogPrinter extends LogPrinter {
  final String className;
  MyLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;
    return [color!('$emoji: $className: $message')];
  }
}
