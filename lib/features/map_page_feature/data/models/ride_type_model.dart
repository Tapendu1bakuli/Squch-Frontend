class RideTypeModel {
  String? rideTypeId;
  String? rideTypeName;
  String? icon;
  bool? isSelected;

  RideTypeModel(
      {this.rideTypeId, this.rideTypeName, this.icon, this.isSelected});

  RideTypeModel.fromJson(Map<String, dynamic> json) {
    rideTypeId = json['ride_type_id'];
    rideTypeName = json['ride_type_name'];
    icon = json['icon'];
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ride_type_id'] = this.rideTypeId;
    data['ride_type_name'] = this.rideTypeName;
    data['icon'] = this.icon;
    data['is_selected'] = this.isSelected;
    return data;
  }
}
