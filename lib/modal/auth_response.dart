import 'package:cached_map/cached_map.dart';
import 'package:get/get.dart';

class AuthResponse {
  String status;
  String msg;
  User user;

  AuthResponse({this.status, this.msg, this.user});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    user = json['record'] != null ? new User.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.user != null) {
      data['record'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String id;
  String name;
  String email;
  String password;
  String otp;
  String otpStatus;
  String phone;
  String deletedFlag;
  String createdDate;
  String updatedDate;
  String userId;
  RxList<Address> addresses = <Address>[].obs;

  User(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.otp,
        this.otpStatus,
        this.phone,
        this.deletedFlag,
        this.createdDate,
        this.updatedDate,
        this.userId,
        this.addresses});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    otpStatus = json['otp_status'];
    phone = json['phone'];
    deletedFlag = json['deleted_flag'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    userId = json['user_id'];
    if (json['addresses'] != null) {
      addresses.value = new List<Address>();
      json['addresses'].forEach((v) {
        addresses.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['otp_status'] = this.otpStatus;
    data['phone'] = this.phone;
    data['deleted_flag'] = this.deletedFlag;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['user_id'] = this.userId;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<User> fromCache() async{
    Mapped cacheJson = await Mapped.getInstance();
    var cachedUser = cacheJson.loadFile(cachedFileName: "user");
    print("user from cache: $cachedUser");
    if(cachedUser==null)
      return null;
    else
      return User.fromJson(cachedUser);
  }

  /// member functions

  static Future<String> saveUserToCache(User user) async{
    Mapped cacheJson = await Mapped.getInstance();
    try{
      cacheJson.saveFile(file: user.toJson(), cachedFileName: "user");
    }
    catch(e){
      return "Failed to save user due to: $e";
    }
    return "Save user to cache successfully ";
  }



  static Future<String> deleteCachedUser()async{
    Mapped cacheJson = await Mapped.getInstance();
    try{
      cacheJson.deleteFile(cachedFileName: "user");
    }
    catch(e){
      return "Some Problem accoured while deleting user File:$e";
    }
    return "Deleted user to cache successfully";

  }
}

class Address {
  String id;
  String colonyId;
  String colonyName;
  String postcode;
  String address;
  String city;
  String manualAddress;

  Address(
    {
      this.id,
      this.colonyId,
      this.colonyName,
      this.postcode,
      this.address,
      this.city,
      this.manualAddress,
    }
  );

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    colonyId = json['colony_id'];
    colonyName = json['colony_name'];
    postcode = json['postcode'];
    address = json['address'];
    city = json['city'];
    manualAddress = json['manual_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['colony_id'] = this.colonyId;
    data['colony_name'] = this.colonyName;
    data['postcode'] = this.postcode;
    data['address'] = this.address;
    data['city'] = this.city;
    data['manual_address'] = this.manualAddress;
    return data;
  }
}

