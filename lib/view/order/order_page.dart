import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/model/order_model.dart';
import 'package:clean_pro_user/view/order/order_detail_page.dart';
import 'package:clean_pro_user/view/order/order_progress_icon.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersList extends StatelessWidget {
  final List<Order> orders = [
    Order(
        number: '22145052',
        status: 'Order Confirmed',
        amount: 256,
        date: '25 June, 2018'),
    Order(
        number: '22145052',
        status: 'Order Picked up',
        amount: 256,
        date: '25 June, 2018'),
    Order(
        number: '22145052',
        status: 'Order Inprocess',
        amount: 256,
        date: '25 June, 2018'),
    Order(
        number: '22145052',
        status: 'Order Dispatched',
        amount: 256,
        date: '25 June, 2018'),
    Order(
        number: '22145052',
        status: 'Order Delivered',
        amount: 256,
        date: '25 June, 2018'),
  ];

  OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Orders",
          style: AppTextStyles.titleTextStyle,
        ),
      ),
      body: Card(
        color: AppColors.backgroundGrey,
        child: ListView.separated(
          itemCount: orders.length,
          separatorBuilder: (context, index) =>
              const Divider(height: 5, color: AppColors.backgroundWhite),
          itemBuilder: (context, index) {
            final order = orders[index];
            return GestureDetector(
                onTap: () {
                  Get.to(OrderDetailPage(
                      order: Order(
                    number: 'ORD-001',
                    date: '2023-05-20',
                    status: 'Order Confirmed',
                    amount: 150.00,
                  )));
                },
                child: OrderLIstTile(order: order, Index: index));
          },
        ),
      ),
    );
  }
}

class OrderLIstTile extends StatelessWidget {
  const OrderLIstTile({
    required this.Index,
    super.key,
    required this.order,
  });
  final int Index;
  final Order order;

  @override
  Widget build(BuildContext context) {
    int a = 1;
    return Container(
      height: 85,
      color: AppColors.backgroundWhite,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProgressIndicatorButton(
              step: a + Index,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order No: ${order.number}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.montserrat,
                          fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(order.status,
                      style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontFamily: AppFonts.montserrat,
                          fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${order.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.montserrat)),
                const SizedBox(height: 8),
                Text(order.date,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontFamily: AppFonts.montserrat)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
