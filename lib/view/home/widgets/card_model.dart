// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_pro_user/constants/image_paths.dart';

class CardModel {
  String url;
  String title;
  String duration;
  String serviceType;
  CardModel({
    required this.serviceType,
    required this.url,
    required this.title,
    required this.duration,
  });
}

List<CardModel> cardList = [
  CardModel(
    serviceType: "wash",
      url: Images.cardImageWash,
      title: "Wash & Fold",
      duration: "Min 15 Hours"),
  CardModel(
    serviceType: "dryClean",
      url: Images.cardImageDry,
      title: "Dry Cleaning",
      duration: "Min 15 Hours"),
  CardModel(
    serviceType: "iron",
      url: Images.cardImageIron,
      title: "Wash & Iron",
      duration: "Min 15 Hours"),
  CardModel(
    serviceType: "corprate",
    url: Images.cardImageCop, title: "Corprate", duration: ""),
];
