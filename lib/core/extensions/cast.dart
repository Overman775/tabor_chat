/// Обкаст объектов
extension ObjectContextExtension on Object {
  T cast<T>() => this as T;
}
