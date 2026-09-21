// To parse this JSON data, do
//
//     final homeResponseModel = homeResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:xcash_app/data/model/user/user.dart';

import '../global/meassage_model.dart';

HomeResponseModel homeResponseModelFromJson(String str) => HomeResponseModel.fromJson(json.decode(str));

String homeResponseModelToJson(HomeResponseModel data) => json.encode(data.toJson());

class HomeResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  HomeResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) => HomeResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  User? user;
  List<Wallet>? wallets;
  List<LatestTrx>? latestTrx;
  Last7DayMoneyInOut? last7DayMoneyInOut;
  String? totalSiteBalance;

  Data({
    this.user,
    this.wallets,
    this.latestTrx,
    this.last7DayMoneyInOut,
    this.totalSiteBalance,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        wallets: json["wallets"] == null ? [] : List<Wallet>.from(json["wallets"]!.map((x) => Wallet.fromJson(x))),
        latestTrx: json["latest_trx"] == null ? [] : List<LatestTrx>.from(json["latest_trx"]!.map((x) => LatestTrx.fromJson(x))),
        last7DayMoneyInOut: json["last_7_day_money_in_out"] == null ? null : Last7DayMoneyInOut.fromJson(json["last_7_day_money_in_out"]),
        totalSiteBalance: json["total_site_balance"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "wallets": wallets == null ? [] : List<dynamic>.from(wallets!.map((x) => x.toJson())),
        "latest_trx": latestTrx == null ? [] : List<dynamic>.from(latestTrx!.map((x) => x.toJson())),
        "last_7_day_money_in_out": last7DayMoneyInOut?.toJson(),
        "total_site_balance": totalSiteBalance,
      };
}

class Last7DayMoneyInOut {
  String? totalMoneyIn;
  String? totalMoneyOut;

  Last7DayMoneyInOut({
    this.totalMoneyIn,
    this.totalMoneyOut,
  });

  factory Last7DayMoneyInOut.fromJson(Map<String, dynamic> json) => Last7DayMoneyInOut(
        totalMoneyIn: json["totalMoneyIn"].toString(),
        totalMoneyOut: json["totalMoneyOut"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "totalMoneyIn": totalMoneyIn,
        "totalMoneyOut": totalMoneyOut,
      };
}

class LatestTrx {
  int? id;
  String? userId;
  String? userType;
  dynamic receiverId;
  dynamic receiverType;
  String? currencyId;
  String? walletId;
  String? beforeCharge;
  String? amount;
  String? charge;
  String? postBalance;
  String? trxType;
  dynamic chargeType;
  String? trx;
  String? details;
  String? remark;
  String? createdAt;
  String? updatedAt;
  String? apiDetails;
  Currency? currency;
  dynamic receiverUser;
  dynamic receiverAgent;
  dynamic receiverMerchant;

  LatestTrx({
    this.id,
    this.userId,
    this.userType,
    this.receiverId,
    this.receiverType,
    this.currencyId,
    this.walletId,
    this.beforeCharge,
    this.amount,
    this.charge,
    this.postBalance,
    this.trxType,
    this.chargeType,
    this.trx,
    this.details,
    this.remark,
    this.createdAt,
    this.updatedAt,
    this.apiDetails,
    this.currency,
    this.receiverUser,
    this.receiverAgent,
    this.receiverMerchant,
  });

  factory LatestTrx.fromJson(Map<String, dynamic> json) => LatestTrx(
        id: json["id"],
        userId: json["user_id"].toString(),
        userType: json["user_type"].toString(),
        receiverId: json["receiver_id"].toString(),
        receiverType: json["receiver_type"].toString(),
        currencyId: json["currency_id"].toString(),
        walletId: json["wallet_id"].toString(),
        beforeCharge: json["before_charge"].toString(),
        amount: json["amount"].toString(),
        charge: json["charge"].toString(),
        postBalance: json["post_balance"].toString(),
        trxType: json["trx_type"].toString(),
        chargeType: json["charge_type"].toString(),
        trx: json["trx"].toString(),
        details: json["details"].toString(),
        remark: json["remark"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        apiDetails: json["apiDetails"].toString(),
        currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
        receiverUser: json["receiver_user"].toString(),
        receiverAgent: json["receiver_agent"].toString(),
        receiverMerchant: json["receiver_merchant"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_type": userType,
        "receiver_id": receiverId,
        "receiver_type": receiverType,
        "currency_id": currencyId,
        "wallet_id": walletId,
        "before_charge": beforeCharge,
        "amount": amount,
        "charge": charge,
        "post_balance": postBalance,
        "trx_type": trxType,
        "charge_type": chargeType,
        "trx": trx,
        "details": details,
        "remark": remark,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "apiDetails": apiDetails,
        "currency": currency?.toJson(),
        "receiver_user": receiverUser,
        "receiver_agent": receiverAgent,
        "receiver_merchant": receiverMerchant,
      };
}

class Currency {
  int? id;
  String? currencyCode;
  String? currencySymbol;
  String? currencyFullname;
  String? currencyType;
  String? rate;
  String? isDefault;
  String? status;
  String? createdAt;
  String? updatedAt;

  Currency({
    this.id,
    this.currencyCode,
    this.currencySymbol,
    this.currencyFullname,
    this.currencyType,
    this.rate,
    this.isDefault,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        currencyCode: json["currency_code"].toString(),
        currencySymbol: json["currency_symbol"].toString(),
        currencyFullname: json["currency_fullname"].toString(),
        currencyType: json["currency_type"].toString(),
        rate: json["rate"].toString(),
        isDefault: json["is_default"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "currency_code": currencyCode,
        "currency_symbol": currencySymbol,
        "currency_fullname": currencyFullname,
        "currency_type": currencyType,
        "rate": rate,
        "is_default": isDefault,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Wallet {
  int? id;
  String? userId;
  String? userType;
  String? currencyId;
  String? currencyCode;
  String? balance;
  String? createdAt;
  String? updatedAt;
  String? transactions;
  Currency? currency;

  Wallet({
    this.id,
    this.userId,
    this.userType,
    this.currencyId,
    this.currencyCode,
    this.balance,
    this.createdAt,
    this.updatedAt,
    this.transactions,
    this.currency,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        userId: json["user_id"].toString(),
        userType: json["user_type"].toString(),
        currencyId: json["currency_id"].toString(),
        currencyCode: json["currency_code"].toString(),
        balance: json["balance"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        transactions: json["transactions"].toString(),
        currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_type": userType,
        "currency_id": currencyId,
        "currency_code": currencyCode,
        "balance": balance,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "transactions": transactions,
        "currency": currency?.toJson(),
      };
}
