import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

final List<Map<String, dynamic>> bmiRanges = [
  {'start': 14, 'end': 16, 'color': Colors.red, 'text': 'Severely underweight'},
  {'start': 16, 'end': 17, 'color': Colors.orange, 'text': 'Underweight'},
  {
    'start': 17,
    'end': 18.5,
    'color': Colors.yellow,
    'text': 'Mildly underweight'
  },
  {'start': 18.5, 'end': 25, 'color': Colors.green, 'text': 'Normal'},
  {'start': 25, 'end': 30, 'color': Colors.yellow, 'text': 'Overweight'},
  {'start': 30, 'end': 35, 'color': Colors.orange, 'text': 'Obese class I'},
  {'start': 35, 'end': 40, 'color': Colors.red, 'text': 'Obese class II'},
  {'start': 40, 'end': 45, 'color': Colors.red[900], 'text': 'Obese class III'},
];

class BmiChart extends StatelessWidget {
  final double bmi;

  const BmiChart({super.key, required this.bmi});

  String findBmiRangeIndex() {
    if (bmi < 14) return 'Severely underweight';
    if (bmi > 45) return 'Obese class III';
    return bmiRanges
        .firstWhere(
            (range) => range['start'] <= bmi && range['end'] > bmi)['text']
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 14,
              maximum: 45,
              startAngle: 180,
              endAngle: 360,
              ranges: <GaugeRange>[
                for (final range in bmiRanges)
                  GaugeRange(
                    startValue: range['start'].toDouble(),
                    endValue: range['end'].toDouble(),
                    color: range['color'],
                  ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: bmi,
                  needleColor: Colors.black,
                  needleLength: 0.7,
                  needleStartWidth: 1,
                  needleEndWidth: 3,
                  knobStyle: const KnobStyle(
                    color: Colors.black,
                    borderWidth: 0.015,
                    borderColor: Colors.grey,
                  ),
                ),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Column(children: [
                    Text(bmi.toString(),
                        style: const TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold)),
                    Text(
                      findBmiRangeIndex(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ]),
                  angle: 90,
                  positionFactor: 1.5,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
