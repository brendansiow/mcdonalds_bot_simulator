import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcdonalds_bot_simulator/simulator/domain/entity/bot.dart';
import 'package:mcdonalds_bot_simulator/simulator/domain/entity/order.dart';
import 'package:mcdonalds_bot_simulator/simulator/provider_const.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/bot_action_model.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/bot_list_model.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/order_list_model.dart';

class BotManager extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (provider.name == ProviderConst.orderListProvider ||
        provider.name == ProviderConst.botListProvider) {
      assignOrder(container);
    }
  }

  assignOrder(ProviderContainer container) async {
    final botList = container.read(botListProvider);
    final pendingOrderList = container.read(pendingOrdersProvider);
    final Bot? bot =
        botList.firstWhereOrNull((e) => e.status == BotStatus.idle);
    final Order? order = pendingOrderList.firstOrNull;

    //prevent race condition where bot updated but order not yet updated
    // in short, the order is held by other bot already
    if (botList.any((e) => e.order?.id == order?.id)) return;
    if (bot != null && order != null) {
      container.read(botActionProvider).processOrder(bot, order);
    }
  }
}
