import 'package:flutter/material.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/page/simulator_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/bot_manager.dart';

void main() => runApp(
      ProviderScope(
        observers: [BotManager()],
        child: const McDonaldsBotSimulator(),
      ),
    );

class McDonaldsBotSimulator extends StatelessWidget {
  const McDonaldsBotSimulator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'McDonalds Bot Simulator',
      theme: ThemeData(
        colorSchemeSeed: Colors.amber,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const SimulatorPage(),
    );
  }
}
