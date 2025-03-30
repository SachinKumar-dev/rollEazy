import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/controllers/review_controller/review_controller.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/global_user.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/image_ctrl.dart';
import 'package:roll_eazy/services/api_services/api_services.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/views/auth_pages/new_auth_pages/email_verification.dart';
import 'package:roll_eazy/views/auth_pages/new_auth_pages/logIn_Screen.dart';
import 'package:roll_eazy/views/homepage/HomePage.dart';
import '../../models/user_model/user_model.dart';
import '../../services/flutter_secure_token/flutter_secure_storage.dart';
import '../../views/auth_pages/new_auth_pages/register_Screen.dart';
import '../../views/auth_pages/reset_password_page/otp_verification_screen.dart';
import '../navigation_ctrl/nav_ctrl.dart';
import '../vehicle_controller/vehicle_controller.dart';

class UserFormController extends GetxController {
  final url = Get.find<ApiServices>();
  final loggedInUser = Get.find<GlobalUserController>();
  final dio = Dio();

  RxBool otpSent = false.obs;

  //isGuestUser
  Rx<bool> isGuest = false.obs;

  //Text Controllers

  //user form
  final TextEditingController userName = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();

  //Reset password
  final TextEditingController resetEmail = TextEditingController();
  final TextEditingController verifyRegistrationEmail = TextEditingController();
  final TextEditingController OTP = TextEditingController();
  final TextEditingController registrationOTP = TextEditingController();
  final TextEditingController newPassword = TextEditingController();

  //Register
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  //LogIn
  final TextEditingController logEmail = TextEditingController();
  final TextEditingController logPassword = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController license = TextEditingController();

  //profileImage
  File? profileImage;

  //regex for gmail
  final RegExp gmailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
  );

/*----------------------------------------------Controllers-------------------------------------------------------*/
// Helper function to centralize SnackBar
  void showSnackBar(String title, String message, Color txtColor) {
    Get.back();
    Get.find<ImageController>().snackBar(title, message, txtColor: txtColor);
  }

// Register User Function
  Future<bool> registerUser() async {
    final registerUrl = url.getRegisterUrl();
    try {
      // Prepare FormData for sending files and data
      final formData = FormData.fromMap({
        'profileImage': profileImage != null
            ? await MultipartFile.fromFile(profileImage!.path)
            : null,
        'userName': userName.text.trim(),
        'email': verifyRegistrationEmail.text.trim(),
        'password': password.text.trim(),
        'gender': gender.text.trim(),
        'drivingLicense': license.text.trim(),
        'dob': dob.text.trim(),
        'mobileNumber': mobileNumber.text.trim(),
      });

      final response = await dio.post(registerUrl, data: formData);

      if (response.statusCode == 200) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        showSnackBar("Success!", "Registered successfully", Colors.white);
        //print('User registered successfully: ${response.data}');
        otpSent.value = false;
        return true;
      }
      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        // Handle specific errors based on status codes
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'An error occurred';

        switch (statusCode) {
          case 409:
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            Get.closeAllSnackbars();
            showSnackBar("Warning!", message, Colors.red);
            //print('User already exists. Status code: $statusCode');
            break;
          case 400:
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            Get.closeAllSnackbars();
            showSnackBar("Oops!",
                "Failed to upload profileImage, try again later", Colors.red);
            //print('Upload failed. Status code: $statusCode');
            break;
          case 500:
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            Get.closeAllSnackbars();
            showSnackBar(
                "Oops!", "Something went wrong, try again later", Colors.red);
            //print('Server error. Status code: $statusCode');
            break;
          default:
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            Get.closeAllSnackbars();
            showSnackBar("Error", "An unexpected error occurred", Colors.red);
            //print('Unexpected error. Status code: $statusCode');
        }
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        showSnackBar("Error", "Network error", Colors.red);
        //print('Dio error without response: ${e.message}');
      }
      return false;
    } catch (e) {
      //print('Unexpected error: $e');
      return false;
    }
  }

