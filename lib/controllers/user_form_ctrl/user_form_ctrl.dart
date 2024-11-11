import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/global_user.dart';
import 'package:roll_eazy/controllers/user_form_ctrl/image_ctrl.dart';
import 'package:roll_eazy/services/api_services/api_services.dart';
import 'package:roll_eazy/utility/color_helper/color_helper.dart';
import 'package:roll_eazy/views/auth_pages/login_page/login_page.dart';
import 'package:roll_eazy/views/auth_pages/registration_page/email_verification.dart';
import 'package:roll_eazy/views/homepage/home_screen.dart';
import '../../models/user_model/user_model.dart';
import '../../models/vehicle_model/vehicle_model.dart';
import '../../services/flutter_secure_token/flutter_secure_storage.dart';
import '../../views/auth_pages/registration_page/register_page.dart';
import '../../views/auth_pages/reset_password_page/otp_verification_screen.dart';

class UserFormController extends GetxController {
  final url = Get.find<ApiServices>();
  final loggedInUser = Get.find<GlobalUserController>();
  final dio = Dio();

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
        Get.back();
        showSnackBar("Success!", "Registered successfully", greenTextColor);
        print('User registered successfully: ${response.data}');
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
          case 409: // Conflict - User already exists
            showSnackBar("Warning!", message, Colors.red);
            print('User already exists. Status code: $statusCode');
            break;
          case 400: // Bad Request - Upload failed
            showSnackBar("Oops!",
                "Failed to upload profileImage, try again later", Colors.red);
            print('Upload failed. Status code: $statusCode');
            break;
          case 500: // Server error
            showSnackBar(
                "Oops!", "Something went wrong, try again later", Colors.red);
            print('Server error. Status code: $statusCode');
            break;
          default: // Handle unexpected errors
            showSnackBar("Error", "An unexpected error occurred", Colors.red);
            print('Unexpected error. Status code: $statusCode');
        }
      } else {
        // Handle Dio errors where no response is returned (like timeout, network errors)
        showSnackBar("Error", "Network error", Colors.red);
        print('Dio error without response: ${e.message}');
      }
      return false;
    } catch (e) {
      // Handle any other unexpected errors that are not caught by DioException
      print('Unexpected error: $e');
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
      // Handle successful response (statusCode 200) in the try block
      if (response.statusCode == 200) {
        String accessToken = response.data['data']['accessToken'];
        //need to add data to get storage for caching
        //Get.find<GlobalUserController>().setToken(accessToken);
        Get.find<SecureToken>().saveToken(accessToken);
        //provide data to model
        User user = User.fromJson(response.data['data']['user']);
        //set global user
        Get.find<GlobalUserController>().setUser(user);
        update();
        Get.back();
        Get.to(() => const HomePage(), transition: Transition.rightToLeft);
        return true;
      }
      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.statusCode);
        switch (e.response?.statusCode) {
          case 401:
            showSnackBar("Warning!", "Invalid password", Colors.red);
            break;
          case 404:
            showSnackBar(
                "Warning!", "User not found, register yourself", Colors.red);
            break;
          default:
            showSnackBar(
                "Error!", "Something went wrong, try again later", Colors.red);
            break;
        }
        print('Request failed with error: ${e.message}');
        return false;
      } else {
        // Handle Dio errors where no response is returned (like timeout, network errors)
        showSnackBar("Error", "Network error", Colors.red);
        print('Dio error without response: ${e.message}');
      }
      return false;
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }

  RxBool otpSent = false.obs;

  //send otp during user registration
  Future<bool> sendRegistrationOTP(String otpType) async {
    //need to check first the email format too
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loading.json'),
      ),
      barrierDismissible: false,
    );
    final String sendOtpUrl = url.getSendOtpUrl();
    try {
      if (verifyRegistrationEmail.text.trim().isNotEmpty) {
        if (gmailRegex.hasMatch(verifyRegistrationEmail.text.trim())) {
          final response = await dio.post(
            sendOtpUrl,
            data: {
              'email': verifyRegistrationEmail.text.trim(),
              'type': otpType
            },
          );
          if (response.statusCode == 200) {
            Get.back();
            Get.find<ImageController>().snackBar(
                "Success!", "Otp sent successfully",
                txtColor: greenTextColor);
            print("success otp sent");
            otpSent.value = true;
            return true;
          }
        } else {
          showSnackBar("Warning!", "Invalid email format", Colors.red);
          return false;
        }
      } else {
        Get.back();
        Get.find<ImageController>().snackBar(
            "Warning!", "Email is mandatory to fill",
            txtColor: Colors.red);
        return false;
      }
      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        print("inside otp sent error status code is ${e.response?.statusCode}");
        var response = e.response?.statusCode;
        var errorMessage = e.response?.data['message'];
        print("errorMessage is $errorMessage");
        if (response == 404) {
          Get.back();
          Get.find<ImageController>().snackBar(
              "Oops!", "Error while sending the mail",
              txtColor: Colors.red);
          print("Error while sending the mail");
          return false;
        }
      } else {
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
      return false;
    } catch (e) {
      Get.back();
      Get.find<ImageController>()
          .snackBar("Oops!", "Something went wrong: $e", txtColor: Colors.red);
      return false;
    }
  }

  //send otp during password reset
  Future<bool> sendResetOTP(String otpType) async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loading.json'),
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
          Get.back();
          Get.find<ImageController>().snackBar(
              "Success!", "Otp sent successfully",
              txtColor: greenTextColor);
          Timer(const Duration(seconds: 2), () {
            Get.to(
                () => OTPVerificationScreen(
                      email: resetEmail.text,
                    ),
                transition: Transition.rightToLeft);
          });
          print("success otp sent");
          return true;
        }
      } else {
        Get.back();
        Get.find<ImageController>().snackBar(
            "Warning!", "Email is mandatory to fill",
            txtColor: Colors.red);
        return false;
      }
      return false;
    } on DioException catch (e) {
      if (e.response != null) {
        print("inside otp sent error status code is ${e.response?.statusCode}");
        var response = e.response?.statusCode;
        var errorMessage = e.response?.data['message'];
        print("errorMessage is $errorMessage");
        if (response == 404) {
          Get.back();
          Get.find<ImageController>().snackBar(
              "Warning!", "User not registered",
              txtColor: Colors.red);
          print("user not registered unable to sent mail");
          return false;
        }
      } else {
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
      return false;
    } catch (e) {
      Get.back();
      Get.find<ImageController>()
          .snackBar("Oops!", "Something went wrong: $e", txtColor: Colors.red);
      return false;
    }
  }

  //if user exist send otp and reset the password
  Future<void> resetPassword() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loading.json'),
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
            Get.back();
            Get.find<ImageController>().snackBar(
                "Success!", "Password updated successfully",
                txtColor: greenTextColor);
            Get.offAll(() => const LogInPage());
            OTP.clear();
            newPassword.clear();
            resetEmail.clear();
            print("success updated password");
          }
        } else {
          Get.back();
          Get.find<ImageController>()
              .snackBar("Warning!", "Weak password", txtColor: Colors.red);
          return;
        }
      } else {
        Get.back();
        Get.find<ImageController>().snackBar(
            "Warning!", "Otp and New password are mandatory",
            txtColor: Colors.red);
        return;
      }
    } on DioException catch (exc) {
      var resStatus = exc.response?.statusCode;
      print(resStatus);
      if (exc.response != null && resStatus == 404) {
        Get.back();
        Get.find<ImageController>()
            .snackBar("Warning!", "Invalid otp entered", txtColor: Colors.red);
      } else if (exc.response != null && resStatus == 401) {
        Get.find<ImageController>().snackBar(
            "Oops!", "Otp expired, resend the otp",
            txtColor: Colors.red);
        Get.offAll(() => const LogInPage());
        resetEmail.clear();
      } else {
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
    } catch (error) {
      Get.back();
      print("something went wrong! $error");
    }
  }

  //controller to validate the user before registration
  Future<void> verifyBeforeRegistration() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loading.json'),
      ),
      barrierDismissible: false,
    );
    final String emailVerify = url.getEmailVerificationUrl();
    try {
      print(registrationOTP.text.trim());
      final response = await dio.post(emailVerify, data: {
        "email": verifyRegistrationEmail.text.trim(),
        "user_otp": registrationOTP.text.trim()
      });

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Email verified successfully!",
            colorText: greenTextColor);
        Get.offAll(() => const RegisterPage());
      }
    } on DioException catch (exc) {
      var resStatus = exc.response?.statusCode;
      print(resStatus);
      if (exc.response != null && resStatus == 404) {
        print("invalid otp $resStatus");
        Get.back();
        Get.find<ImageController>()
            .snackBar("Warning!", "Invalid otp entered", txtColor: Colors.red);
      } else if (exc.response != null && resStatus == 401) {
        Get.find<ImageController>().snackBar(
            "Oops!", "Otp expired, resend the otp",
            txtColor: Colors.red);
      } else {
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
    } catch (error) {
      Get.back();
      print("something went wrong! $error");
    }
  }

  //resend otp upon registration
  Future<void> resendOtpOne() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loading.json'),
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
              colorText: greenTextColor);
        }
      } else {
        Get.back();
        Get.snackbar("Warning!", "Email is required", colorText: Colors.red);
      }
    } on DioException catch (exc) {
      var resStatus = exc.response?.statusCode;
      print(resStatus);
      if (exc.response != null && resStatus == 404) {
        Get.back();
        Get.find<ImageController>().snackBar(
            "Oops!", "Unable to sent otp,try again later",
            txtColor: Colors.red);
      } else {
        Get.back();
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
    } catch (error) {
      Get.back();
      print("something went wrong! $error");
    }
  }

  //resend otp upon reset password
  Future<void> resendOtpTwo() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loading.json'),
      ),
      barrierDismissible: false,
    );
    String resendUrl = url.getResendOTPUrl();
    try {
      if (resetEmail.text.trim().isNotEmpty) {
        final response =
            await dio.post(resendUrl, data: {"email": resetEmail.text.trim()});

        if (response.statusCode == 200) {
          Get.back();
          Get.snackbar("Success", "Otp sent successfully",
              colorText: greenTextColor);
        }
      } else {
        Get.back();
        Get.snackbar("Warning!", "Email is required", colorText: Colors.red);
      }
    } on DioException catch (exc) {
      var resStatus = exc.response?.statusCode;
      print(resStatus);
      if (exc.response != null && resStatus == 404) {
        Get.back();
        Get.find<ImageController>().snackBar(
            "Oops!", "Unable to sent otp,try again later",
            txtColor: Colors.red);
      } else {
        Get.find<ImageController>().snackBar(
            "Network error!", "Please check internet access",
            txtColor: Colors.red);
      }
    } catch (error) {
      Get.back();
      print("something went wrong! $error");
    }
  }

  // Controller to log out the user
  Future<void> logOut() async {
    print("inisde log out fun");
    // Show loading dialog
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loading.json'),
      ),
      barrierDismissible: false,
    );
    String secureUrl = url.getSecureRoutedUrl();
    final token = await Get.find<SecureToken>().getToken();
    print('token is during logout $token');
    try {
      // Add the token to headers for authorization
      final response = await dio.post(
        secureUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // First, check if the user is valid
      if (response.statusCode == 200) {
        Get.offAll(() => const LogInPage());
      }
    } on DioException catch (e) {
      print("excpn");
      // Handle specific status codes
      if (e.response?.statusCode != null) {
        if (e.response?.statusCode == 401) {
          showSnackBar("Warning!", "Unauthorized user", Colors.red);
          return;
        }
      } else {
        showSnackBar("Oops!", "Network error", Colors.red);
        return;
      }
    } catch (error) {
      print("Something went wrong! $error");
    }
  }

  //delete account
  Future<void> deleteAccount() async {
    //Show loading dialog
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loading.json'),
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
        ),
      );

      // First, check if the user is valid
      if (response.statusCode == 200) {
        // Navigate the user to the login page
        showSnackBar(
            "Success!", "Account deleted successfully", greenTextColor);
        Get.offAll(() => const LogInPage());
      }
    } on DioException catch (e) {
      // Handle specific status codes
      if (e.response?.statusCode != null) {
        if (e.response?.statusCode == 401) {
          showSnackBar("Warning!", "Unauthorized user", Colors.red);
          return;
        }
      } else if (e.response?.statusCode == 404) {
        showSnackBar("Warning!", "User not found", Colors.red);
        return;
      } else {
        showSnackBar("Oops!", "Network error", Colors.red);
        return;
      }
    } catch (error) {
      print("Something went wrong! $error");
    }
  }

  //show delete account dialog
  void showDeleteConfirmationDialog() {
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
      onCancel: () => Get.back(),
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
      Get.find<ImageController>().snackBar(
          "Warning!", "All fields are mandatory",
          txtColor: Colors.red);
    } else if (license.text.trim() == "No") {
      Get.find<ImageController>().snackBar(
          "Warning!", "Driving license is mandatory",
          txtColor: Colors.red);
      return;
    } else if (isImageSelected == false) {
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
        child: Lottie.asset('assets/images/loading.json'),
      ),
      barrierDismissible: false,
    );

    if (verifyRegistrationEmail.text.trim().isEmpty ||
        password.text.trim().isEmpty ||
        confirmPassword.text.trim().isEmpty) {
      Get.back();
      Get.find<ImageController>().snackBar(
          "Warning!", "All fields are mandatory",
          txtColor: Colors.red);
    } else if (!gmailRegex.hasMatch(verifyRegistrationEmail.text.trim())) {
      Get.back();
      Get.find<ImageController>()
          .snackBar("Warning!", "Invalid email format", txtColor: Colors.red);
    } else {
      bool isCorrect = checkPassword();
      if (isCorrect) {
        if (!(password.text.trim().length >= 6)) {
          Get.back();
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
          Get.to(() => const LogInPage(), transition: Transition.rightToLeft);

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
        Get.back();
        // Show error snackbar
        Get.snackbar('Error', 'Registration failed: $error',
            colorText: Colors.red);
      }
    }
  }

  //login validations
  Future<void> logInValidations() async {
    Get.dialog(
      Center(
        child: Lottie.asset('assets/images/loading.json'),
      ),
      barrierDismissible: false,
    );
    if (logEmail.text.trim().isEmpty || logPassword.text.trim().isEmpty) {
      HapticFeedback.lightImpact();
      Get.back();
      Get.find<ImageController>().snackBar(
          "Warning!", "All fields are mandatory",
          txtColor: Colors.red);
    } else if (!gmailRegex.hasMatch(logEmail.text.trim())) {
      Get.back();
      Get.find<ImageController>()
          .snackBar("Warning!", "Invalid email format", txtColor: Colors.red);
    } else {
      try {
        // Wait for the registration to complete
        bool isLogged = await loginUser();

        if (isLogged) {
          logEmail.clear();
          logPassword.clear();
        }
      } catch (error) {
        // Always close the loading dialog in case of error
        Get.back();
        // Show error snackbar
        Get.snackbar('Error', 'LogIn failed: $error',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  //password and confirmPassword validation
  bool checkPassword() {
    if (password.text.trim() != confirmPassword.text.trim()) {
      Get.back();
      Get.snackbar('Warning!', 'Password mismatched', colorText: Colors.red);
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
        child: Lottie.asset('assets/images/loading.json'),
      ),
      barrierDismissible: false,
    );

    try {
      // Validate email format only if email field is not empty
      if (pEmail.text.trim().isNotEmpty &&
          !gmailRegex.hasMatch(pEmail.text.trim())) {
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
        showSnackBar(
            "Success!", "Details updated successfully", greenTextColor);
        User user = User.fromJson(response.data['data']['user']);
        Get.find<GlobalUserController>().setUser(user);
        // Clear text fields after update
        pEmail.clear();
        pName.clear();
        pDOB.clear();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode != null) {
        if (e.response?.statusCode == 401) {
          print('if part m ${e.response?.statusCode}');
          showSnackBar("Warning!", "Unauthorized user", Colors.red);
        }
      }
      else {
        print('else part m ${e.response?.statusCode}');
        showSnackBar("Oops!", "Network error", Colors.red);
      }
    } catch (error) {
      print("Something went wrong! $error");
      showSnackBar("Error", "Something went wrong!", Colors.red);
    }
  }
}
