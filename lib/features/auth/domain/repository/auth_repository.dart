import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();
}















/*

abstract class Auth {} 
	•	Can be extended (inherit implementation) and implemented (just take its API) by subclasses.
	•	Subclasses can choose  extends Auth  or  implements Auth .
  
abstract interface class Auth {} 
	•	Is treated as a pure interface-like contract.
	•	Other types are required to use  implements Auth  rather than  extends Auth  (unless they are also marked appropriately).
	•	This enforces “no implementation inheritance”, only contract inheritance
  . we need abstract before interface because its contains unimplemeted methods because interface contains declarations without implementations.

*/


  