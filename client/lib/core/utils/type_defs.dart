import 'package:fpdart/fpdart.dart';
import 'package:testing_app_with_mvvm/core/utils/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
