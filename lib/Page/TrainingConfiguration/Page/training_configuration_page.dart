import 'package:Klasspadel/Page/TrainingConfiguration/Text/constant_text_training_config.dart';
import 'package:Klasspadel/Page/TrainingConfiguration/Widgets/body_training.dart';
import 'package:flutter/material.dart';

class TrainingConfigurationPage extends StatefulWidget {
  const TrainingConfigurationPage({super.key});

  @override
  State<TrainingConfigurationPage> createState() =>
      _TrainingConfigurationPageState();
}

class _TrainingConfigurationPageState extends State<TrainingConfigurationPage> {
  String _handPreference = 'Entrenadores disponibles';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Entrenamiento'),
      ),
      body: const BodyTrainig(),
    );
  }
}
