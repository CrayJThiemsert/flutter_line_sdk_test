import 'dart:io';
import 'dart:ui' as ui show Gradient, TextBox, lerpDouble, Image;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:flutter_line_sdk_test/widget/dialog_widget.dart';

class LineUtils {

  BuildContext _context;

  void signIn(BuildContext context) async {
    try {
      _context = context;
      final result = await LineSDK.instance.login(
          scopes: ["profile", "openid", "email"]
      );
      // user id -> result.userProfile.userId
      // user name -> result.userProfile.displayName
      // user avatar -> result.userProfile.pictureUrl
    } on PlatformException catch (e) {
      print(e.message);
      DialogUtils().showMessageDialog(_context,
          'Sign in was failed',
          e.message,
          'Close'
      );
    }
  }

  void signOff(BuildContext context) async {
    try {
      await LineSDK.instance.logout();
    } on PlatformException catch (e) {
      print(e.message);
      DialogUtils().showMessageDialog(_context,
          'Sign off was failed',
          e.message,
          'Close'
      );
    }
  }

  void getLineUserProfile(BuildContext context) async {
    try {
      final result = await LineSDK.instance.getProfile();
      // user id -> result.userId
      // user name -> result.displayName
      // user avatar -> result.pictureUrl
    } on PlatformException catch (e) {
      print(e.message);
      DialogUtils().showMessageDialog(_context,
          'Get Line User Profile was failed',
          e.message,
          'Close'
      );
    }
  }

  void getCurrentAccessToken(BuildContext context) async {
    try {
      final result = await LineSDK.instance.currentAccessToken;
      // acceess token -> result.value
    } on PlatformException catch (e) {
      print(e.message);
      DialogUtils().showMessageDialog(_context,
          'Get Current Access Token was failed',
          e.message,
          'Close'
      );
    }

    void verifyAccessToken(BuildContext context) async {
      try {
        final result = await LineSDK.instance.verifyAccessToken();
        // result.data is accessible if the token is valid.
      } on PlatformException catch (e) {
        print(e.message);
        // token is not valid, or any other error.
        DialogUtils().showMessageDialog(_context,
            'Verify Access Token was failed',
            e.message,
            'Close'
        );
      }
    }

    void refreshAccessToken(BuildContext context) async {
      try {
        final result = await LineSDK.instance.refreshToken();
        // acceess token -> result.value
        // expires duration -> result.expiresIn
      } on PlatformException catch (e) {
        print(e.message);
        DialogUtils().showMessageDialog(_context,
            'Refresh Access Token was failed',
            e.message,
            'Close'
        );
      }
    }
  }
}