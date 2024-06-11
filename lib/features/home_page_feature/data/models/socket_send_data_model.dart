enum RideTripStatus { cancelled, arrived, started }

class SocketSendDataModel {
  String? tripId;
  String? id;
  String? bidId;
  RideTripStatus? status;
  String? rideTripStatus;
  String? cancelReason;

  SocketSendDataModel(
      {this.tripId, this.status, this.cancelReason, this.bidId, this.id,this.rideTripStatus});

  SocketSendDataModel.fromJson(Map<String, dynamic> json) {
    tripId = json['tripId'];
    id = json['id'];
    bidId = json['bidId'];
    getRideTripStatus(json['status']);
    cancelReason = json['cancelReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    setRideTripStatus(status??RideTripStatus.started);
    data['tripId'] = this.tripId;
    data['id'] = this.id;
    data['bidId'] = this.bidId;
    data['status'] = this.rideTripStatus;
    data['cancelReason'] = this.cancelReason;
    return data;
  }

  getRideTripStatus(String tripStatus) {
    switch (tripStatus) {
      case "cancelled":
        status = RideTripStatus.cancelled;
        break;
      case "arrived":
        status = RideTripStatus.arrived;
        break;
      case "started":
        status = RideTripStatus.started;
        break;
    }
  }

  setRideTripStatus(RideTripStatus tripStatus) {
    switch (tripStatus) {
      case RideTripStatus.cancelled:
        rideTripStatus = "cancelled";
        break;
      case RideTripStatus.arrived:
        rideTripStatus = "arrived";
        break;

      case RideTripStatus.started:
        rideTripStatus = "started";
        break;
    }
  }
}
