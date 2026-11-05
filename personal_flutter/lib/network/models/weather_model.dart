class WeatherModel {
  // weather in city
  int? id;
  double? temperature_c;
  double? feels_like_c;
  int? humidity_percent;
  double? wind_speed_kmh;
  String? condition;
  String? observed_at;

  //weather url
  String? en;

  //search cities
  String? slug;
  String? name;

  WeatherModel({
    this.id,
    this.temperature_c,
    this.feels_like_c,
    this.humidity_percent,
    this.wind_speed_kmh,
    this.condition,
    this.observed_at,
    this.en,
    this.slug,
    this.name,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    temperature_c = (json['temperature_c'] as num?)?.toDouble();
    feels_like_c = (json['feels_like_c'] as num?)?.toDouble();
    humidity_percent = json['humidity_percent'];
    wind_speed_kmh = (json['wind_speed_kmh'] as num?)?.toDouble();
    condition = json['condition'];
    observed_at = json['observed_at'];
    en = json['en'];
    slug = json['slug'];
    name = json['name'];
  }
}
