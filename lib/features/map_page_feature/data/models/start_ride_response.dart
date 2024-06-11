import 'package:squch/features/map_page_feature/data/models/ride_booking_bid_response.dart';

class StartRideResponse {
  bool? status;
  String? message;
  StartRideData? data;

  StartRideResponse({this.status, this.message, this.data});

  StartRideResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new StartRideData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class StartRideData {
  String? status;
  Trip? trip;

  StartRideData({this.status, this.trip});

  StartRideData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    trip = json['trip'] != null ? new Trip.fromJson(json['trip']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.trip != null) {
      data['trip'] = this.trip!.toJson();
    }
    return data;
  }
}

/*class Trip {
  int? id;
  int? customerId;
  int? vehicleTypeId;
  String? sceLat;
  String? sceLong;
  String? destLat;
  String? destLong;
  String? sceLoaction;
  String? destLocation;
  int? distance;
  int? initCalcPrice;
  int? price;
  String? type;
  String? status;
  String? paymentMode;
  Customer? customer;
  Driver? driver;
  VehicleType? vehicleType;
  Trip(
      {this.id,
      this.customerId,
      this.vehicleTypeId,
      this.sceLat,
      this.sceLong,
      this.destLat,
      this.destLong,
      this.distance,
      this.initCalcPrice,
      this.price,
      this.type,
      this.status,
      this.paymentMode,
      this.customer,
      this.driver,
      this.vehicleType});

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    vehicleTypeId = json['vehicleTypeId'];
    sceLat = json['sceLat'];
    sceLong = json['sceLong'];
    destLat = json['destLat'];
    destLong = json['destLong'];
    destLocation = json['destLocation'];
    sceLoaction = json['sceLocation'];
    distance = json['distance'];
    initCalcPrice = json['initCalcPrice'];
    price = json['price'];
    type = json['type'];
    status = json['status'];
    paymentMode = json['paymentMode'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    driver =
        json['driver'] == null ? Driver() : Driver.fromJson(json['driver']);
    vehicleType = json['vehicleType'] != null
        ? new VehicleType.fromJson(json['vehicleType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['vehicleTypeId'] = this.vehicleTypeId;
    data['sceLat'] = this.sceLat;
    data['sceLong'] = this.sceLong;
    data['destLat'] = this.destLat;
    data['destLong'] = this.destLong;
    data['destLocation'] = this.destLocation;
    data['sceLoaction'] = this.sceLoaction;
    data['distance'] = this.distance;
    data['initCalcPrice'] = this.initCalcPrice;
    data['price'] = this.price;
    data['type'] = this.type;
    data['status'] = this.status;
    data['paymentMode'] = this.paymentMode;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['driver'] = this.driver?.toJson();
    if (this.vehicleType != null) {
      data['vehicleType'] = this.vehicleType!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  int? roleId;
  int? subRoleId;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? mobile;
  String? referralCode;
  String? createdAt;
  String? updatedAt;
  String? profileImage;

  Customer(
      {this.id,
      this.roleId,
      this.subRoleId,
      this.firstName,
      this.lastName,
      this.email,
      this.countryCode,
      this.mobile,
      this.referralCode,
      this.createdAt,
      this.updatedAt,
      this.profileImage});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['roleId'];
    subRoleId = json['subRoleId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    referralCode = json['referralCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roleId'] = this.roleId;
    data['subRoleId'] = this.subRoleId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['countryCode'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['referralCode'] = this.referralCode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class VehicleType {
  int? id;
  String? name;
  String? image;

  VehicleType({this.id, this.name, this.image});

  VehicleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}


class IdCardDetails {
  String? dob;
  String? idCardNumber;
  String? idCardPhoto;
  String? idStatus;
  String? idAdminRemarks;

  IdCardDetails(
      {this.dob,
      this.idCardNumber,
      this.idCardPhoto,
      this.idStatus,
      this.idAdminRemarks});

  IdCardDetails.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    idCardNumber = json['idCardNumber'];
    idCardPhoto = json['idCardPhoto'];
    idStatus = json['idStatus'];
    idAdminRemarks = json['idAdminRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['idCardNumber'] = this.idCardNumber;
    data['idCardPhoto'] = this.idCardPhoto;
    data['idStatus'] = this.idStatus;
    data['idAdminRemarks'] = this.idAdminRemarks;
    return data;
  }
}

class VehicleDetails {
  String? vehicleCompanyId;
  String? vehicleModelId;
  String? vehicleRegYear;
  String? vehicleVinNo;
  String? vehicleRegNo;
  String? vehicleImage;
  String? vehicleRegDoc;
  String? vehicleStatus;
  String? vehicleAdminRemarks;
  String? vehicleCompany;
  VehicleModel? vehicleModel;

  VehicleDetails(
      {this.vehicleCompanyId,
      this.vehicleModelId,
      this.vehicleRegYear,
      this.vehicleVinNo,
      this.vehicleRegNo,
      this.vehicleImage,
      this.vehicleRegDoc,
      this.vehicleStatus,
      this.vehicleAdminRemarks,
      this.vehicleCompany,
      this.vehicleModel});

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    vehicleCompanyId = json['vehicleCompanyId'];
    vehicleModelId = json['vehicleModelId'];
    vehicleRegYear = json['vehicleRegYear'];
    vehicleVinNo = json['vehicleVinNo'];
    vehicleRegNo = json['vehicleRegNo'];
    vehicleImage = json['vehicleImage'];
    vehicleRegDoc = json['vehicleRegDoc'];
    vehicleStatus = json['vehicleStatus'];
    vehicleAdminRemarks = json['vehicleAdminRemarks'];
    vehicleCompany = json['vehicleCompany'];
    vehicleModel = json['vehicleModel'] != null
        ? new VehicleModel.fromJson(json['vehicleModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleCompanyId'] = this.vehicleCompanyId;
    data['vehicleModelId'] = this.vehicleModelId;
    data['vehicleRegYear'] = this.vehicleRegYear;
    data['vehicleVinNo'] = this.vehicleVinNo;
    data['vehicleRegNo'] = this.vehicleRegNo;
    data['vehicleImage'] = this.vehicleImage;
    data['vehicleRegDoc'] = this.vehicleRegDoc;
    data['vehicleStatus'] = this.vehicleStatus;
    data['vehicleAdminRemarks'] = this.vehicleAdminRemarks;
    data['vehicleCompany'] = this.vehicleCompany;
    if (this.vehicleModel != null) {
      data['vehicleModel'] = this.vehicleModel!.toJson();
    }
    return data;
  }
}

class VehicleModel {
  int? id;
  int? vehicleCompanyId;
  String? name;

  VehicleModel({this.id, this.vehicleCompanyId, this.name});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleCompanyId = json['vehicleCompanyId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicleCompanyId'] = this.vehicleCompanyId;
    data['name'] = this.name;
    return data;
  }
}

class LicenseDetails {
  String? licenseNumber;
  String? licensePhoto;
  String? licenseStatus;
  String? licenseAdminRemarks;

  LicenseDetails(
      {this.licenseNumber,
      this.licensePhoto,
      this.licenseStatus,
      this.licenseAdminRemarks});

  LicenseDetails.fromJson(Map<String, dynamic> json) {
    licenseNumber = json['licenseNumber'];
    licensePhoto = json['licensePhoto'];
    licenseStatus = json['licenseStatus'];
    licenseAdminRemarks = json['licenseAdminRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['licenseNumber'] = this.licenseNumber;
    data['licensePhoto'] = this.licensePhoto;
    data['licenseStatus'] = this.licenseStatus;
    data['licenseAdminRemarks'] = this.licenseAdminRemarks;
    return data;
  }
}

class ProfilePicDetails {
  String? profilePic;
  String? profilePicStatus;
  String? profilePicAdminRemarks;

  ProfilePicDetails(
      {this.profilePic, this.profilePicStatus, this.profilePicAdminRemarks});

  ProfilePicDetails.fromJson(Map<String, dynamic> json) {
    profilePic = json['profilePic'];
    profilePicStatus = json['profilePicStatus'];
    profilePicAdminRemarks = json['profilePicAdminRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profilePic'] = this.profilePic;
    data['profilePicStatus'] = this.profilePicStatus;
    data['profilePicAdminRemarks'] = this.profilePicAdminRemarks;
    return data;
  }
}

class InsuranceDetails {
  String? insuranceNumber;
  String? insuranceImage;
  String? insuranceStatus;
  String? insuranceAdminRemarks;

  InsuranceDetails(
      {this.insuranceNumber,
      this.insuranceImage,
      this.insuranceStatus,
      this.insuranceAdminRemarks});

  InsuranceDetails.fromJson(Map<String, dynamic> json) {
    insuranceNumber = json['insuranceNumber'];
    insuranceImage = json['insuranceImage'];
    insuranceStatus = json['insuranceStatus'];
    insuranceAdminRemarks = json['insuranceAdminRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['insuranceNumber'] = this.insuranceNumber;
    data['insuranceImage'] = this.insuranceImage;
    data['insuranceStatus'] = this.insuranceStatus;
    data['insuranceAdminRemarks'] = this.insuranceAdminRemarks;
    return data;
  }
}

class BankDetails {
  String? payoutAccType;
  String? mWalletNumber;
  String? bankId;
  String? bankBranch;
  String? bankAccNo;
  String? bankIfscCode;
  String? bankStatus;
  String? bankRemarks;

  BankDetails(
      {this.payoutAccType,
      this.mWalletNumber,
      this.bankId,
      this.bankBranch,
      this.bankAccNo,
      this.bankIfscCode,
      this.bankStatus,
      this.bankRemarks});

  BankDetails.fromJson(Map<String, dynamic> json) {
    payoutAccType = json['payoutAccType'];
    mWalletNumber = json['mWalletNumber'];
    bankId = json['bankId'];
    bankBranch = json['bankBranch'];
    bankAccNo = json['bankAccNo'];
    bankIfscCode = json['bankIfscCode'];
    bankStatus = json['bankStatus'];
    bankRemarks = json['bankRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payoutAccType'] = this.payoutAccType;
    data['mWalletNumber'] = this.mWalletNumber;
    data['bankId'] = this.bankId;
    data['bankBranch'] = this.bankBranch;
    data['bankAccNo'] = this.bankAccNo;
    data['bankIfscCode'] = this.bankIfscCode;
    data['bankStatus'] = this.bankStatus;
    data['bankRemarks'] = this.bankRemarks;
    return data;
  }
}*/
