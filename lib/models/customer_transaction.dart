class CustomerTransaction {
  int? totalSize;
  int? limit;
  int? offset;
  List<Transactions>? transactions;

  CustomerTransaction(
      {this.totalSize, this.limit, this.offset, this.transactions});

  CustomerTransaction.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? transactionId;
  String? transactionType;
  int? debit;
  int? credit;
  UserInfo? userInfo;
  UserInfo? sender;
  UserInfo? receiver;
  String? createdAt;
  int? amount;

  Transactions(
      {this.transactionId,
        this.transactionType,
        this.debit,
        this.credit,
        this.userInfo,
        this.sender,
        this.receiver,
        this.createdAt,
        this.amount});

  Transactions.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    transactionType = json['transaction_type'];
    debit = json['debit'];
    credit = json['credit'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    sender =
    json['sender'] != null ? new UserInfo.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? new UserInfo.fromJson(json['receiver'])
        : null;
    createdAt = json['created_at'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['transaction_type'] = this.transactionType;
    data['debit'] = this.debit;
    data['credit'] = this.credit;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.receiver != null) {
      data['receiver'] = this.receiver!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['amount'] = this.amount;
    return data;
  }
}

class UserInfo {
  String? phone;
  String? name;

  UserInfo({this.phone, this.name});

  UserInfo.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }
}