import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:issuesgithub/auth/Controller/wholedetailslistscontroller.dart';
import 'package:issuesgithub/auth/Services/wholelistsService.dart';
import 'package:issuesgithub/pages/DetailsPage.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(WholeDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(child: Obx(() {
          if (controller.isDataProcessing.value == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (controller.issuesList.length > 0) {
              return ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.issuesList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == controller.issuesList.length - 1 &&
                      controller.isMoreDataAvailable.value == true) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        print(controller.issuesList.length);
                        Get.dialog(Dialog(
                          child: Container(
                            height: 400,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ));
                        ApiFetching()
                            .fetchdata2(
                                number: controller.issuesList[index].number)
                            .then((value) {
                          controller.detailsdata.value = value;
                          Get.back();
                          Get.to(DetailsPage());
                        });
                      },
                      child: Column(
                        children: [
                          Text((index + 1).toString()),
                          Text(controller.issuesList[index].number.toString()),
                          Text(controller.issuesList[index].title.toString()),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text("Data not Found");
            }
          }
        })));
  }
}

//
