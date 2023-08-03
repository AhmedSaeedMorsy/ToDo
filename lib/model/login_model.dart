class LoginModel {
  DataModel dataModel = DataModel();
  LoginModel();
  LoginModel.fromJson(Map<String, dynamic> json) {
    dataModel = DataModel.fromJson(json["data"]);
  }
}

class DataModel {
  late String token;
  DataModel();
  DataModel.fromJson(Map<String, dynamic> json) {
    token = json["token"];
  }
}
