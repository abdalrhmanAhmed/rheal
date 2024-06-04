class RefreshTokenModel {
  late String? newToken;
  RefreshTokenModel();
  RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    newToken = json['access_token'];
  }
}
