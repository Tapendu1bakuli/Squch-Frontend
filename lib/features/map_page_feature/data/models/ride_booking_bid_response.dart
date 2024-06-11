import '../../../../core/model/model.dart';
import '../../../../core/utils/date_time_utilities.dart';
import 'address_model.dart';

class RideBookingBidResponse {
  bool? status;
  String? message;
  RideBookingBidDataData? data;

  RideBookingBidResponse({this.status, this.message, this.data});

  RideBookingBidResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new RideBookingBidDataData.fromJson(json['data']) : null;
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

class RideBookingBidDataData {
  String? status;
  Settings? settings;
  Trip? trip;
  List<Bids>? bids;

  RideBookingBidDataData({this.status, this.settings, this.trip, this.bids});

  RideBookingBidDataData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    trip = json['trip'] != null ? new Trip.fromJson(json['trip']) : null;
    if (json['bids'] != null) {
      bids = <Bids>[];
      json['bids'].forEach((v) {
        bids!.add(new Bids.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.trip != null) {
      data['trip'] = this.trip!.toJson();
    }
    if (this.bids != null) {
      data['bids'] = this.bids!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Settings {
  String? tripAutoCancelTime;
  String? bidAutoCancelTime;

  Settings({this.tripAutoCancelTime, this.bidAutoCancelTime});

  Settings.fromJson(Map<String, dynamic> json) {
    tripAutoCancelTime = json['tripAutoCancelTime'];
    bidAutoCancelTime = json['bidAutoCancelTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tripAutoCancelTime'] = this.tripAutoCancelTime;
    data['bidAutoCancelTime'] = this.bidAutoCancelTime;
    return data;
  }
}

class Trip  extends Model {
  int? id;
  int? customerId;
  String? driverId;
  int? vehicleTypeId;
  String? sceLat;
  String? sceLong;
  String? sceLocation;
  String? destLat;
  String? destLong;
  String? destLocation;
  int? distance;
  int? initCalcPrice;
  int? price;
  String? driverCharges;
  String? adminCharges;
  String? type;
  String? status;
  String? paymentMode;
  String? currency;
  String? currencySymbol;
  Customer? customer;
  VehicleType? vehicleType;
  SceDistance? sceDistance;
  SceDistance? destDistance;
  String? createdAt;
  String? driverArrivedAt;
  String? driverArrivedAtHour;
  String? rideStartedAt;
  String? rideStartedAtHour;
  String? rideCompletedAt;
  String? rideCompletedAtHour;
  num? minDriverPrice;
  num? maxDriverPrice;
  Driver? driver;
  Address? destination;
  Address? origin;
  bool? isMultiStop;
  List<Address>? stoppages=<Address>[];
  Trip(
      {this.id,
        this.customerId,
        this.driverId,
        this.vehicleTypeId,
        this.sceLat,
        this.sceLong,
        this.sceLocation,
        this.destLat,
        this.destLong,
        this.destLocation,
        this.distance,
        this.initCalcPrice,
        this.price,
        this.driverCharges,
        this.adminCharges,
        this.type,
        this.status,
        this.paymentMode,
        this.currency,
        this.currencySymbol,
        this.customer,
        this.vehicleType,
        this.sceDistance,
        this.createdAt,
        this.minDriverPrice,
        this.maxDriverPrice,
        this.destDistance,
        this.stoppages,
        this.origin,
        this.destination,
        this.isMultiStop = false,
        this.driver,
        this.driverArrivedAt,
        this.driverArrivedAtHour,
        this.rideStartedAt,
        this.rideStartedAtHour,
        this.rideCompletedAt,
        this.rideCompletedAtHour,
      });

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    driverId = json['driverId'].toString();
    vehicleTypeId = json['vehicleTypeId'];
    sceLat = json['sceLat'];
    sceLong = json['sceLong'];
    sceLocation = json['sceLocation'];
    destLat = json['destLat'];
    destLong = json['destLong'];
    sceLocation = json['sceLocation'];
    destLocation = json['destLocation'];
    distance = json['distance'];
    initCalcPrice = json['initCalcPrice'];
    price = json['price'];
    driverCharges = json['driverCharges'].toString();
    adminCharges = json['adminCharges'].toString();
    type = json['type'];
    status = json['status'];
    paymentMode = json['paymentMode'];
    currency = json['currency'];
    currencySymbol = json['currencySymbol'];
    createdAt = json['createdAt'];
    driverArrivedAt = json['driverArrivedAt'];
    driverArrivedAtHour = json['driverArrivedAt'] == null
        ? null
        : DateTimeUtility()
        .parse(dateTime: json['driverArrivedAt'], returnFormat: "hh:mm a");
    rideStartedAt = json['rideStartedAt'];
    rideStartedAtHour = json['rideStartedAt'] == null
        ? null
        : DateTimeUtility()
        .parse(dateTime: json['rideStartedAt'], returnFormat: "hh:mm a");
    rideCompletedAt = json['rideCompletedAt'];
    rideCompletedAtHour = json['rideCompletedAt'] == null
        ? null
        : DateTimeUtility()
        .parse(dateTime: json['rideCompletedAt'], returnFormat: "hh:mm a");
    maxDriverPrice = json['maxDriverPrice']??0.00;
    minDriverPrice = json['minDriverPrice']??0.00;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    vehicleType = json['vehicleType'] != null
        ? new VehicleType.fromJson(json['vehicleType'])
        : null;
    sceDistance = json['sceDistance'] != null
        ? new SceDistance.fromJson(json['sceDistance'])
        : null;
    destDistance = json['destDistance'] != null
        ? new SceDistance.fromJson(json['destDistance'])
        : null;
    stoppages = listFromJson(json, 'stoppages', (v) => Address.fromJson(v));
    origin = json['origin'] != null
        ? new Address.fromJson(json['origin'])
        : null;
    destination = json['destination'] != null
        ? new Address.fromJson(json['destination'])
        : null;
    isMultiStop = (stoppages?.isEmpty ?? false) ? false : true;
    driver = objectFromJson(json, 'driver', (v) => Driver.fromJson(v));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tripId'] = this.id;
    data['customerId'] = this.customerId;
    data['driverId'] = this.driverId;
    data['vehicleTypeId'] = this.vehicleTypeId;
    data['sceLat'] = this.sceLat;
    data['sceLong'] = this.sceLong;
    data['sceLocation'] = this.sceLocation;
    data['destLat'] = this.destLat;
    data['destLong'] = this.destLong;
    data['sceLocation'] = this.sceLocation;
    data['destLocation'] = this.destLocation;
    data['distance'] = this.distance;
    data['initCalcPrice'] = this.initCalcPrice;
    data['price'] = this.price;
    data['driverPrice'] = this.price;
    data['driverCharges'] = this.driverCharges;
    data['adminCharges'] = this.adminCharges;
    data['type'] = this.type;
    data['status'] = this.status;
    data['paymentMode'] = this.paymentMode;
    data['currency'] = this.currency;
    data['currencySymbol'] = this.currencySymbol;
    data['createdAt'] = this.createdAt;
    data['rideStartedAt'] = this.rideStartedAt;
    data['rideStartedAtHour'] = this.rideStartedAtHour;
    data['rideCompletedAt'] = this.rideCompletedAt;
    data['rideCompletedAtHour'] = this.rideCompletedAtHour;
    data['driverArrivedAt'] = this.driverArrivedAt;
    data['driverArrivedAtHour'] = this.driverArrivedAtHour;
    data['currencySymbol'] = this.currencySymbol;
    data['minDriverPrice'] = this.minDriverPrice??"0.00";
    data['maxDriverPrice'] = this.maxDriverPrice??"0.00";
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.vehicleType != null) {
      data['vehicleType'] = this.vehicleType!.toJson();
    }
    if (this.origin != null) {
      data['origin'] = this.origin!.toJson();
    }
    if (this.destination != null) {
      data['destination'] = this.destination!.toJson();
    }
    if (this.sceDistance != null) {
      data['sceDistance'] = this.sceDistance!.toJson();
    }
    if (this.destDistance != null) {
      data['destDistance'] = this.destDistance!.toJson();
    }
    if (this.stoppages != null) {
      data['stoppages'] = stoppages?.map((v) => v.toJson()).toList();
    } else {
      data['stoppages'] = <Address>[];
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    return data;
  }

  void update({required Trip trip}) {
    id = trip.id;
    customerId = trip.customerId;
    driverId = trip.driverId;
    vehicleTypeId = trip.vehicleTypeId;
    sceLat = trip.sceLat??sceLat;
    sceLong = trip.sceLong??sceLong;
    sceLocation = trip.sceLocation??sceLocation;
    destLat = trip.destLat??destLat;
    destLong = trip.destLong??destLong;
    destLocation = trip.destLocation??destLocation;
    distance = trip.distance??distance;
    initCalcPrice = trip.initCalcPrice??initCalcPrice;
    price = trip.price??price;
    isMultiStop = trip.isMultiStop??isMultiStop;
    driverCharges = trip.driverCharges??driverCharges;
    adminCharges = trip.adminCharges??adminCharges;
    type = trip.type??type;
    status = trip.status??status;
    paymentMode = trip.paymentMode??paymentMode;
    currency = trip.currency??currency;
    currencySymbol = trip.currencySymbol??currencySymbol;
    customer = trip.customer??customer;
    vehicleType = trip.vehicleType??vehicleType;
    sceDistance = trip.sceDistance??sceDistance;
    createdAt = trip.createdAt??createdAt;
    minDriverPrice = trip.minDriverPrice??minDriverPrice;
    maxDriverPrice = trip.maxDriverPrice??maxDriverPrice;
    stoppages = trip.stoppages??stoppages;
    destDistance = trip.destDistance??destDistance;
    origin = trip.origin??origin;
    destination = trip.destination??destination;
    driver = trip.driver??driver;
    driverArrivedAt = trip.driverArrivedAt;
    driverArrivedAtHour = trip.driverArrivedAtHour;
    rideStartedAt = trip.rideStartedAt;
    rideStartedAtHour = trip.rideStartedAtHour;
    rideCompletedAt = trip.rideCompletedAt;
    rideCompletedAtHour = trip.rideCompletedAtHour;
  }
}

class Bids {
  int? id;
  int? tripId;
  int? driverId;
  int? customerPrice;
  int? driverPrice;
  String? status;
  String? createdAt;
  String? updatedAt;
  Driver? driver;
  DriverDistance? driverDistance;

  Bids(
      {this.id,
        this.tripId,
        this.driverId,
        this.customerPrice,
        this.driverPrice,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.driver,
        this.driverDistance});

  Bids.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripId = json['tripId'];
    driverId = json['driverId'];
    customerPrice = json['customerPrice'];
    driverPrice = json['driverPrice'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    driverDistance = json['driverDistance'] != null
        ? new DriverDistance.fromJson(json['driverDistance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tripId'] = this.tripId;
    data['driverId'] = this.driverId;
    data['customerPrice'] = this.customerPrice;
    data['driverPrice'] = this.driverPrice;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    if (this.driverDistance != null) {
      data['driverDistance'] = this.driverDistance!.toJson();
    }
    return data;
  }
}

class Driver {
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
  Role? role;
  String? address;
  String? latitude;
  String? longitude;
  String? isOnline;
  DriverDocument? driverDocument;
  String? rating;

  Driver(
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
        this.profileImage,
        this.role,
        this.address,
        this.latitude,
        this.longitude,
        this.isOnline,
        this.driverDocument,
        this.rating});

  Driver.fromJson(Map<String, dynamic> json) {
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
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isOnline = json['isOnline'];
    driverDocument = json['driverDocument'] != null
        ? new DriverDocument.fromJson(json['driverDocument'])
        : null;
    rating = json['rating'];
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
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['isOnline'] = this.isOnline;
    if (this.driverDocument != null) {
      data['driverDocument'] = this.driverDocument!.toJson();
    }
    data['rating'] = this.rating;
    return data;
  }
}

class Role {
  int? id;
  String? name;
  String? slug;
  String? permissionDetails;

  Role({this.id, this.name, this.slug, this.permissionDetails});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permissionDetails = json['permissionDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['permissionDetails'] = this.permissionDetails;
    return data;
  }
}

class DriverDocument {
  int? id;
  int? userId;
  String? documentStatus;
  String? driveryType;
  IdCardDetails? idCardDetails;
  VehicleDetails? vehicleDetails;
  LicenseDetails? licenseDetails;
  ProfilePicDetails? profilePicDetails;
  InsuranceDetails? insuranceDetails;
  BankDetails? bankDetails;
  String? createdAt;
  String? updatedAt;

  DriverDocument(
      {this.id,
        this.userId,
        this.documentStatus,
        this.driveryType,
        this.idCardDetails,
        this.vehicleDetails,
        this.licenseDetails,
        this.profilePicDetails,
        this.insuranceDetails,
        this.bankDetails,
        this.createdAt,
        this.updatedAt});

  DriverDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    documentStatus = json['documentStatus'];
    driveryType = json['driveryType'];
    idCardDetails = json['idCardDetails'] != null
        ? new IdCardDetails.fromJson(json['idCardDetails'])
        : null;
    vehicleDetails = json['vehicleDetails'] != null
        ? new VehicleDetails.fromJson(json['vehicleDetails'])
        : null;
    licenseDetails = json['licenseDetails'] != null
        ? new LicenseDetails.fromJson(json['licenseDetails'])
        : null;
    profilePicDetails = json['profilePicDetails'] != null
        ? new ProfilePicDetails.fromJson(json['profilePicDetails'])
        : null;
    insuranceDetails = json['insuranceDetails'] != null
        ? new InsuranceDetails.fromJson(json['insuranceDetails'])
        : null;
    bankDetails = json['bankDetails'] != null
        ? new BankDetails.fromJson(json['bankDetails'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['documentStatus'] = this.documentStatus;
    data['driveryType'] = this.driveryType;
    if (this.idCardDetails != null) {
      data['idCardDetails'] = this.idCardDetails!.toJson();
    }
    if (this.vehicleDetails != null) {
      data['vehicleDetails'] = this.vehicleDetails!.toJson();
    }
    if (this.licenseDetails != null) {
      data['licenseDetails'] = this.licenseDetails!.toJson();
    }
    if (this.profilePicDetails != null) {
      data['profilePicDetails'] = this.profilePicDetails!.toJson();
    }
    if (this.insuranceDetails != null) {
      data['insuranceDetails'] = this.insuranceDetails!.toJson();
    }
    if (this.bankDetails != null) {
      data['bankDetails'] = this.bankDetails!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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
    vehicleCompany = json['vehicleCompany'].toString();
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
    bankId = json['bankId'].toString();
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
}

class DriverDistance {
  Distance? distance;
  Distance? duration;

  DriverDistance({this.distance, this.duration});

  DriverDistance.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance!.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    return data;
  }
}

class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  Distance.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['value'] = this.value;
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
  String? rating;

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
        this.profileImage,
        this.rating});

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
    rating = json['rating'];
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
    data['rating'] = this.rating;
    return data;
  }
}

class VehicleType {
  int? id;
  String? name;
  String? image;
  int? seatCapacity;

  VehicleType({this.id, this.name, this.image, this.seatCapacity});

  VehicleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    seatCapacity = json['seatCapacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['seatCapacity'] = this.seatCapacity;
    return data;
  }
}

class SceDistance {
  Distance? distance;
  Distance? duration;

  SceDistance({this.distance, this.duration});

  SceDistance.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? new Distance.fromJson(json['distance'])
        : null;
    duration = json['duration'] != null
        ? new Distance.fromJson(json['duration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.distance != null) {
      data['distance'] = this.distance!.toJson();
    }
    if (this.duration != null) {
      data['duration'] = this.duration!.toJson();
    }
    return data;
  }
}