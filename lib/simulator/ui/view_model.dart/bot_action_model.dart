import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcdonalds_bot_simulator/simulator/domain/entity/bot.dart';
import 'package:mcdonalds_bot_simulator/simulator/domain/entity/order.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/bot_list_model.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/order_action_model.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/order_list_model.dart';

final botActionProvider =
    Provider<BotActionModel>((ref) => BotActionModel(ref));

class BotActionModel {
  BotActionModel(this.ref);
  final ProviderRef ref;

  int get newId => ref.read(botListProvider).length + 1;

  addBot() {
    ref.read(botListProvider.notifier).addBot(Bot(id: newId));
  }

  removeBot() {
    if (ref.read(botListProvider).isNotEmpty) {
      Bot lastBot = ref.read(botListProvider).reduce((value, e) {
        int id = max(value.id, e.id);
        return value.id == id ? value : e;
      });
      if (lastBot.status == BotStatus.processing && lastBot.order != null) {
        ref.read(orderActionProvider).revertOrderBackToPending(lastBot.order!);
      }
      lastBot.timer?.cancel();
      ref.read(botListProvider.notifier).removeBot(lastBot.id);
    }
  }

  processOrder(Bot bot, Order order) {
    Bot updatedBot = Bot.processing(
      bot: bot,
      order: order,
      timer: getProcessOrderTimer(bot, order),
    );
    Order updatedOrder = Order.processing(order: order);
    ref
      ..read(botListProvider.notifier).updateBot(updatedBot)
      ..read(orderListProvider.notifier).updateOrder(updatedOrder);
  }

  getProcessOrderTimer(Bot bot, Order order) {
    return Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timer.tick < 10) {
          ref.read(botListProvider.notifier).notifyListeners();
        } else {
          timer.cancel();
          completeOrder(bot, order);
        }
      },
    );
  }

  completeOrder(Bot bot, Order order) {
    Bot updatedBot = Bot.idle(bot: bot);
    Order updatedOrder = Order.completed(order: order);
    ref
      ..read(botListProvider.notifier).updateBot(updatedBot)
      ..read(orderListProvider.notifier).updateOrder(updatedOrder);
  }
}
