import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:chefsandmeals_customer/src/common/colors.dart';
import 'package:chefsandmeals_customer/src/common/loading_dialog.dart';
import 'package:chefsandmeals_customer/src/common/utils.dart';
import 'package:chefsandmeals_customer/src/models/responses/get_all_sync_contact_response.dart';
import 'package:chefsandmeals_customer/src/modules/customerProfile/profile/referral/controller/referralController.dart';

class SingleContactRow extends StatelessWidget {
  const SingleContactRow({
    Key? key,
    required this.c,
    required this.controller,
  }) : super(key: key);
  final SnycContactResult c;
  final ReferalController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {},
        trailing: IconButton(
          onPressed: () async {
            Get.defaultDialog(
              title: "DELETE CONTACT",
              content: Text("Do you want to delete this Contact?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () async {
                      Get.back();
                      MyDialog.loadingDialog(context, "Deleting Contact");
                      final result = await controller.deleteContact(c.id!);
                      MyDialog.closeDialog(context);
                      if ((result)) {
                        Utils.showSnackBar(context, "Delete SuccessFul");
                      } else {
                        Utils.showSnackBar(context, "Unable to Delete");
                      }
                    },
                    child: Text("Delete")),
              ],
            );
          },
          icon: Icon(
            Icons.delete_forever,
            color: AppCustomColors.primaryColor,
          ),
        ),
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {},
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.brown.shade800,
            child: Text(
              "${c.firstName!.substring(0, 1)}",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(c.firstName ?? ""),
            SizedBox(
              height: 5,
            ),
            Text(c.mobile ?? ""),
            SizedBox(
              height: 10,
            ),
            !c.isReferred!
                ? InkWell(
                    onTap: () async {
                      MyDialog.loadingDialog(context, "Referring");
                      await controller.referSingleContract(c.id!);
                      MyDialog.closeDialog(context);
                    },
                    child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppCustomColors.primaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            )),
                        child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Refer now",
                                style: TextStyle(color: Colors.white),
                              ),
                            ))),
                  )
                : Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        )),
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Referred",
                            style: TextStyle(color: Colors.white),
                          ),
                        )))
          ],
        ),
        dense: false,
      ),
    );
  }
}
