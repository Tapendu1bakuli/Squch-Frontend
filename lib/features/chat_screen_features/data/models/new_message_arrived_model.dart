import '../../../user_auth_feature/data/models/login_response.dart';

class NewMessageArrivedModel {
  Message? message;

  NewMessageArrivedModel({this.message});

  NewMessageArrivedModel.fromJson(Map<String, dynamic> json) {
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  int? id;
  int? inboxId;
  int? userId;
  String? senderType;
  String? message;
  String? createdAt;
  String? updatedAt;
  User? user;
  Inbox? inbox;

  Message(
      {this.id,
        this.inboxId,
        this.userId,
        this.senderType,
        this.message,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.inbox});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inboxId = json['inboxId'];
    userId = json['userId'];
    senderType = json['senderType'];
    message = json['message'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    inbox = json['inbox'] != null ? new Inbox.fromJson(json['inbox']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['inboxId'] = this.inboxId;
    data['userId'] = this.userId;
    data['senderType'] = this.senderType;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.inbox != null) {
      data['inbox'] = this.inbox!.toJson();
    }
    return data;
  }
}


class Inbox {
  int? id;
  int? tripId;
  int? driverId;
  int? customerId;
  String? lastMessage;
  String? userSeen;
  int? userUnseenNumbers;
  String? driverSeen;
  int? driverUnseenNumbers;

  Inbox(
      {this.id,
        this.tripId,
        this.driverId,
        this.customerId,
        this.lastMessage,
        this.userSeen,
        this.userUnseenNumbers,
        this.driverSeen,
        this.driverUnseenNumbers});

  Inbox.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripId = json['tripId'];
    driverId = json['driverId'];
    customerId = json['customerId'];
    lastMessage = json['lastMessage'];
    userSeen = json['userSeen'];
    userUnseenNumbers = json['userUnseenNumbers'];
    driverSeen = json['driverSeen'];
    driverUnseenNumbers = json['driverUnseenNumbers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tripId'] = this.tripId;
    data['driverId'] = this.driverId;
    data['customerId'] = this.customerId;
    data['lastMessage'] = this.lastMessage;
    data['userSeen'] = this.userSeen;
    data['userUnseenNumbers'] = this.userUnseenNumbers;
    data['driverSeen'] = this.driverSeen;
    data['driverUnseenNumbers'] = this.driverUnseenNumbers;
    return data;
  }
}
