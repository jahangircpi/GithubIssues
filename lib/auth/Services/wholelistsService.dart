import 'package:http/http.dart' as http;
import 'package:issuesgithub/auth/Model/DetailsModel.dart';
import 'package:issuesgithub/auth/Model/wholeDataModel.dart';

class ApiFetching {
  fetchdata({page}) async {
    var link = "https://api.github.com/repos/flutter/flutter/issues?page=$page";
    var response = await http.get(link);
    if (response.statusCode == 200) {
      return wholeDataListsFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  fetchdata2({number}) async {
    var link = "https://api.github.com/repos/flutter/flutter/issues/$number";
    var response = await http.get(link);
    return detailsModelFromJson(response.body);
  }
}
