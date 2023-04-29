import 'package:flutter/material.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/widget/bot_list_display.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/widget/simulator_actions.dart';
import 'package:mcdonalds_bot_simulator/simulator/ui/widget/order_list_display.dart';

class SimulatorPage extends StatelessWidget {
  const SimulatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('McDonalds Bot Simulator'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                const SimulatorActions(),
                if (MediaQuery.of(context).size.width > 900)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(flex: 3, child: OrderListDisplay()),
                      Expanded(flex: 2, child: BotListDisplay()),
                    ],
                  )
                else ...{
                  const OrderListDisplay(),
                  const BotListDisplay(),
                }
              ],
            ),
          )
        ],
      ),
    );
  }
}
