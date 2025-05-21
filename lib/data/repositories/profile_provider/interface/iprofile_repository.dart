


import '../../../models/user_model.dart';

abstract class IProfileRepository {

  Future<UserModel> getUserDetails() {
    throw UnimplementedError();
  }



}

