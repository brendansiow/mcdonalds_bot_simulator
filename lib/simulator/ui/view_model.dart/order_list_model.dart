import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcdonalds_bot_simulator/simulator/domain/entity/order.dart';
import 'package:mcdonalds_bot_simulator/simulator/provider_const.dart';

final pendingOrdersProvider = Provider<List<Order>>((ref) {
  final orderList = ref.watch(orderListProvider);
  return orderList
      .where((order) => order.status == OrderStatus.pending)
      .toList()
    ..sort((a, b) {
      // both VIP orders or both normal orders;
      if (a.isVip == b.isVip) {
        return a.createdDate.compareTo(b.createdDate);
      }
      return a.isVip ? -1 : 1;
    });
});

final processingOrdersProvider = Provider<List<Order>>((ref) {
  final orderList = ref.watch(orderListProvider);
  return orderList
      .where((order) => order.status == OrderStatus.processing)
      .toList()
    ..sort((a, b) {
      if (a.processingDate == null || b.processingDate == null) return 0;
      return a.processingDate!.compareTo(b.processingDate!);
    });
});

final completedOrdersProvider = Provider<List<Order>>((ref) {
  final orderList = ref.watch(orderListProvider);
  return orderList
      .where((order) => order.status == OrderStatus.completed)
      .toList()
    ..sort((a, b) {
      if (a.completedDate == null || b.completedDate == null) return 0;
      return a.completedDate!.compareTo(b.completedDate!);
    });
});

final orderListProvider = StateNotifierProvider<OrderListModel, List<Order>>(
  (ref) => OrderListModel(),
  name: ProviderConst.orderListProvider,
);

class OrderListModel extends StateNotifier<List<Order>> {
  OrderListModel() : super([]);

  addOrder(Order order) {
    state = [...state, order];
  }

  updateOrder(Order order) {
    state = [...state.whereNot((e) => e.id == order.id), order];
  }
}
