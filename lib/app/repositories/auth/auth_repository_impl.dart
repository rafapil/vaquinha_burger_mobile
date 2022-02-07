import 'dart:developer';

import 'package:vaquinha_burger_mobile/app/core/exceptions/user_notfound_exceptions.dart';
import 'package:vaquinha_burger_mobile/app/core/rest_client/rest_client.dart';
import 'package:vaquinha_burger_mobile/app/models/user_model.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RestClient _restClient;

  AuthRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final result = await _restClient.post('/auth/register', {
      'name': name,
      'email': email,
      'password': password,
    });

    if (result.hasError) {
      var message = 'Erro ao registrar usuario';
      if (result.statusCode == 400) {
        message = result.body['error'];
      }

      log(
        message,
        error: result.statusText,
        stackTrace: StackTrace.current,
      );

      throw RestClientException(message);
    }

    return login(email, password);
  }

  @override
  Future<UserModel> login(String email, String password) async {
    final result = await _restClient.post(
      '/auth/',
      {
        'email': email,
        'password': password,
      },
    );

    if (result.hasError) {
      if (result.hashCode == 403) {
        log(
          'usuario ou senha invalidos',
          error: result.statusText,
          stackTrace: StackTrace.current,
        );

        throw UserNotFoundExceptions();
      }

      log(
        'Erro ao autenticar o usuario (${result.statusCode})',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );

      throw RestClientException('Erro ao autenticar usuario');
    }

    return UserModel.fromMap(result.body);
  }
}
