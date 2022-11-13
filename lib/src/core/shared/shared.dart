import '../../features/login/domain/entities/user.dart';

 User? currentUser;
 bool shouldStayLogin=false;
late String smsCode;
int? forceResendingToken;
 String mVerificationId="";