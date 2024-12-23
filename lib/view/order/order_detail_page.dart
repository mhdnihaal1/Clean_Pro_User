import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/model/order_model.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.backgroundWhite,
        title: const Text(
          "Order Details",
          style: AppTextStyles.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderProgressSection(order: order),
            OrderSummarySection(order: order),
            const ItemsSection(),
            const DeliveryAgentSection(),
          ],
        ),
      ),
    );
  }
}

class OrderProgressSection extends StatelessWidget {
  final Order order;

  const OrderProgressSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundWhite,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Progress',
            style: AppTextStyles.titleTextStyle,
          ),
          const SizedBox(height: 16),
          OrderStepper(currentStep: _getOrderStep(order.status)),
        ],
      ),
    );
  }

  int _getOrderStep(String status) {
    switch (status) {
      case 'Order Confirmed':
        return 0;
      case 'Order Picked up':
        return 1;
      case 'Order Inprocess':
        return 2;
      case 'Order Dispatched':
        return 3;
      case 'Order Delivered':
        return 4;
      default:
        return 0;
    }
  }
}

class OrderStepper extends StatelessWidget {
  final int currentStep;

  const OrderStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Stepper(
      connectorColor: const WidgetStatePropertyAll(AppColors.actionBlue),
      currentStep: currentStep,
      controlsBuilder: (context, details) {
        return Container();
      },
      steps: [
        _buildStep('Order Confirmed', 'Your order has been confirmed', 0),
        _buildStep('Order Picked up', 'Your order has been picked up', 1),
        _buildStep('Order In Process', 'Your order is being processed', 2),
        _buildStep('Order Dispatched', 'Your order has been dispatched', 3),
        _buildStep('Order Delivered', 'Your order has been delivered', 4),
      ],
    );
  }

  Step _buildStep(String title, String content, int index) {
    return Step(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color:
              currentStep >= index ? AppColors.primaryBlue : AppColors.textGrey,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontFamily: AppFonts.montserrat,
          fontSize: 12,
          color: AppColors.textGrey,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      isActive: currentStep >= index,
      state: currentStep > index ? StepState.complete : StepState.indexed,
    );
  }
}

class OrderSummarySection extends StatelessWidget {
  final Order order;

  const OrderSummarySection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundWhite,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: AppTextStyles.titleTextStyle,
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Order Number', order.number),
          _buildSummaryRow('Order Date', order.date),
          _buildSummaryRow('Order Status', order.status),
          _buildSummaryRow(
              'Order Amount', '\$ ${order.amount.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: AppFonts.montserrat,
                fontSize: 14,
                color: AppColors.textGrey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: AppFonts.montserrat,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemsSection extends StatelessWidget {
  const ItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for items
    final List<Map<String, dynamic>> items = [
      {'name': 'T-Shirt', 'quantity': 2, 'price': 25.99},
      {'name': 'Jeans', 'quantity': 1, 'price': 49.99},
      {'name': 'Sneakers', 'quantity': 1, 'price': 79.99},
    ];

    double totalAmount = items.fold(
        0,
        (sum, item) =>
            sum + (item['quantity'] as int) * (item['price'] as double));

    return Container(
      color: AppColors.backgroundWhite,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Items',
            style: AppTextStyles.titleTextStyle,
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        item['name'],
                        style: const TextStyle(
                          fontFamily: AppFonts.montserrat,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        'x${item['quantity']}',
                        style: const TextStyle(
                          fontFamily: AppFonts.montserrat,
                          fontSize: 14,
                          color: AppColors.textGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '\$  ${item['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontFamily: AppFonts.montserrat,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primaryBlue,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(thickness: 1, color: AppColors.textGrey),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '\$ ${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontFamily: AppFonts.montserrat,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeliveryAgentSection extends StatelessWidget {
  const DeliveryAgentSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for delivery agent
    final Map<String, String> agent = {
      'name': 'John Doe',
      'phone': '+1 234 567 8900',
    };

    return Container(
      color: AppColors.backgroundWhite,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Agent Details',
            style: AppTextStyles.titleTextStyle,
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryBlue,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                        radius: 30,
                        child: Text(
                          agent['name']!.substring(0, 2).toUpperCase(),
                          style: const TextStyle(
                            fontFamily: AppFonts.montserrat,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            agent['name']!,
                            style: const TextStyle(
                              fontFamily: AppFonts.montserrat,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: agent['phone']!));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Phone number copied to clipboard'),
                                  backgroundColor: AppColors.primaryBlue,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              agent['phone']!,
                              style: const TextStyle(
                                fontFamily: AppFonts.montserrat,
                                fontSize: 14,
                                color: AppColors.textGrey,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final Uri url = Uri(
                        scheme: 'tel',
                        path: agent['phone'],
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Could not launch phone call'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.phone, size: 20),
                    label: const Text('Call Delivery Agent'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
