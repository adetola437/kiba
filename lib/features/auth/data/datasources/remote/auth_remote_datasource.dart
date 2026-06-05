import 'package:dartz/dartz.dart';
import '../../../../../core/api/exception/failure.dart';
import '../../models/auth_models.dart';
import '../../models/login_data.dart';


abstract class IAuthRemoteDataSource {
  Future<Either<Failure, LoginResponse>> login(String email, String password);
}