// Login User
  Future<bool> loginUser() async {
    final logInUrl = url.getLogInUrl();
    try {
      final response = await dio.post(
        logInUrl,
        data: {
          'email': logEmail.text.trim(),
          'password': logPassword.text.trim(),
        },
      );
      if (response.statusCode == 200) {
        String accessToken = response.data['data']['accessToken'];
        String refreshToken = response.data['data']['user']['refreshToken'];
        //need to add data to get storage for caching
        Get.find<SecureToken>().saveAccessToken(accessToken);
        Get.find<SecureToken>().saveRefreshToken(refreshToken);
        //provide data to model
        User user = User.fromJson(response.data['data']['user']);
        print(user.mobileNumber);
        //set global user
        Get.find<GlobalUserController>().setUser(user);
        update();
        await Get.find<VehicleController>().getAllVehicles();
        Get.find<GlobalUserController>().setNonGuest();
        Get.find<UserFormController>().isGuest.value = false;
        //print("from guest checking ${Get.find<UserFormController>().isGuest.value}");
        await Get.find<AuthService>().login();
        Get.find<ReviewController>().setCurrentRoute('/home');
        // await Get.find<PushNotificationController>().sendFCMToken();
        Get.to(() => const HomePage(),
            routeName: '/home', transition: Transition.rightToLeft);
        return true;
      }

        return false;

    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.statusCode);
        switch (e.response?.statusCode) {
          case 401:
            Get.closeAllSnackbars();
            showSnackBar("Warning!", "Invalid password", Colors.red);
            break;
          case 404:
            Get.closeAllSnackbars();
            showSnackBar(
                "Warning!", "User not found, register yourself", Colors.red);
            break;
          default:
            Get.closeAllSnackbars();
            showSnackBar(
                "Error!", "Something went wrong, try again later", Colors.red);
            break;
        }
        //print('Request failed with error: ${e.message}');
        return false;
      } else {
        print('Dio error without response: ${e.message}');
        Get.closeAllSnackbars();
        // Handle Dio errors where no response is returned (like timeout, network errors)
        showSnackBar("Error", "Network error", Colors.red);
        //print('Dio error without response: ${e.message}');
      }
      return false;
    } catch (e) {

      print("why me");
      print('Unexpected error: $e');
      return false;
    }
  }

  //send otp during user registration
  Future<bool> sendRegistrationOTP(String otpType) async {
    // Display a loading dialog
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loadingImg.json'),
      ),
      barrierDismissible: false,
    );

    final String sendOtpUrl = url.getSendOtpUrl();

    try {
      // Check if the email field is not empty
      if (verifyRegistrationEmail.text.trim().isEmpty) {
        _closeDialogAndShowSnackbar(
          title: "Warning!",
          message: "Email is mandatory to fill",
          color: Colors.red,
        );
        return false;
      }

      // Validate email format
      if (!gmailRegex.hasMatch(verifyRegistrationEmail.text.trim())) {
        _closeDialogAndShowSnackbar(
          title: "Warning!",
          message: "Invalid email format",
          color: Colors.red,
        );
        return false;
      }

      // Send OTP request
      final response = await dio.post(
        sendOtpUrl,
        data: {
          'email': verifyRegistrationEmail.text.trim(),
          'type': otpType,
        },
      );

      if (response.statusCode == 200) {
        _closeDialogAndShowSnackbar(
          title: "Success!",
          message: "OTP sent successfully",
          color: Colors.white,
        );
        //print("success otp sent");
        otpSent.value = true;
        return true;
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      if (e.response != null) {
        //print("Dio exception: ${e.response?.statusCode}, ${e.response?.data}");
        if (e.response?.statusCode == 404) {
          _closeDialogAndShowSnackbar(
            title: "Oops!",
            message: "Error while sending the mail",
            color: Colors.red,
          );
        } else {
          _closeDialogAndShowSnackbar(
            title: "Error!",
            message: e.response?.data['message'] ?? "Unexpected error",
            color: Colors.red,
          );
        }
      } else {
        _closeDialogAndShowSnackbar(
          title: "Network error!",
          message: "Please check internet access",
          color: Colors.red,
        );
      }
    } catch (e) {
      // Handle any other exceptions
      _closeDialogAndShowSnackbar(
        title: "Oops!",
        message: "Something went wrong: $e",
        color: Colors.red,
      );
    }

    return false;
  }

