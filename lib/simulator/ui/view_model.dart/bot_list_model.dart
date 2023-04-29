import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcdonalds_bot_simulator/simulator/domain/entity/bot.dart';
import 'package:mcdonalds_bot_simulator/simulator/provider_const.dart';

final botListSortedProvider = Provider<List<Bot>>((ref) {
  final botList = ref.watch(botListProvider);
  return botList..sort((a, b) => a.id.compareTo(b.id));
});

final botListProvider = StateNotifierProvider<BotListModel, List<Bot>>(
  (ref) => BotListModel(),
  name: ProviderConst.botListProvider,
);

class BotListModel extends StateNotifier<List<Bot>> {
  BotListModel() : super([]);

  getBotById(int id) {
    return state.firstWhereOrNull((e) => e.id == id);
  }

  addBot(Bot bot) {
    state = [...state, bot];
  }

  removeBot(int botId) {
    state = state.where((e) => e.id != botId).toList();
  }

  updateBot(Bot bot) {
    state = [...state.whereNot((e) => e.id == bot.id), bot];
  }

  notifyListeners() {
    state = state.toList();
  }
}
