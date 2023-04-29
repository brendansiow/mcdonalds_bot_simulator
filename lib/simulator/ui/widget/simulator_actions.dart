import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/bot_action_model.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/order_action_model.dart';

class SimulatorActions extends ConsumerWidget {
  const SimulatorActions({super.key});

  _getButtonWrapList(List<Widget> widgets) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAction = ref.read(orderActionProvider);
    final botAction = ref.read(botActionProvider);
    return Card(
      margin: const EdgeInsets.all(32),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Actions',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            _getButtonWrapList(
              [
                FilledButton.icon(
                  onPressed: orderAction.addOrder,
                  icon: const Icon(Icons.inventory_outlined),
                  label: const Text('New Normal Order'),
                ),
                // const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: orderAction.addVipOrder,
                  icon: const Icon(Icons.business_center_sharp),
                  label: const Text('New VIP Order'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _getButtonWrapList(
              [
                FilledButton.tonalIcon(
                  onPressed: botAction.addBot,
                  icon: const Icon(Icons.person_add),
                  label: const Text('Bot'),
                ),
                FilledButton.tonalIcon(
                  onPressed: botAction.removeBot,
                  icon: const Icon(Icons.person_remove),
                  label: const Text('Bot'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
