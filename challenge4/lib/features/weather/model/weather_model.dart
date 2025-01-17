class WeatherModel {
  final String location;
  final double temperature;
  final String condition;
  final String iconCode;

  WeatherModel({
    required this.location,
    required this.temperature,
    required this.condition,
    required this.iconCode,
  });

  // 더미 데이터 생성을 위한 팩토리 메서드
  factory WeatherModel.dummy() {
    return WeatherModel(
      location: '서울',
      temperature: 23.5,
      condition: '맑음',
      iconCode: '01d',
    );
  }
} 