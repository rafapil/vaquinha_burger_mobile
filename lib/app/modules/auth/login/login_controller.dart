import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vaquinha_burger_mobile/app/core/constants/constants.dart';
import 'package:vaquinha_burger_mobile/app/core/exceptions/user_notfound_exceptions.dart';
import 'package:vaquinha_burger_mobile/app/core/mixins/loader_mixin.dart';
import 'package:vaquinha_burger_mobile/app/core/mixins/messages_mixin.dart';
import 'package:vaquinha_burger_mobile/app/repositories/auth/auth_repository.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {
  final AuthRepository _authRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  LoginController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> login({required String email, required String password}) async {
    try {
      _loading.toggle();
      final userLogged = await _authRepository.login(email, password);

      final storage = GetStorage();
      storage.write(Constants.USER_KEY, userLogged.id);

      _loading.toggle();
    } on UserNotFoundExceptions catch (e, s) {
      _loading.toggle();
      log('Login ou senha invalidos', error: e, stackTrace: s);
      _message(MessageModel(
          title: 'Erro',
          message: 'Login ou senha invalidos',
          type: MessageType.error));
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      _message(MessageModel(
          title: 'Erro',
          message: 'Login ou senha invalidos',
          type: MessageType.error));
    }
  }
}
