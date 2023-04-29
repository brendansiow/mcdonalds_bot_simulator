import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcdonalds_bot_simulator/simulator/domain/entity/order.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/order_list_model.dart';

final orderActionProvider =
    Provider<OrderActionModel>((ref) => OrderActionModel(ref));

class OrderActionModel {
  OrderActionModel(this.ref);
  final ProviderRef ref;

  int get newId => ref.read(orderListProvider).length + 1;

  addOrder() {
    ref.read(orderListProvider.notifier).addOrder(Order(id: newId));
  }

  addVipOrder() {
    ref.read(orderListProvider.notifier).addOrder(Order.vip(id: newId));
  }

  revertOrderBackToPending(Order order) {
    Order updatedOrder = Order.revertToPending(order: order);
    ref.read(orderListProvider.notifier).updateOrder(updatedOrder);
  }
}
