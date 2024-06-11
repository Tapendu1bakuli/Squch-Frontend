class CountryModel {
  CountryModel({
    required this.id,
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.phonecode,
    required this.currencyName,
    required this.currencySymbol,
    required this.flag,
  });
  late final int id;
  late final String name;
  late final String iso3;
  late final String iso2;
  late final String phonecode;
  late final String currencyName;
  late final String currencySymbol;
  late final String flag;

  CountryModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    iso3 = json['iso3'];
    iso2 = json['iso2'];
    phonecode = json['phonecode'];
    currencyName = json['currencyName'];
    currencySymbol = json['currencySymbol'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['iso3'] = iso3;
    _data['iso2'] = iso2;
    _data['phonecode'] = phonecode;
    _data['currencyName'] = currencyName;
    _data['currencySymbol'] = currencySymbol;
    _data['flag'] = flag;
    return _data;
  }

  CountryModel.empty(){
    id = 0;
    name = "";
    iso3 = "";
    iso2 = "";
    phonecode = "";
    currencyName = "";
    currencySymbol = "";
    flag = "";
  }
}