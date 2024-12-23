import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/constants/app_fonts.dart';
import 'package:clean_pro_user/view/home/widgets/card_model.dart';
import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  const ServiceCard({
    required this.onTap,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 60,
                child: Image(image: AssetImage(cardList[index].url))),
            const SizedBox(
              height: 30,
            ),
            Text(
              cardList[index].title,
              style: const TextStyle(
                fontFamily: AppFonts.montserrat,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlack,
              ),
            ),
            Text(
              cardList[index].duration,
              style: const TextStyle(
                fontFamily: AppFonts.montserratLignt,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: AppColors.textGrey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
