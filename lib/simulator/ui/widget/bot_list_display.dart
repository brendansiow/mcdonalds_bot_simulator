import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcdonalds_bot_simulator/simulator/domain/entity/bot.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/bot_list_model.dart';

class BotListDisplay extends ConsumerWidget {
  const BotListDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final botList = ref.watch(botListSortedProvider);
    return Card(
      margin: const EdgeInsets.all(32),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Bot',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: botList.length,
                itemBuilder: (context, index) {
                  Bot bot = botList[index];
                  return ListTile(
                    title: Text('Bot #${bot.id}'),
                    subtitle: bot.status == BotStatus.processing
                        ? Text(
                            '${bot.status.display} - Order #${bot.order?.id ?? ''} (${10 - (bot.timer?.tick ?? 0)} sec remaining)')
                        : Text(bot.status.display),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
