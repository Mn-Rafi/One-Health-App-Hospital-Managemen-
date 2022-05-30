import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_health_hospital_app/logic/cubit_welcome_screen/welcomescreen_cubit.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_image_card.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_submit_button.dart';
import 'package:one_health_hospital_app/presentation/screen_register/screen_register.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import 'package:one_health_hospital_app/logic/cubit_signin_first/signinfirst_cubit.dart';
import 'package:one_health_hospital_app/logic/validation_mixin/vaidator_mixin.dart';
import 'package:one_health_hospital_app/presentation/customclasses_and_constants/custom_textformfield.dart';
import 'package:one_health_hospital_app/presentation/screen_signin_or_register/screen_signin_or_register.dart';
import 'package:one_health_hospital_app/themedata.dart';

class ScreenSignIn extends StatelessWidget {
  const ScreenSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninfirstCubit(),
      child: Container(
        decoration: kboxdecoration,
        child: SignInPageBodyWidget(),
      ),
    );
  }
}

class SignInPageBodyWidget extends StatelessWidget with TextFieldValidator {
  SignInPageBodyWidget({
    Key? key,
  }) : super(key: key);

  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  IconData hidePass = Icons.visibility_off;
  bool isObscure = true;
  bool firstTap = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              child: const ScreenSigninOrRegister(),
              type: PageTransitionType.leftToRight,
              alignment: Alignment.center),
          (route) => false,
        ).then((value) => context.read<WelcomescreenCubit>().backtoScreen());

        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                      width: 100.w,
                    ),
                    Text(
                      'Hello Again!',
                      style: mainHeaderStyle,
                    ),
                    Text(
                      'Before continue, please sign in first',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                          fontSize: 13.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: const CustomImageCard(
                        imagePath: 'images/signin.jpg',
                        ratio: 1.5,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                      child: CustomTextFormField(
                          iconData: Icons.email,
                          textController: emailController,
                          validator: (val) {
                            return isEmailValid(val);
                          },
                          hintText: 'Enter email',
                          keyBoardType: TextInputType.emailAddress),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: BlocBuilder<SigninfirstCubit, SigninfirstState>(
                        builder: (context, state) {
                          return CustomTextFormField(
                              suffixAction: () {
                                if (isObscure == true) {
                                  isObscure = false;
                                  hidePass = Icons.visibility;
                                  context
                                      .read<SigninfirstCubit>()
                                      .showPassword();
                                } else {
                                  isObscure = true;
                                  hidePass = Icons.visibility_off;
                                  context
                                      .read<SigninfirstCubit>()
                                      .hidePassword();
                                }
                              },
                              sufficiconData: hidePass,
                              nextAction: TextInputAction.done,
                              obscure: isObscure,
                              iconData: Icons.lock,
                              textController: passwordController,
                              validator: (val) {
                                return isPasswordValid(val);
                              },
                              hintText: 'Password',
                              keyBoardType: TextInputType.text);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      child: GestureDetector(
                        onTap: () {
                          if (firstTap) {
                            if (_formKey.currentState!.validate()) {
                              // print('True Ahhn Ath');
                              firstTap = false;
                            } else {
                              // print('ADA>> DETILS THETTIYEEEEEE');
                            }
                          }
                        },
                        child: CustomSubmitButton(
                            bgColor: Color(0xff5593b7), text: 'SIGN IN'),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      width: 80.w,
                      height: 2.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Divider(
                            thickness: 0.2.h,
                          ),
                          Divider(
                            thickness: 0.2.h,
                            indent: 20.w,
                            endIndent: 20.w,
                            color: isLightTheme(context)
                                ? const Color(0xffd9eaff)
                                : const Color(0xFF1D1D35),
                          ),
                          Center(
                              child: Text(
                            'Or continue with',
                            style: isLightTheme(context)
                                ? normalTextStyle.copyWith(fontSize: 11.sp)
                                : normalTextStyledark.copyWith(fontSize: 11.sp),
                          ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      child: GestureDetector(
                        // onTap: () {
                        //   if (firstTap) {
                        //     if (_formKey.currentState!.validate()) {
                        //       // print('True Ahhn Ath');
                        //       firstTap = false;
                        //     } else {
                        //       // print('ADA>> DETILS THETTIYEEEEEE');
                        //     }
                        //   }
                        // },
                        child: const CustomSubmitButton(
                            bgColor: Color.fromARGB(255, 150, 40, 60),
                            text: 'SIGN IN WITH OTP'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.h),
                      child: SizedBox(
                          width: 90.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Not a member? ',
                                style: GoogleFonts.ubuntu(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: const Screenregister(),
                                          type:
                                              PageTransitionType.rightToLeft));
                                },
                                child: Text('Register now',
                                    style: GoogleFonts.ubuntu(
                                        color: Colors.blue, fontSize: 14.sp)),
                              )
                            ],
                          )),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}