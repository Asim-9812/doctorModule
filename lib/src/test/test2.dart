import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sensors/flutter_sensors.dart';

class Test2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Test2> {
  bool _accelAvailable = false;
  bool _gyroAvailable = false;
  List<double> _accelData = List.filled(3, 0.0);
  List<double> _gyroData = List.filled(3, 0.0);
  StreamSubscription? _accelSubscription;
  StreamSubscription? _gyroSubscription;
  int count = 0;
  int stepCount = 0;
  bool isInThreshold = false;
  Timer? _resetCountTimer;

  @override
  void initState() {
    _checkAccelerometerStatus();
    _checkGyroscopeStatus();
    _resetCountTimer?.cancel();
    super.initState();
  }

  @override
  void dispose() {
    _stopAccelerometer();
    _stopGyroscope();
    super.dispose();
  }

  void _checkAccelerometerStatus() async {
    await SensorManager()
        .isSensorAvailable(Sensors.ACCELEROMETER)
        .then((result) {
      setState(() {
        _accelAvailable = result;
      });
    });
  }

  Future<void> _startAccelerometer() async {
    final stepThreshold = 500; // Set the threshold for the step count
    final stepIncrement = 1; // Set the step increment value
    final timeThreshold = Duration(seconds: 1);
    if (_accelSubscription != null) return;
    if (_accelAvailable) {
      final stream = await SensorManager().sensorUpdates(
        sensorId: Sensors.ACCELEROMETER,
        interval: Sensors.SENSOR_DELAY_FASTEST,
      );
      _accelSubscription = stream.listen((sensorEvent) {
        setState(() {
          _accelData = sensorEvent.data;
          if (_accelData[0] >= 4.0 || _accelData[0] <= -4.0 || _accelData[2] >= 4.0 || _accelData[2] <= -4.0 ) {
            if (!isInThreshold) {
              // Start the timer when entering the threshold
              isInThreshold = true;
              _resetCountTimer?.cancel();
              _resetCountTimer = Timer(timeThreshold, () {
                // Reset the count after 1 second
                setState(() {
                  count = 0;
                  isInThreshold = false;
                });
              });
            }
          } else {
            isInThreshold = false;
            _resetCountTimer?.cancel();
          }

          if (isInThreshold) {
            count++;
            // Check if count reaches the threshold to increment the step count
            if (count >= stepThreshold) {
              stepCount += stepIncrement;
              count = 0; // Reset the count
            }
          }
        });
      });
    }
  }

  void _stopAccelerometer() {
    if (_accelSubscription == null) return;
    _accelSubscription?.cancel();
    _accelSubscription = null;
  }

  void _checkGyroscopeStatus() async {
    await SensorManager().isSensorAvailable(Sensors.GYROSCOPE).then((result) {
      setState(() {
        _gyroAvailable = result;
      });
    });
  }

  Future<void> _startGyroscope() async {
    if (_gyroSubscription != null) return;
    if (_gyroAvailable) {
      final stream =
      await SensorManager().sensorUpdates(sensorId: Sensors.GYROSCOPE);
      _gyroSubscription = stream.listen((sensorEvent) {
        setState(() {
          _gyroData = sensorEvent.data;
        });
      });
    }
  }

  void _stopGyroscope() {
    if (_gyroSubscription == null) return;
    _gyroSubscription?.cancel();
    _gyroSubscription = null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Sensors Example'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          alignment: AlignmentDirectional.topCenter,
          child: Column(
            children: <Widget>[
              Text(
                "Accelerometer Test",
                textAlign: TextAlign.center,
              ),
              Text(
                "Accelerometer Enabled: $_accelAvailable",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[0](X) = ${_accelData[0]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[1](Y) = ${_accelData[1]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[2](Z) = ${_accelData[2]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    child: Text("Start"),
                    color: Colors.green,
                    onPressed:
                    _accelAvailable ? () => _startAccelerometer() : null,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  MaterialButton(
                    child: Text("Stop"),
                    color: Colors.red,
                    onPressed:
                    _accelAvailable ? () => _stopAccelerometer() : null,
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "Gyroscope Test",
                textAlign: TextAlign.center,
              ),
              Text(
                "Gyroscope Enabled: $_gyroAvailable",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[0](X) = ${_gyroData[0]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[1](Y) = ${_gyroData[1]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Text(
                "[2](Z) = ${_gyroData[2]}",
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.only(top: 16.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    child: Text("Start"),
                    color: Colors.green,
                    onPressed: _gyroAvailable ? () => _startGyroscope() : null,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  MaterialButton(
                    child: Text("Stop"),
                    color: Colors.red,
                    onPressed: _gyroAvailable ? () => _stopGyroscope() : null,
                  ),


                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // ... (existing code)

                  Padding(padding: EdgeInsets.only(top: 16.0)),
                  Text(
                    "Count: $count",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16.0)),
                  Text(
                    "Step Count: $stepCount",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}