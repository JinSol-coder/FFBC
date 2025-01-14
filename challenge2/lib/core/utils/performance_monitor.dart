import 'package:flutter/foundation.dart';

class PerformanceMonitor {
  static final PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  PerformanceMonitor._internal();

  final Map<String, Stopwatch> _timers = {};

  void startTimer(String key) {
    if (!kReleaseMode) {
      _timers[key] = Stopwatch()..start();
    }
  }

  void endTimer(String key) {
    if (!kReleaseMode && _timers.containsKey(key)) {
      final elapsed = _timers[key]!.elapsed;
      debugPrint('Performance: $key took ${elapsed.inMilliseconds}ms');
      _timers[key]!.stop();
      _timers.remove(key);
    }
  }
} 