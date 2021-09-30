import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:issuesgithub/auth/Model/DetailsModel.dart';
import 'package:issuesgithub/auth/Model/wholeDataModel.dart';
import 'package:issuesgithub/auth/Services/wholelistsService.dart';

class WholeDataController extends GetxController {
  var issuesList = List<WholeDataLists>().obs;
  var apicalled = ApiFetching();
  Rx<DetailsModel> detailsdata = DetailsModel().obs;
  var page = 1;
  var isDataProcessing = false.obs;
  var scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;
  @override
  void onInit() {
    super.onInit();
    getTask(page);
    paginateTask();
  }

  getTask(var page) {
    try {
      isMoreDataAvailable(false);
      isDataProcessing(true);
      apicalled.fetchdata(page: page).then((resp) {
        isDataProcessing(false);
        issuesList.addAll(resp);
      }, onError: (err) {
        isDataProcessing(false);

        showSnackBar("Error", err.toString(), Colors.red);
      });
    } catch (exception) {
      isDataProcessing(false);

      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }

  showSnackBar(String title, String message, Color backgroundColor) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white);
  }

  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("reached end");
        page++;
        getMoreTask(page);
      }
    });
  }

  void getMoreTask(var page) {
    try {
      ApiFetching().fetchdata(page: page).then((resp) {
        if (resp.length > 0) {
          isMoreDataAvailable(true);
        } else {
          isMoreDataAvailable(false);
          showSnackBar("Message", "No more items", Colors.lightBlueAccent);
        }
        issuesList.addAll(resp);
      }, onError: (err) {
        isMoreDataAvailable(false);

        showSnackBar("Error", err.toString(), Colors.red);
      });
    } catch (exception) {
      isMoreDataAvailable(false);

      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }

  refreshList() async {
    page = 1;
    getTask(page);
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
