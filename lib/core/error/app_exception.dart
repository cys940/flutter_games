/// 앱 전체에서 사용되는 기본 예외 클래스입니다.
abstract class AppException implements Exception {
  const AppException(this.message, [this.code]);
  final String message;
  final String? code;

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// 데이터 레이어에서 발생하는 예외입니다.
class ServerException extends AppException {
  const ServerException([String message = '서버 통신 중 오류가 발생했습니다.'])
    : super(message, 'SERVER_ERROR');
}

/// 클라이언트 측 로직에서 발생하는 예외입니다.
class ClientException extends AppException {
  const ClientException([String message = '요청 처리 중 오류가 발생했습니다.'])
    : super(message, 'CLIENT_ERROR');
}

/// 데이터가 존재하지 않을 때 발생하는 예외입니다.
class NotFoundException extends AppException {
  const NotFoundException([String message = '요청한 데이터를 찾을 수 없습니다.'])
    : super(message, 'NOT_FOUND');
}
