
import 'package:tanod_tractor/data/models/user_model.dart';

import '../../../../app/util/util.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../interface/iprofile_repository.dart';

class RemoteIProfileProvider extends DioBaseProvider implements IProfileRepository {

  @override
  Future<UserModel> getUserDetails() async {
    // TODO: implement getUserDetails
    try {
      var response = await dio.get(APIEndpoint.userDetail,);
      return UserModel.fromJson(response.data);
    } catch (e) {
      print("check the issue ${e.toString()}");
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }


}
