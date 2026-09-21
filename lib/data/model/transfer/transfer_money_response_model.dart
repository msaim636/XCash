// To parse this JSON data, do
//
//     final transferMoneyResponseModel = transferMoneyResponseModelFromJson(jsonString);

import 'dart:convert';

import '../global/meassage_model.dart';

TransferMoneyResponseModel transferMoneyResponseModelFromJson(String str) => TransferMoneyResponseModel.fromJson(json.decode(str));

String transferMoneyResponseModelToJson(TransferMoneyResponseModel data) => json.encode(data.toJson());

class TransferMoneyResponseModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    TransferMoneyResponseModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory TransferMoneyResponseModel.fromJson(Map<String, dynamic> json) => TransferMoneyResponseModel(
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
    List<String>? otpType;
    List<Wallet>? wallets;
    TransferCharge? transferCharge;

    Data({
        this.otpType,
        this.wallets,
        this.transferCharge,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        otpType: json["otp_type"] == null ? [] : List<String>.from(json["otp_type"]!.map((x) => x)),
        wallets: json["wallets"] == null ? [] : List<Wallet>.from(json["wallets"]!.map((x) => Wallet.fromJson(x))),
        transferCharge: json["transfer_charge"] == null ? null : TransferCharge.fromJson(json["transfer_charge"]),
    );

    Map<String, dynamic> toJson() => {
        "otp_type": otpType == null ? [] : List<dynamic>.from(otpType!.map((x) => x)),
        "wallets": wallets == null ? [] : List<dynamic>.from(wallets!.map((x) => x.toJson())),
        "transfer_charge": transferCharge?.toJson(),
    };
}

class TransferCharge {
    int? id;
    String? slug;
    String? fixedCharge;
    String? percentCharge;
    String? minLimit;
    String? maxLimit;
    String? agentCommissionFixed;
    String? agentCommissionPercent;
    String? merchantFixedCharge;
    String? merchantPercentCharge;
    String? monthlyLimit;
    String? dailyLimit;
    String? dailyRequestAcceptLimit;
    String? voucherLimit;
    String? cap;
    String? createdAt;
    String? updatedAt;

    TransferCharge({
        this.id,
        this.slug,
        this.fixedCharge,
        this.percentCharge,
        this.minLimit,
        this.maxLimit,
        this.agentCommissionFixed,
        this.agentCommissionPercent,
        this.merchantFixedCharge,
        this.merchantPercentCharge,
        this.monthlyLimit,
        this.dailyLimit,
        this.dailyRequestAcceptLimit,
        this.voucherLimit,
        this.cap,
        this.createdAt,
        this.updatedAt,
    });

    factory TransferCharge.fromJson(Map<String, dynamic> json) => TransferCharge(
        id: json["id"],
        slug: json["slug"].toString(),
        fixedCharge: json["fixed_charge"].toString(),
        percentCharge: json["percent_charge"].toString(),
        minLimit: json["min_limit"].toString(),
        maxLimit: json["max_limit"].toString(),
        agentCommissionFixed: json["agent_commission_fixed"].toString(),
        agentCommissionPercent: json["agent_commission_percent"].toString(),
        merchantFixedCharge: json["merchant_fixed_charge"].toString(),
        merchantPercentCharge: json["merchant_percent_charge"].toString(),
        monthlyLimit: json["monthly_limit"].toString(),
        dailyLimit: json["daily_limit"].toString(),
        dailyRequestAcceptLimit: json["daily_request_accept_limit"].toString(),
        voucherLimit: json["voucher_limit"].toString(),
        cap: json["cap"].toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "fixed_charge": fixedCharge,
        "percent_charge": percentCharge,
        "min_limit": minLimit,
        "max_limit": maxLimit,
        "agent_commission_fixed": agentCommissionFixed,
        "agent_commission_percent": agentCommissionPercent,
        "merchant_fixed_charge": merchantFixedCharge,
        "merchant_percent_charge": merchantPercentCharge,
        "monthly_limit": monthlyLimit,
        "daily_limit": dailyLimit,
        "daily_request_accept_limit": dailyRequestAcceptLimit,
        "voucher_limit": voucherLimit,
        "cap": cap,
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
        this.currency,
    });

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        userId: json["user_id"].toString(),
        userType: json["user_type"].toString(),
        currencyId: json["currency_id"].toString(),
        currencyCode: json["currency_code"].toString(),
        balance: json["balance"].toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
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
        "currency": currency?.toJson(),
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
    String? transferMinLimit;
    String? transferMaxLimit;

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
        this.transferMinLimit,
        this.transferMaxLimit,
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
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
        transferMinLimit: json["transfer_min_limit"].toString(),
        transferMaxLimit: json["transfer_max_limit"].toString(),
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
        "transfer_min_limit": transferMinLimit,
        "transfer_max_limit": transferMaxLimit,
    };
}


