class RequestsModel {
  String? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? image;
  String? type;
  String? role;
  String? password;
  String? isPhoneVerified;
  String? isEmailVerified;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? lastActiveAt;
  String? uniqueId;
  String? referralId;
  String? gender;
  String? occupation;
  String? twoFactor;
  String? fcmToken;
  String? isActive;
  String? identificationType;
  String? identificationNumber;
  String? identificationImage;
  String? isKycVerified;
  String? empId;
  String? vendId;

  RequestsModel(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.image,
        this.type,
        this.role,
        this.password,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.rememberToken,
        this.createdAt,
        this.updatedAt,
        this.lastActiveAt,
        this.uniqueId,
        this.referralId,
        this.gender,
        this.occupation,
        this.twoFactor,
        this.fcmToken,
        this.isActive,
        this.identificationType,
        this.identificationNumber,
        this.identificationImage,
        this.isKycVerified,
        this.empId,
        this.vendId});

  RequestsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    type = json['type'];
    role = json['role'];
    password = json['password'];
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastActiveAt = json['last_active_at'];
    uniqueId = json['unique_id'];
    referralId = json['referral_id'];
    gender = json['gender'];
    occupation = json['occupation'];
    twoFactor = json['two_factor'];
    fcmToken = json['fcm_token'];
    isActive = json['is_active'];
    identificationType = json['identification_type'];
    identificationNumber = json['identification_number'];
    identificationImage = json['identification_image'];
    isKycVerified = json['is_kyc_verified'];
    empId = json['emp_id'];
    vendId = json['vend_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['type'] = this.type;
    data['role'] = this.role;
    data['password'] = this.password;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['last_active_at'] = this.lastActiveAt;
    data['unique_id'] = this.uniqueId;
    data['referral_id'] = this.referralId;
    data['gender'] = this.gender;
    data['occupation'] = this.occupation;
    data['two_factor'] = this.twoFactor;
    data['fcm_token'] = this.fcmToken;
    data['is_active'] = this.isActive;
    data['identification_type'] = this.identificationType;
    data['identification_number'] = this.identificationNumber;
    data['identification_image'] = this.identificationImage;
    data['is_kyc_verified'] = this.isKycVerified;
    data['emp_id'] = this.empId;
    data['vend_id'] = this.vendId;
    return data;
  }
}