// Utility method for closing dialog and showing a snackbar
  void _closeDialogAndShowSnackbar({
    required String title,
    required String message,
    required Color color,
  }) {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
    Get.closeAllSnackbars();
    Get.find<ImageController>().snackBar(title, message, txtColor: color);
  }

  //send otp during password reset
  Future<bool> sendResetOTP(String otpType) async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loadingImg.json'),
      ),
      barrierDismissible: false,
    );
    final String sendOtpUrl = url.getSendOtpUrl();
    try {
      if (resetEmail.text.trim().isNotEmpty) {
        final response = await dio.post(
          sendOtpUrl,
          data: {'email': resetEmail.text.trim(), 'type': otpType},
        );
        if (response.statusCode == 200) {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          Get.closeAllSnackbars();
          Get.find<ImageController>().snackBar(
              "Success!", "Otp sent successfully",
              txtColor: Colors.white);
          Timer(const Duration(seconds: 2), () {
            Get.to(
                () => OTPVerificationScreen(
                      email: resetEmail.text,
                    ),
                transition: Transition.rightToLeft);
          });
          //print("success otp sent");
          return true;
        }
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Warning!", "Email is mandatory to fill",
            txtColor: Colors.red);
        return false;
      }
      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        //print("inside otp sent error status code is ${e.response?.statusCode}");
        var response = e.response?.statusCode;
        //print("errorMessage is $errorMessage");
        if (response == 404) {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          Get.closeAllSnackbars();
          Get.find<ImageController>().snackBar(
              "Warning!", "User not registered",
              txtColor: Colors.red);
          //print("user not registered unable to sent mail");
          return false;
        }
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
      return false;
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      Get.find<ImageController>()
          .snackBar("Oops!", "Something went wrong: $e", txtColor: Colors.red);
      return false;
    }
  }

  //if user exist send otp and reset the password
  Future<void> resetPassword() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loadingImg.json'),
      ),
      barrierDismissible: false,
    );
    final String resetPassword = url.getResetPasswordUrl();
    try {
      if (OTP.text.trim().isNotEmpty && newPassword.text.trim().isNotEmpty) {
        if (newPassword.text.trim().length >= 6) {
          final response = await dio.post(resetPassword, data: {
            "email": resetEmail.text.trim(),
            "user_otp": OTP.text.trim(),
            "new_password": newPassword.text.trim()
          });
          if (response.statusCode == 200) {
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
            Get.closeAllSnackbars();
            Get.find<ImageController>().snackBar(
                "Success!", "Password updated successfully",
                txtColor: Colors.white);
            Get.offAll(() => const LoginScreen());
            OTP.clear();
            newPassword.clear();
            resetEmail.clear();
            //print("success updated password");
          }
        } else {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          Get.closeAllSnackbars();
          Get.find<ImageController>()
              .snackBar("Warning!", "Weak password", txtColor: Colors.red);
          return;
        }
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Warning!", "Otp and New password are mandatory",
            txtColor: Colors.red);
        return;
      }
    } on DioException catch (exc) {
      var resStatus = exc.response?.statusCode;
      //print(resStatus);
      if (exc.response != null && resStatus == 404) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>()
            .snackBar("Warning!", "Invalid otp entered", txtColor: Colors.red);
      } else if (exc.response != null && resStatus == 401) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Oops!", "Otp expired,please resend the otp",
            txtColor: Colors.red);
        Get.offAll(() => const LoginScreen());
        resetEmail.clear();
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
    } catch (error) {
      Get.back();
      //print("something went wrong! $error");
    }
  }

  //controller to validate the user before registration
  Future<void> verifyBeforeRegistration() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loadingImg.json'),
      ),
      barrierDismissible: false,
    );
    final String emailVerify = url.getEmailVerificationUrl();
    try {
      //print(registrationOTP.text.trim());
      final response = await dio.post(emailVerify, data: {
        "email": verifyRegistrationEmail.text.trim(),
        "user_otp": registrationOTP.text.trim()
      });

      if (response.statusCode == 200) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.snackbar("Success", "Email verified successfully!",
            colorText: Colors.white,backgroundColor: darkBlue);
        otpSent.value = false;
        Get.offAll(() => const RegisterScreen());
      }
    } on DioException catch (exc) {
      var resStatus = exc.response?.statusCode;
      if (exc.response != null && resStatus == 404) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>()
            .snackBar("Warning!", "Invalid otp entered", txtColor: Colors.red);
      } else if (exc.response != null && resStatus == 401) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Oops!", "Otp expired, resend the otp",
            txtColor: Colors.red);
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
    } catch (error) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      //print("something went wrong! $error");
    }
  }

  //resend otp upon registration
  Future<void> resendOtpOne() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loadingImg.json'),
      ),
      barrierDismissible: false,
    );
    String resendUrl = url.getResendOTPUrl();
    try {
      if (verifyRegistrationEmail.text.trim().isNotEmpty) {
        final response = await dio.post(resendUrl,
            data: {"email": verifyRegistrationEmail.text.trim()});
        if (response.statusCode == 200) {
          Get.back();
          Get.snackbar("Success", "Otp sent successfully",
              colorText: Colors.white, backgroundColor: darkBlue);
        }
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.snackbar("Warning!", "Email is required",
            colorText: Colors.red, backgroundColor: darkBlue);
      }
    } on DioException catch (exc) {
      var resStatus = exc.response?.statusCode;
      //print(resStatus);
      if (exc.response != null && resStatus == 404) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Oops!", "Unable to sent otp,try again later",
            txtColor: Colors.red);
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
    } catch (error) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      //print("something went wrong! $error");
    }
  }

  //resend otp upon reset password
  Future<void> resendOtpTwo() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loadingImg.json'),
      ),
      barrierDismissible: false,
    );
    String resendUrl = url.getResendOTPUrl();
    try {
      if (resetEmail.text.trim().isNotEmpty) {
        final response =
            await dio.post(resendUrl, data: {"email": resetEmail.text.trim()});

        if (response.statusCode == 200) {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          Get.closeAllSnackbars();
          Get.snackbar("Success", "Otp sent successfully",
              colorText: Colors.white, backgroundColor: darkBlue);
        }
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.snackbar("Warning!", "Email is required",
            colorText: Colors.red, backgroundColor: darkBlue);
      }
    } on DioException catch (exc) {
      var resStatus = exc.response?.statusCode;
      //print(resStatus);
      if (exc.response != null && resStatus == 404) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Oops!", "Unable to sent otp,try again later",
            txtColor: Colors.red);
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
    } catch (error) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      //print("something went wrong! $error");
    }
  }


  //log out fun
  Future<void> logOut() async {
    Get.dialog(
      Center(child: Lottie.asset('assets/images/loadingImg.json')),
      barrierDismissible: false,
    );

    String secureUrl = url.getSecureRoutedUrl();
    String? token = await Get.find<SecureToken>().getToken();
    print(token);

    try {
      final response = await sendRequestWithToken(secureUrl, token);

      if (response.statusCode == 200) {
        Get.find<AuthService>().logout();
        await Get.find<SecureToken>().deleteToken();
        Get.offAll(() => const LoginScreen());
        return;
      }

      // Handle 404 error and attempt token refresh
      if (response.statusCode == 404) {

        bool refreshed = await refreshAccessToken();
        if (refreshed) {

          // Retry logout with new token
          token = await Get.find<SecureToken>().getToken();
          final retryResponse = await sendRequestWithToken(secureUrl, token);

          if (retryResponse.statusCode == 200) {
            Get.find<AuthService>().logout();
            await Get.find<SecureToken>().deleteToken();
            Get.offAll(() => const LoginScreen());
          }
        } else {
          performLogout();
        }
      }
    } on DioException catch (e) {
      handleError(e);
    } catch (error) {
      print(error);
    }
  }


  //Sends a request with the current token
  Future sendRequestWithToken(String url, String? token) async {
    return await dio.post(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
        validateStatus: (status) {
          return status != null;
        },
      ),
    );
  }


  //Handles token refresh when access token is expired
  Future<bool> refreshAccessToken() async {
    String regenerateTokenUrl = url.getRegenerateTokenUrl();

    try {
      final refreshToken = await Get.find<SecureToken>().getRToken();

      if (refreshToken == null) return false;

      final response = await dio.post(
        regenerateTokenUrl,
        data: {"refreshToken": refreshToken},
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );


      if (response.statusCode == 200) {
        if (response.data != null && response.data['data'] != null && response.data['data']['accessToken'] != null) {
          String newAccessToken = response.data['data']['accessToken'];
          await Get.find<SecureToken>().saveAccessToken(newAccessToken);
          return true;
        }
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        performLogout();
        return false;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  //Handles other errors
  void handleError(DioException e) {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    if (e.response?.statusCode == 401) {
      Get.closeAllSnackbars();
      showSnackBar("Warning!", "Unauthorized user", Colors.red);
    } else if (e.response?.statusCode == 407) {
      performLogout();
    } else {
      Get.closeAllSnackbars();
      showSnackBar("Oops!", "Network error", Colors.red);
    }
  }

  //Handles user logout if refresh token is invalid or expired
  Future<void> performLogout() async {
    Get.find<AuthService>().logout();
    await Get.find<SecureToken>().deleteToken();
    Get.offAll(() => const LoginScreen());
  }

  //delete account
  Future<void> deleteAccount() async {
    //Show loading dialog
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loadingImg.json'),
      ),
      barrierDismissible: false,
    );

    String deleteAccountUrl = url.getDeleteAccountRoutedUrl();
    final token = await Get.find<SecureToken>().getToken();
    try {
      // Add the token to headers for authorization
      final response = await dio.post(
        deleteAccountUrl,
        data: {"id": Get.find<GlobalUserController>().user.value?.id},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // First, check if the user is valid
      if (response.statusCode == 200) {
        // Navigate the user to the login page
        await Get.find<SecureToken>().deleteToken();
        Get.find<GlobalUserController>().clearUser();
        await Get.find<AuthService>().logout();
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        showSnackBar("Success!", "Account deleted successfully", Colors.white);
        Get.offAll(() => const LoginScreen());
      }
      if (response.statusCode == 404) {
        String? token = await Get.find<SecureToken>().getToken();
        bool refreshed = await refreshAccessToken();
        if (refreshed) {

          // Retry deletion
          token = await Get.find<SecureToken>().getToken();
          final retryResponse = await dio.post(
            deleteAccountUrl,
            data: {"id": Get.find<GlobalUserController>().user.value?.id},
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            ),
          );

          if (retryResponse.statusCode == 200) {
            Get.find<AuthService>().logout();
            await Get.find<SecureToken>().deleteToken();
            Get.offAll(() => const LoginScreen());
          }
        } else {
          performLogout();
        }
      }
    } on DioException catch (e) {
      // Handle specific status codes
      if (e.response?.statusCode != null) {
        if (e.response?.statusCode == 401) {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          Get.closeAllSnackbars();
          showSnackBar("Warning!", "Unauthorized user", Colors.red);
          return;
        }
      } else if (e.response?.statusCode == 404) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        showSnackBar("Warning!", "User not found", Colors.red);
        return;
      } else {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        showSnackBar("Oops!", "Network error", Colors.red);
        return;
      }
    } catch (error) {
      //print("Something went wrong! $error");
    }
  }

  //show delete account dialog
  void showDeleteConfirmationDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Delete Account!",
      titleStyle: GoogleFonts.poppins(
          fontSize: 15.sp, color: Colors.red, fontWeight: FontWeight.w500),
      middleText: "Are you sure you want to delete your account?",
      middleTextStyle: GoogleFonts.poppins(),
      barrierDismissible: true,
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onCancel: () => Navigator.of(context).pop(),
      onConfirm: () async {
        await deleteAccount();
      },
    );
  }

