
import 'dart:convert';

import '../../../../app/util/util.dart';
import '../../../../main.dart';
import '../../../models/admin_static_detail_model.dart';
import '../../../models/static_model.dart';
import '../../../models/success_model.dart';
import '../../../providers/network/api_endpoint.dart';
import '../../../providers/network/dio_base_provider.dart';
import '../../../providers/network/dio_exceptions.dart';
import '../../../providers/network/local_keys.dart';
import '../interface/static_repository.dart';

class RemoteStaticProvider extends DioBaseProvider implements IStaticRepository {

  @override
  Future<StaticPageModel> getAllStaticList({map}) async {
    // TODO: implement getAllStaticList
    try {
      dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": box.read(tokenKeys)!=null?"Bearer ${box.read(tokenKeys)}":null
      };
      var response = await dio.get(APIEndpoint.pageList);
      return StaticPageModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }



  @override
  Future<SuccessModel> deletePageState({map}) async {
    // TODO: implement deleteDevice
    try {
      var response = await dio.post(APIEndpoint.deletePage,data: jsonEncode(map));
      return SuccessModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }




  @override
  Future<AdminStaticDetailModel> pageDetails({map}) async {
    // TODO: implement addNewDevices
    try {
      var response = await dio.get(APIEndpoint.pageDetails,queryParameters:map);
      return AdminStaticDetailModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }

  @override
  Future<AdminStaticDetailModel> updateStaticPage({map}) async {
    // TODO: implement createNewPage
    try {
      var response = await dio.post(APIEndpoint.updatePage,data:jsonEncode(map));
      return AdminStaticDetailModel.fromJson(response.data);
    } catch (e) {
      showToast(message: NetworkExceptions.getDioException(e));
      rethrow;
    }
  }





}
