import 'package:xcash_app/data/model/global/meassage_model.dart';
import 'package:xcash_app/data/model/user/user.dart';

class QrCodeScanResponseModel {
  QrCodeScanResponseModel({
    String? remark,
    String? status,
    Message? message,
    Data? data,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
  }

  QrCodeScanResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    String? userType,
    User? userData,
  }) {
    _userType = userType;
    _userData = userData;
  }

  Data.fromJson(dynamic json) {
    _userType = json['user_type'];
    _userData = json['user_data'] != null ? User.fromJson(json['user_data']) : null;
  }
  String? _userType;
  User? _userData;

  String? get userType => _userType;
  User? get userData => _userData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_type'] = _userType;
    if (_userData != null) {
      map['user_data'] = _userData?.toJson();
    }
    return map;
  }
}
