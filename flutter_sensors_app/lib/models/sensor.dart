class SensorData {
  String timestamp;
  double value;

  SensorData({required this.timestamp, required this.value});

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'value': value,
    };
  }
}

class SensorBatch {
  String sensorId;
  String timestamp;
  List<SensorData> data;

  SensorBatch({required this.sensorId, required this.timestamp, required this.data});

  Map<String, dynamic> toJson() {
    return {
      'sensor_id': sensorId,
      'timestamp': timestamp,
      'data': data.map((d) => d.toJson()).toList(),
    };
  }
}
