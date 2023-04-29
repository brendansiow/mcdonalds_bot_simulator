import 'dart:async';

import 'package:mcdonalds_bot_simulator/simulator/domain/entity/order.dart';

enum BotStatus {
  idle('Idle'),
  processing('Processing');

  const BotStatus(this.display);
  final String display;
}

class Bot {
  final int id;
  BotStatus status;
  Order? order;
  Timer? timer;

  Bot({required this.id}) : status = BotStatus.idle;

  Bot.processing({
    required Bot bot,
    required Order this.order,
    required Timer this.timer,
  })  : id = bot.id,
        status = BotStatus.processing;

  Bot.idle({
    required Bot bot,
  })  : id = bot.id,
        status = BotStatus.idle,
        order = null,
        timer = null;
}
