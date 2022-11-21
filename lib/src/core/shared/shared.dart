import '../../features/login/domain/entities/user.dart';

 User? currentUser;
 bool shouldStayLogin=false;
String smsCode="";
int? forceResendingToken;
 String mVerificationId="";