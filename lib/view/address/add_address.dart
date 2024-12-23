import 'package:clean_pro_user/constants/app_colors.dart';
import 'package:clean_pro_user/controller/profile_controller.dart';
import 'package:clean_pro_user/view/address/add%20_new_address.dart';
import 'package:clean_pro_user/view/order/order_summary_page.dart';
import 'package:clean_pro_user/view/shared/styles/text_styles/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/profile_model.dart' as pmodel;

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  ProfileController profileController = Get.find<ProfileController>();
  int? _selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        surfaceTintColor: AppColors.backgroundGrey,
        backgroundColor: AppColors.backgroundGrey,
        title: const Text(
          "Select Address",
          style: AppTextStyles.titleTextStyle,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: Obx(
                    () {
                      var data =
                          profileController.profileModel.value!.data.addresses;
                      return ListView.builder(
                        itemCount: data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == data.length) {
                            return _buildAddNewAddressTile();
                          }
                          return _buildAddressTile(index,
                              profileController.profileModel.value!.data);
                        },
                      );
                    },
                  ),
                ),
                _buildNextButton(constraints),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddressTile(int index, pmodel.ProfileData data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: RadioListTile(
        value: index,
        groupValue: _selectedAddress,
        onChanged: (value) {
          setState(() {
            _selectedAddress = value;
          });
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                data.addresses[index].street,
                style: AppTextStyles.normalTextStyle
                    .copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: AppColors.actionBlue),
              onSelected: (String result) {
                if (result == 'edit') {
                  Get.to(AddAddressPage(
                    isEdit: true,
                    city: data.addresses[index].city,
                    id: data.addresses[index].id,
                    state: data.addresses[index].state,
                    street: data.addresses[index].street,
                    postalCode: data.addresses[index].postalCode,
                  ));
                } else if (result == 'delete') {
                  _showDeleteConfirmationDialog(index);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${data.addresses[index].city}, ${data.addresses[index].state}',
              style: AppTextStyles.normalTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              data.addresses[index].postalCode,
              style: AppTextStyles.normalTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        activeColor: AppColors.actionBlue,
      ),
    );
  }

  void _showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Address',
            style: AppTextStyles.normalTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this address?',
            style: AppTextStyles.normalTextStyle,
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: AppTextStyles.normalTextStyle.copyWith(
                  color: AppColors.actionBlue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.actionBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // TODO: Implement delete functionality
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: AppTextStyles.normalTextStyle.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddNewAddressTile() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: const Icon(
          Icons.add_circle,
          color: AppColors.actionBlue,
        ),
        title: Text(
          "Add new address",
          style: AppTextStyles.normalTextStyle
              .copyWith(color: AppColors.actionBlue),
        ),
        onTap: () {
          Get.to(AddAddressPage());
        },
      ),
    );
  }

  Widget _buildNextButton(BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: constraints.maxWidth,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: AppColors.actionBlue,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: _selectedAddress != null
              ? () {
                  if (_selectedAddress != null) {
                    Get.to(OrderSummaryPage(
                      address: profileController.profileModel.value!.data
                          .addresses[_selectedAddress!],
                    ));
                  }
                }
              : null,
          child: Text(
            "Next",
            style: AppTextStyles.normalTextStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
