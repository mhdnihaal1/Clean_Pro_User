import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/constants/app_sizes.dart';
import 'package:clean_pro_user/constants/image_paths.dart';
import 'package:clean_pro_user/view/auth/login_page.dart';
import 'package:clean_pro_user/view/home/widgets/card_model.dart';
import 'package:clean_pro_user/view/home/widgets/carosel_with_indicator.dart';
import 'package:clean_pro_user/view/home/widgets/services_card.dart';
import 'package:clean_pro_user/view/items/items_page.dart';
import 'package:clean_pro_user/model/order_model.dart';
import 'package:clean_pro_user/view/order/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScrenContent extends StatefulWidget {
  const HomeScrenContent({super.key});

  @override
  State<HomeScrenContent> createState() => _HomeScrenContentState();
}

class _HomeScrenContentState extends State<HomeScrenContent> {
  final List<Image> imags = [
    const Image(
      image: AssetImage(Images.caroselImage2),
      fit: BoxFit.fill,
    ),
    const Image(
      width: double.infinity,
      image: AssetImage(Images.caroselImage3),
      fit: BoxFit.fill,
    ),
    const Image(
      width: double.infinity,
      image: AssetImage(Images.caroselImage4),
      fit: BoxFit.fill,
    )
  ];

  // Define the orders list
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.backgroundWhite,
        backgroundColor: AppColors.backgroundWhite,
        title: const FittedBox(
          child: Row(
            children: [
              SizedBox(width: 19),
              AppTitle(fontSize: 10),
            ],
          ),
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel Section
            Container(
              width: double.infinity,
              height: 500.h,
              color: AppColors.backgroundWhite,
              child: CaroselWithIndicator(imags: imags),
            ),
            SizedBox(height: 40.h),
            // Services Section
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, left: 20),
                child: Text(
                  "Services",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textGrey,
                    fontFamily: AppFonts.montserrat,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 160,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.height54),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 120,
                    child: ServiceCard(
                      onTap: () => Get.to(
                        ItemsPage(service: cardList[index].serviceType),
                      ),
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Orders Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.height54),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Active Order (5)",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textGrey,
                      fontFamily: AppFonts.montserrat,
                    ),
                  ),
                  Text(
                    "Past Orders",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontFamily: AppFonts.montserrat,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  child: OrderLIstTile(
                    order: order,
                    Index: index,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
