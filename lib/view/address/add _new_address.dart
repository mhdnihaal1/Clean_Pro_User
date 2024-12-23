import 'package:clean_pro_user/controller/address_conroller.dart';
import 'package:clean_pro_user/model/cart_model.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_elevated_button.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_elevated_button_with_border.dart';
import 'package:clean_pro_user/view/shared/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressPage extends StatefulWidget {
  AddAddressPage({
    super.key,
    this.isEdit,
    this.city,
    this.id,
    this.state,
    this.street,
    this.postalCode
  });

  String? street;
  String? city;
  String? state;
  String? postalCode;

  String? id;
  bool? isEdit;
  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController buildingnameController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit != null && widget.isEdit == true) {
      buildingnameController.text = widget.street!;
      streetAddressController.text = widget.city!;
      zipCodeController.text = widget.postalCode??"23489";
      cityController.text = widget.city!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit != null && widget.isEdit == true
              ? "Edit Address"
              : "Add New Address",
          style: AppTextStyles.titleTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            CustomTextFeild(
              controller: buildingnameController,
              labelText: "Building Name",
              hintText: "Enter building name and number",
              prefix: Icons.business,
            ),
            const SizedBox(height: 16),
            CustomTextFeild(
              controller: streetAddressController,
              labelText: "Street Address",
              hintText: "Enter street address",
              prefix: Icons.streetview,
            ),
            const SizedBox(height: 16),
            CustomTextFeild(
              controller: zipCodeController,
              labelText: "ZIP Code",
              hintText: "Enter ZIP code",
              prefix: Icons.local_post_office,
            ),
            const SizedBox(height: 16),
            CustomTextFeild(
              controller: cityController,
              labelText: "City",
              hintText: "Enter city name",
              prefix: Icons.location_city,
            ),
            const SizedBox(height: 24),
            CustomElevatedButtonWithBorder(
                onPressed: () {}, buttonText: "Select Address from Location"),
            const SizedBox(height: 24),
            CustomElevatedButton(
                onPressed: () {
                  AddressController addressController = AddressController();
                  if (widget.isEdit != null && widget.isEdit == true) {
                    addressController.editAddress(
                        streetAddressController.text,
                        cityController.text,
                        streetAddressController.text,
                        zipCodeController.text,
                        [53, 23],
                        widget.id!);
                  } else {
                    addressController.addAddress(
                        streetAddressController.text,
                        cityController.text,
                        streetAddressController.text,
                        zipCodeController.text,
                        );
                  }
                },
                buttonText: "Save Address"),
          ],
        ),
      ),
    );
  }
}
