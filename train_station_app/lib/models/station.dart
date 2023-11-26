import 'package:hive_flutter/hive_flutter.dart';

part 'station.g.dart';

@HiveType(typeId: 0)
class Station {
  @HiveField(0)
  String? code;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? city;

  @HiveField(3)
  String? cityname;

  Station({this.code, this.name, this.city, this.cityname});

  Station.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    city = json['city'];
    cityname = json['cityname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['city'] = this.city;
    data['cityname'] = this.cityname;
    return data;
  }
}
