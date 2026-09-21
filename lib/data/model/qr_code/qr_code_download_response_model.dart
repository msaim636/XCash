// class QrCodeDownloadResponseModel {
//   QrCodeDownloadResponseModel({
//       String? remark, 
//       String? status, 
//       Data? data,}){
//     _remark = remark;
//     _status = status;
//     _data   = data;
// }

//   QrCodeDownloadResponseModel.fromJson(dynamic json) {
//     _remark = json['remark'];
//     _status = json['status'];
//     _data   = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//   String? _remark;
//   String? _status;
//   Data? _data;

//   String? get remark => _remark;
//   String? get status => _status;
//   Data?   get data   => _data;

//   Map<String, dynamic> toJson() {
//     final map       = <String, dynamic>{};
//     map  ['remark'] = _remark;
//     map  ['status'] = _status;
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     return map;
//   }

// }

// class Data {
//   Data({
//       String? downloadLink, 
//       String? downloadFileName,}){
//     _downloadLink     = downloadLink;
//     _downloadFileName = downloadFileName;
// }

//   Data.fromJson(dynamic json) {
//     _downloadLink     = json['download_link'];
//     _downloadFileName = json['download_file_name'];
//   }
//   String? _downloadLink;
//   String? _downloadFileName;

//   String? get downloadLink     => _downloadLink;
//   String? get downloadFileName => _downloadFileName;

//   Map<String, dynamic> toJson() {
//     final map                   = <String, dynamic>{};
//     map  ['download_link']      = _downloadLink;
//     map  ['download_file_name'] = _downloadFileName;
//     return map;
//   }

// }


// To parse this JSON data, do
//
//     final qrCodeDownloadResponseModel = qrCodeDownloadResponseModelFromJson(jsonString);

import 'dart:convert';

QrCodeDownloadResponseModel qrCodeDownloadResponseModelFromJson(String str) => QrCodeDownloadResponseModel.fromJson(json.decode(str));

String qrCodeDownloadResponseModelToJson(QrCodeDownloadResponseModel data) => json.encode(data.toJson());

class QrCodeDownloadResponseModel {
    String? remark;
    String? status;
    Data? data;

    QrCodeDownloadResponseModel({
        this.remark,
        this.status,
        this.data,
    });

    factory QrCodeDownloadResponseModel.fromJson(Map<String, dynamic> json) => QrCodeDownloadResponseModel(
        remark: json["remark"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    Image? image;

    Data({
        this.image,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
    );

    Map<String, dynamic> toJson() => {
        "image": image?.toJson(),
    };
}

class Image {
    Image();

    factory Image.fromJson(Map<String, dynamic> json) => Image(
    );

    Map<String, dynamic> toJson() => {
    };
}
