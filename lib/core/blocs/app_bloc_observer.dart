import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    _logger.i('🟢 Bloc Created: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    _logger.d([
      '🎯 ${bloc.runtimeType} Event: ${event.runtimeType}',
      'Details: ${_redact(event.toString())}'
    ]);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _logger.t([
      '🔄 ${bloc.runtimeType} State Update',
      'FROM: ${_redact(change.currentState.toString())}',
      'TO:   ${_redact(change.nextState.toString())}'
    ]);
  }

  // @override
  // void onTransition(
  //     Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
  //   super.onTransition(bloc, transition);
  //   _logger.t([
  //     '⏩ ${bloc.runtimeType} Transition: ${transition.event.runtimeType}',
  //     // 'Duration: ${transition.duration?.inMilliseconds}ms',
  //     'Sequence: ${_redact(transition.currentState.toString())} → ${_redact(transition.nextState.toString())}'
  //   ]);
  // }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _logger.e('⛔ ${bloc.runtimeType} Error',
        error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    _logger.w('🔴 Bloc Closed: ${bloc.runtimeType}');
    super.onClose(bloc);
  }

  String _redact(String input) {
    return input
        .replaceAll(RegExp(r'(password|token):\s*\S+'), r'$1: [REDACTED]')
        .replaceAll(RegExp(r'\d{4}-\d{4}-\d{4}-\d{4}'), '[CREDIT_CARD]');
  }
}
