class CustomerInfo {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  int? type;
  String? gender;
  String? occupation;
  int? twoFactor;
  String? fcmToken;
  int? balance;
  String? uniqueId;
  String? qrCode;
  int? isKycVerified;

  CustomerInfo(
      {this.fName,
        this.lName,
        this.phone,
        this.email,
        this.image,
        this.type,
        this.gender,
        this.occupation,
        this.twoFactor,
        this.fcmToken,
        this.balance,
        this.uniqueId,
        this.qrCode,
        this.isKycVerified});

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    type = json['type'];
    gender = json['gender'];
    occupation = json['occupation'];
    twoFactor = json['two_factor'];
    fcmToken = json['fcm_token'];
    balance = json['balance'];
    uniqueId = json['unique_id'];
    qrCode = json['qr_code'];
    isKycVerified = json['is_kyc_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['type'] = this.type;
    data['gender'] = this.gender;
    data['occupation'] = this.occupation;
    data['two_factor'] = this.twoFactor;
    data['fcm_token'] = this.fcmToken;
    data['balance'] = this.balance;
    data['unique_id'] = this.uniqueId;
    data['qr_code'] = this.qrCode;
    data['is_kyc_verified'] = this.isKycVerified;
    return data;
  }
}