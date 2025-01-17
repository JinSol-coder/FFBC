import 'package:flutter/foundation.dart';
import '../model/weather_model.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherModel? _weather;
  bool _isLoading = false;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather() async {
    _isLoading = true;
    notifyListeners();

    // 더미 데이터 사용
    await Future.delayed(const Duration(seconds: 1));
    _weather = WeatherModel.dummy();
    
    _isLoading = false;
    notifyListeners();
  }
} 