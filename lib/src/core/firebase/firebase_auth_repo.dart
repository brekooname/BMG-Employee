import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../shared/shared.dart';

class FirebaseAuthRepo {
  Future<void> sendCodeWithPhoneNumber({
    required String phoneNumber,
    required VoidCallback onSuccess,
  }) async {
    try {
      return await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        forceResendingToken: forceResendingToken,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          forceResendingToken = resendToken;
          mVerificationId = verificationId;
          onSuccess();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifySMSCode() async {
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: mVerificationId, smsCode: smsCode);
      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }
}
