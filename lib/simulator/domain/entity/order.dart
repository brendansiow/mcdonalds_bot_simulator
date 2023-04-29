enum OrderStatus { pending, processing, completed }

class Order {
  final int id;
  final bool isVip;
  OrderStatus status;
  DateTime createdDate;
  DateTime? processingDate;
  DateTime? completedDate;

  Order({required this.id})
      : isVip = false,
        status = OrderStatus.pending,
        createdDate = DateTime.now();

  Order.vip({required this.id})
      : isVip = true,
        status = OrderStatus.pending,
        createdDate = DateTime.now();

  Order.processing({required Order order})
      : id = order.id,
        isVip = order.isVip,
        status = OrderStatus.processing,
        createdDate = order.createdDate,
        processingDate = DateTime.now();

  Order.completed({required Order order})
      : id = order.id,
        isVip = order.isVip,
        status = OrderStatus.completed,
        createdDate = order.createdDate,
        processingDate = order.processingDate,
        completedDate = DateTime.now();

  Order.revertToPending({required Order order})
      : id = order.id,
        isVip = order.isVip,
        status = OrderStatus.pending,
        createdDate = order.createdDate,
        processingDate = null;
}
