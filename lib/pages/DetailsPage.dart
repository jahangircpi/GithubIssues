import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:issuesgithub/auth/Controller/wholedetailslistscontroller.dart';

class DetailsPage extends StatelessWidget {
  final controller = Get.put(WholeDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("title"),
        ),
        body: Obx(() {
          try {
            if (controller.detailsdata.value == null) {
              return Center(child: Text("loading"));
            } else {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(controller.detailsdata.value.number.toString()),
                      Text(controller.detailsdata.value.title.toString()),
                      Text(controller.detailsdata.value.user.login.toString()),
                      InkWell(
                          onTap: () {
                            print(controller.detailsdata.value.createdAt
                                .toString()
                                .split(" ")[0]);
                          },
                          child: Text(controller.detailsdata.value.createdAt
                              .toString()
                              .split(" ")[0]
                              .toString())),
                      Text(controller.detailsdata.value.body.toString()),
                    ],
                  ),
                ),
              );
            }
          } catch (e) {
            return Center(
              child: Text("Loading"),
            );
          }
        }));
  }
}
