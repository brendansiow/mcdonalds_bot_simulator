import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcdonalds_bot_simulator/simulator/domain/entity/order.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/view_model.dart/order_list_model.dart';

enum OrderList {
  pending('Pending Orders'),
  processing('Processing Orders'),
  completed('Completed Orders');

  const OrderList(this.title);
  final String title;
}

class OrderListDisplay extends ConsumerWidget {
  const OrderListDisplay({super.key});

  _getOrderList(WidgetRef ref, OrderList orderList) {
    switch (orderList) {
      case OrderList.pending:
        return ref.watch(pendingOrdersProvider);
      case OrderList.processing:
        return ref.watch(processingOrdersProvider);
      case OrderList.completed:
        return ref.watch(completedOrdersProvider);
    }
  }

  _buildOrderList(context, OrderList orderList, List<Order> orders) {
    return Expanded(
      child: Column(
        children: [
          Text(orderList.title),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                Order order = orders[index];
                return ListTile(
                  title: Text('${order.isVip ? 'VIP ' : ''}Order #${order.id}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(32),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Orders',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (OrderList orderList in OrderList.values)
                  _buildOrderList(
                      context, orderList, _getOrderList(ref, orderList)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
