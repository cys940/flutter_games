/// 모든 UseCase의 기본 인터페이스입니다.
///
/// [Type]은 반환될 데이터의 타입, [Params]는 필요한 파라미터의 타입입니다.
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

/// 아무런 파라미터가 필요 없는 UseCase를 위한 더미 클래스입니다.
class NoParams {
  const NoParams();
}
