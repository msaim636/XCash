import 'package:xcash_app/data/model/auth/login/login_response_model.dart';
import 'package:xcash_app/data/model/user/user.dart';

class CheckUserResponseModel {
  CheckUserResponseModel({
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

  CheckUserResponseModel.fromJson(dynamic json) {
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
    User? agent,
  }) {
    _agent = agent;
  }

  Data.fromJson(dynamic json) {
    _agent = json['agent'] != null ? User.fromJson(json['agent']) : null;
  }
  User? _agent;

  User? get agent => _agent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_agent != null) {
      map['agent'] = _agent?.toJson();
    }
    return map;
  }
}
