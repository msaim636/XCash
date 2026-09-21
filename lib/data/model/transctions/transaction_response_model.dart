// To parse this JSON data, do
//
//     final transactionResponseModel = transactionResponseModelFromJson(jsonString);

import 'dart:convert';

TransactionResponseModel transactionResponseModelFromJson(String str) => TransactionResponseModel.fromJson(json.decode(str));

String transactionResponseModelToJson(TransactionResponseModel data) => json.encode(data.toJson());

class TransactionResponseModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    TransactionResponseModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory TransactionResponseModel.fromJson(Map<String, dynamic> json) => TransactionResponseModel(
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
    List<String>? operations;
    List<String>? times;
    List<String>? currencies;
    Transactions? transactions;

    Data({
        this.operations,
        this.times,
        this.currencies,
        this.transactions,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        operations: json["operations"] == null ? [] : List<String>.from(json["operations"]!.map((x) => x)),
        times: json["times"] == null ? [] : List<String>.from(json["times"]!.map((x) => x)),
        currencies: json["currencies"] == null ? [] : List<String>.from(json["currencies"]!.map((x) => x)),
        transactions: json["transactions"] == null ? null : Transactions.fromJson(json["transactions"]),
    );

    Map<String, dynamic> toJson() => {
        "operations": operations == null ? [] : List<dynamic>.from(operations!.map((x) => x)),
        "times": times == null ? [] : List<dynamic>.from(times!.map((x) => x)),
        "currencies": currencies == null ? [] : List<dynamic>.from(currencies!.map((x) => x)),
        "transactions": transactions?.toJson(),
    };
}

class Transactions {
    int? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    Transactions({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Transactions.fromJson(Map<String, dynamic> json) => Transactions(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    int? id;
    String? userId;
    UserType? userType;
    String? receiverId;
    String? receiverType;
    String? currencyId;
    String? walletId;
    String? beforeCharge;
    String? amount;
    String? charge;
    String? postBalance;
    String? trxType;
    String? chargeType;
    String? trx;
    String? details;
    String? remark;
    String? createdAt;
    String? updatedAt;
    String? apiDetails;
    Currency? currency;
    ReceiverUser? receiverUser;
    ReceiverAgent? receiverAgent;
    ReceiverMerchant? receiverMerchant;

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"].toString(),
        userType: userTypeValues.map[json["user_type"]]!,
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
        createdAt: json["created_at"] .toString(),
        updatedAt: json["updated_at"].toString(),
        apiDetails: json["apiDetails"].toString(),
        currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
        receiverUser: json["receiver_user"] == null ? null : ReceiverUser.fromJson(json["receiver_user"]),
     receiverAgent: json["receiver_agent"] == null ? null : ReceiverAgent.fromJson(json["receiver_agent"]),
      receiverMerchant: json["receiver_merchant"].toString() == "null" ? null : ReceiverMerchant.fromJson(json["receiver_merchant"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_type": userTypeValues.reverse[userType],
        "receiver_id": receiverId,
        "receiver_type": receiverType,
        "currency_id": currencyId,
        "wallet_id": walletId,
        "before_charge": beforeCharge,
        "amount": amount,
        "charge": charge,
        "post_balance": postBalance,
        "trx_type": trxType,
        "charge_type":chargeType,
        "trx": trx,
        "details": details,
        "remark": remark,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "apiDetails": apiDetails,
        "currency": currency?.toJson(),
        "receiver_user": receiverUser?.toJson(),
        "receiver_agent": receiverAgent?.toJson(),
        "receiver_merchant": receiverMerchant?.toJson(),
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
        currencyCode:json["currency_code"].toString(),
        currencySymbol: json["currency_symbol"].toString(),
        currencyFullname: json["currency_fullname"].toString(),
        currencyType: json["currency_type"].toString(),
        rate: json["rate"].toString(),
        isDefault: json["is_default"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"] .toString(),
        updatedAt: json["updated_at"] .toString(),
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











class ReceiverAgent {
    int? id;
    String? firstname;
    String? lastname;
    String? username;
    String? email;
    String? countryCode;
    String? mobile;
    String? refBy;
    String? balance;
    String? password;
    String? image;
    String? address;
    String? status;
    String? kv;
    String? kycData;
    String? ev;
    String? sv;
    String? profileComplete;
    String? verCode;
    String? verCodeSendAt;
    String? ts;
    String? tv;
    String ?tsc;
    String? banReason;
    String ?rememberToken;
    String? createdAt;
    String? updatedAt;

    ReceiverAgent({
        this.id,
        this.firstname,
        this.lastname,
        this.username,
        this.email,
        this.countryCode,
        this.mobile,
        this.refBy,
        this.balance,
        this.password,
        this.image,
        this.address,
        this.status,
        this.kv,
        this.kycData,
        this.ev,
        this.sv,
        this.profileComplete,
        this.verCode,
        this.verCodeSendAt,
        this.ts,
        this.tv,
        this.tsc,
        this.banReason,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
    });

    factory ReceiverAgent.fromJson(Map<String, dynamic> json) => ReceiverAgent(
        id: json["id"],
        firstname: json["firstname"].toString(),
        lastname: json["lastname"].toString(),
        username: json["username"].toString(),
        email: json["email"].toString(),
        countryCode: json["country_code"].toString(),
        mobile: json["mobile"].toString(),
        refBy: json["ref_by"].toString(),
        balance: json["balance"].toString(),
        password: json["password"].toString(),
        image: json["image"].toString(),
        status: json["status"].toString(),
        kv: json["kv"].toString(),
        kycData: json["kyc_data"].toString(),
        ev: json["ev"].toString(),
        sv: json["sv"].toString(),
        profileComplete: json["profile_complete"].toString(),
        verCode: json["ver_code"].toString(),
        verCodeSendAt: json["ver_code_send_at"],
        ts: json["ts"].toString(),
        tv: json["tv"].toString(),
        tsc: json["tsc"].toString(),
        banReason: json["ban_reason"].toString(),
        rememberToken: json["remember_token"].toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "country_code": countryCode,
        "mobile": mobile,
        "ref_by": refBy,
        "balance": balance,
        "password": password,
        "image": image,
        "address": address,
        "status": status,
        "kv": kv,
        "kyc_data": kycData,
        "ev": ev,
        "sv": sv,
        "profile_complete": profileComplete,
        "ver_code": verCode,
        "ver_code_send_at": verCodeSendAt,
        "ts": ts,
        "tv": tv,
        "tsc": tsc,
        "ban_reason": banReason,
        "remember_token": rememberToken,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}


class ReceiverMerchant {
    int? id;
    String? firstname;
    String? lastname;
    String? username;
    String? email;
    String? countryCode;
    String? mobile;
    String? refBy;
    String? balance;
    String? password;
    String? image;
    String? status;
    String? kv;
    String? kycData;
    String? ev;
    String? sv;
    String? profileComplete;
    String? verCode;
    String? verCodeSendAt;
    String? ts;
    String? tv;
    String? tsc;
    String? banReason;
    String? publicApiKey;
    String? secretApiKey;
    String? rememberToken;
   String? createdAt;
   String? updatedAt;

    ReceiverMerchant({
        this.id,
        this.firstname,
        this.lastname,
        this.username,
        this.email,
        this.countryCode,
        this.mobile,
        this.refBy,
        this.balance,
        this.password,
        this.image,
        this.status,
        this.kv,
        this.kycData,
        this.ev,
        this.sv,
        this.profileComplete,
        this.verCode,
        this.verCodeSendAt,
        this.ts,
        this.tv,
        this.tsc,
        this.banReason,
        this.publicApiKey,
        this.secretApiKey,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
    });

    factory ReceiverMerchant.fromJson(Map<String, dynamic> json) => ReceiverMerchant(
        id: json["id"],
        firstname: json["firstname"].toString(),
        lastname: json["lastname"].toString(),
        username: json["username"].toString(),
        email: json["email"].toString(),
        countryCode: json["country_code"].toString(),
        mobile: json["mobile"].toString(),
        refBy: json["ref_by"].toString(),
        balance: json["balance"].toString(),
        password: json["password"].toString(),
        image: json["image"].toString(),
        status: json["status"].toString(),
        kv: json["kv"].toString(),
        kycData: json["kyc_data"].toString(),
        ev: json["ev"].toString(),
        sv: json["sv"].toString(),
        profileComplete: json["profile_complete"].toString(),
        verCode: json["ver_code"].toString(),
        verCodeSendAt: json["ver_code_send_at"].toString(),
        ts: json["ts"].toString(),
        tv: json["tv"].toString(),
        tsc: json["tsc"].toString(),
        banReason: json["ban_reason"].toString(),
        publicApiKey: json["public_api_key"].toString(),
        secretApiKey: json["secret_api_key"].toString(),
        rememberToken: json["remember_token"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "country_code": countryCode,
        "mobile": mobile,
        "ref_by": refBy,
        "balance": balance,
        "password": password,
        "image": image,
        "status": status,
        "kv": kv,
        "kyc_data": kycData,
        "ev": ev,
        "sv": sv,
        "profile_complete": profileComplete,
        "ver_code": verCode,
        "ver_code_send_at": verCodeSendAt,
        "ts": ts,
        "tv": tv,
        "tsc": tsc,
        "ban_reason": banReason,
        "public_api_key": publicApiKey,
        "secret_api_key": secretApiKey,
        "remember_token": rememberToken,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class ReceiverUser {
    int? id;
    String? companyName;
    String? firstname;
    String? lastname;
    String? username;
    String? email;
    String? dialCode;
    String? countryCode;
    String? mobile;
    String? countryName;
    String? city;
    String? state;
    String? zip;
    String? address;
    String? image;
    String? status;
    String? kycRejectionReason;
    String? kv;
    String? ev;
    String? sv;
    String? profileComplete;
    String? verCodeSendAt;
    String? ts;
    String? tv;
    String? tsc;
    String? banReason;
    String? provider;
    String? providerId;
    String? createdAt;
    String? updatedAt;

    ReceiverUser({
        this.id,
        this.companyName,
        this.firstname,
        this.lastname,
        this.username,
        this.email,
        this.dialCode,
        this.countryCode,
        this.mobile,
        this.countryName,
        this.city,
        this.state,
        this.zip,
        this.address,
        this.image,
        this.status,
        this.kycRejectionReason,
        this.kv,
        this.ev,
        this.sv,
        this.profileComplete,
        this.verCodeSendAt,
        this.ts,
        this.tv,
        this.tsc,
        this.banReason,
        this.provider,
        this.providerId,
        this.createdAt,
        this.updatedAt,
    });

    factory ReceiverUser.fromJson(Map<String, dynamic> json) => ReceiverUser(
        id: json["id"],
        companyName: json["company_name"].toString(),
        firstname: json["firstname"].toString(),
        lastname: json["lastname"].toString(),
        username: json["username"].toString(),
        email: json["email"].toString(),
        dialCode: json["dial_code"].toString(),
        countryCode: json["country_code"].toString(),
        mobile: json["mobile"].toString(),
        countryName: json["country_name"].toString(),
        city: json["city"].toString(),
        state: json["state"].toString(),
        zip: json["zip"].toString(),
        address: json["address"].toString(),
        image: json["image"].toString(),
        status: json["status"].toString(),
        kycRejectionReason: json["kyc_rejection_reason"].toString(),
        kv: json["kv"].toString(),
        ev: json["ev"].toString(),
        sv: json["sv"].toString(),
        profileComplete: json["profile_complete"].toString(),
        verCodeSendAt: json["ver_code_send_at"] .toString(),
        ts: json["ts"].toString(),
        tv: json["tv"].toString(),
        tsc: json["tsc"].toString(),
        banReason: json["ban_reason"].toString(),
        provider: json["provider"].toString(),
        providerId: json["provider_id"].toString(),
        createdAt: json["created_at"] .toString(),
        updatedAt: json["updated_at"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "firstname": firstname,
        "lastname": lastname,
        "username": username,
        "email": email,
        "dial_code": dialCode,
        "country_code": countryCode,
        "mobile": mobile,
        "country_name": countryName,
        "city": city,
        "state": state,
        "zip": zip,
        "address": address,
        "image": image,
        "status": status,
        "kyc_rejection_reason": kycRejectionReason,
        "kv": kv,
        "ev": ev,
        "sv": sv,
        "profile_complete": profileComplete,
        "ver_code_send_at": verCodeSendAt,
        "ts": ts,
        "tv": tv,
        "tsc": tsc,
        "ban_reason": banReason,
        "provider": provider,
        "provider_id": providerId,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

enum UserType {
    USER
}

final userTypeValues = EnumValues({
    "USER": UserType.USER
});

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"].toString(),
        label: json["label"].toString(),
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}

class Message {
    List<String>? success;

    Message({
        this.success,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: json["success"] == null ? [] : List<String>.from(json["success"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? [] : List<dynamic>.from(success!.map((x) => x)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