/*----------------------------------------------Validations-------------------------------------------------------*/
  //form validations
  void formValidations() {
    bool isImageSelected = Get.find<ImageController>().isImageSelected.value;
    if (userName.text.trim().isEmpty ||
        mobileNumber.text.trim().isEmpty ||
        dob.text.trim().isEmpty ||
        gender.text.trim().isEmpty ||
        license.text.trim().isEmpty) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      Get.find<ImageController>().snackBar(
          "Warning!", "All fields are mandatory",
          txtColor: Colors.red);
    } else if (license.text.trim() == "No") {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      Get.find<ImageController>().snackBar(
          "Warning!", "Driving license is mandatory",
          txtColor: Colors.red);
      return;
    } else if (isImageSelected == false) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      Get.find<ImageController>().snackBar(
          "Warning!", "Please select profile image",
          txtColor: Colors.red);
    } else {
      Get.to((const RegistrationEmailVerification()),
          transition: Transition.rightToLeft);
    }
  }

  //registration validations
  Future<void> registrationValidations() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loadingImg.json'),
      ),
      barrierDismissible: false,
    );

    if (verifyRegistrationEmail.text.trim().isEmpty ||
        password.text.trim().isEmpty ||
        confirmPassword.text.trim().isEmpty) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      Get.find<ImageController>().snackBar(
          "Warning!", "All fields are mandatory",
          txtColor: Colors.red);
    } else if (!gmailRegex.hasMatch(verifyRegistrationEmail.text.trim())) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      Get.find<ImageController>()
          .snackBar("Warning!", "Invalid email format", txtColor: Colors.red);
    } else {
      bool isCorrect = checkPassword();
      if (isCorrect) {
        if (!(password.text.trim().length >= 6)) {
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          Get.closeAllSnackbars();
          Get.find<ImageController>()
              .snackBar("Warning!", "Weak password", txtColor: Colors.red);
          return;
        }
      }
      try {
        // Wait for the registration to complete
        bool isRegistered = await registerUser();

        // Check if registration was successful
        if (isRegistered) {
          // Navigate to login page on success
          Get.to(() => const LoginScreen(), transition: Transition.rightToLeft);

          profileImage = null;
          final ImageController controller = Get.find();
          controller.isImageSelected.value = false;

          verifyRegistrationEmail.clear();
          password.clear();
          confirmPassword.clear();
          mobileNumber.clear();
          dob.clear();
          userName.clear();
        }
      } catch (error) {
        // Always close the loading dialog in case of error
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        // Show error snackbar
        Get.snackbar('Error', 'Registration failed: $error',
            colorText: Colors.red,backgroundColor: darkBlue);
      }
    }
  }

  //login validations
  Future<void> logInValidations() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loadingImg.json'),
      ),
      barrierDismissible: false,
    );
    // Input validation
    if (logEmail.text.trim().isEmpty || logPassword.text.trim().isEmpty) {
      HapticFeedback.lightImpact();
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      Get.find<ImageController>().snackBar(
        "Warning!",
        "All fields are mandatory",
        txtColor: Colors.red,
      );
      return;
    }
    if (!gmailRegex.hasMatch(logEmail.text.trim())) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      // Show the snackbar
      Get.find<ImageController>().snackBar(
        "Warning!",
        "Invalid email format",
        txtColor: Colors.red,
      );
      return;
    }

    try {
      bool isLogged = await loginUser();
      if (isLogged) {
        logEmail.clear();
        logPassword.clear();
      }
    } catch (error) {
      if (Get.isDialogOpen == true) {
        Get.back();
        Get.closeAllSnackbars();
      }
      Get.snackbar(
        'Error',
        'LogIn failed: $error',
        backgroundColor: darkBlue,
        colorText: Colors.red,
      );
    }
  }

  //password and confirmPassword validation
  bool checkPassword() {
    if (password.text.trim() != confirmPassword.text.trim()) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      Get.snackbar('Warning!', 'Password mismatched', colorText: Colors.red,backgroundColor: darkBlue);
      return false;
    }
    return true;
  }

  /*--------------------Profile Editing user details---------*/

  final TextEditingController pNumber = TextEditingController();
  final TextEditingController pName = TextEditingController();
  final TextEditingController pEmail = TextEditingController();
  final TextEditingController pDOB = TextEditingController();

  RxBool isFiled = false.obs;

  //to check whether the fields are empty or not
  void textFieldCheck() {
    pName.addListener(_checkAllFieldsFilled);
    pEmail.addListener(_checkAllFieldsFilled);
    pDOB.addListener(_checkAllFieldsFilled);
  }

  // Private function to update isFiled based on all fields
  void _checkAllFieldsFilled() {
    isFiled.value =
        pName.text.isNotEmpty || pEmail.text.isNotEmpty || pDOB.text.isNotEmpty;
  }

  //edit user details
  Future<void> updateDetails() async {
    final token = await Get.find<SecureToken>().getToken();
    final String updateUrl = url.getUpdateProfileUrl();
    // Show loading dialog
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loadingImg.json'),
      ),
      barrierDismissible: false,
    );

    try {
      // Validate email format only if email field is not empty
      if (pEmail.text.trim().isNotEmpty &&
          !gmailRegex.hasMatch(pEmail.text.trim())) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        showSnackBar("Warning!", "Invalid email format", Colors.red);
        return;
      }

      // Prepare data to send, assigning null for any empty fields
      final data = {
        'id': loggedInUser.user.value?.id,
        'username': pName.text.trim().isNotEmpty ? pName.text.trim() : null,
        'dob': pDOB.text.trim().isNotEmpty ? pDOB.text.trim() : null,
        'email': pEmail.text.trim().isNotEmpty ? pEmail.text.trim() : null,
      };
      // Make API request
      final response = await dio.post(
        updateUrl,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Handle successful response
      if (response.statusCode == 200) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        showSnackBar("Success!", "Details updated successfully", Colors.white);
        User user = User.fromJson(response.data['data']['user']);
        Get.find<GlobalUserController>().setUser(user);
        Get.find<GlobalUserController>()
            .updateUser((response.data['data']['user']));
        // Clear text fields after update
        pEmail.clear();
        pName.clear();
        pDOB.clear();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode != null) {
        if (e.response?.statusCode == 401) {
          //print('if part m ${e.response?.statusCode}');
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          Get.closeAllSnackbars();
          showSnackBar("Warning!", "Unauthorized user", Colors.red);
        }
      } else {
        //print('else part m ${e.response?.statusCode}');
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        Get.closeAllSnackbars();
        showSnackBar("Oops!", "Network error", Colors.red);
      }
    } catch (error) {
      //print"Something went wrong! $error");
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      Get.closeAllSnackbars();
      showSnackBar("Error", "Something went wrong!", Colors.red);
    }
  }
}
