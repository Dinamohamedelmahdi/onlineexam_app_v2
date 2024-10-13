
import 'package:injectable/injectable.dart';
import 'package:onlineexam_app_v1/data/contracts/auth/authonlinedatasource.dart';

import '../../../domain/common/apiresults.dart';
import '../../../domain/models/user.dart';
import '../../api/apimanager.dart';
import '../../api/model/apiextensions.dart';
import '../../api/model/request/registerrequest.dart';
import '../../api/model/response/userdto.dart';

@Injectable(as:Authonlinedatasource )
class AuthOnlineDataSourceImpl implements Authonlinedatasource{
  ApiManager apiManager;

  AuthOnlineDataSourceImpl(this.apiManager);

  @override
  Future<Result<User?>> login(String email, String password) async {

    return executeApi<User?>(() async {
      var authResponse = await apiManager.login(email, password);
      var userDto = UserDto(token: authResponse?.token);
      return userDto.toUser();
    });


  }

  @override
  Future<Result<User?>> register(
      String username,
      String firstName,
      String lastName,
      String email,
      String password,
      String rePassword,
      String phone) async {
    var body = RegisterRequest(
      username: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
      rePassword: rePassword,
    );

    return executeApi<User?>(() async {
      var response = await apiManager.register(body);
      var userDto = UserDto(token: response?.token);
      return userDto.toUser();
    });

  }
}
