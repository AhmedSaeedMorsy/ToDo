import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do/app/common/widget.dart';
import 'package:to_do/app/resources/color_manager.dart';
import 'package:to_do/app/resources/strings_manager.dart';
import 'package:to_do/app/resources/values_manager.dart';
import 'package:to_do/app/services/shared_prefrences/cache_helper.dart';
import 'package:to_do/presentation/login/controller/bloc.dart';
import 'package:to_do/presentation/login/controller/states.dart';

import '../../../app/resources/routes_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorManager.blue.withOpacity(
                  .1,
                ),
                ColorManager.mintGreen.withOpacity(
                  .1,
                )
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: MediaQuery.of(context).size.height / AppSize.s8,
                  bottom: MediaQuery.of(context).size.height / AppSize.s16,
                  start: MediaQuery.of(context).size.width / AppSize.s20,
                ),
                child: Text(
                  AppStrings.login,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / AppSize.s20,
                    horizontal: MediaQuery.of(context).size.width / AppSize.s12,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(
                        AppSize.s40.w,
                      ),
                      topEnd: Radius.circular(
                        AppSize.s40.w,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: MediaQuery.of(context).size.width /
                                  AppSize.s40,
                            ),
                            child: Text(
                              AppStrings.email,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s40,
                          ),
                          SharedWidget.defualtTextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: AppStrings.emailHint,
                            context: context,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppStrings.isRequired;
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: MediaQuery.of(context).size.width /
                                  AppSize.s40,
                              top: MediaQuery.of(context).size.height /
                                  AppSize.s20,
                            ),
                            child: Text(
                              AppStrings.password,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s40,
                          ),
                          SharedWidget.defualtTextFormField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return AppStrings.isRequired;
                              }
                              return null;
                            },
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: AppStrings.passwordHint,
                            context: context,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                AppSize.s20,
                          ),
                          BlocConsumer<LoginCubit, LoginStates>(
                            listener: (context, state) {
                              if (state is LoginSuccessState) {
                                CacheHelper.setData(
                                    key: SharedKey.token,
                                    value: LoginCubit.get(context)
                                        .loginModel
                                        .dataModel
                                        .token);
                                Navigator.pushNamed(
                                  context,
                                  Routes.homeRoute,
                                );
                              } else if (state is LoginErrorState) {
                                SharedWidget.toast(
                                  message: AppStrings.loginError,
                                  backgroundColor: ColorManager.red,
                                );
                              }
                            },
                            builder: (context, state) {
                              return state is LoginLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: ColorManager.darkBlue),
                                    )
                                  : SharedWidget.defualtButton(
                                      label: AppStrings.signIn,
                                      context: context,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          LoginCubit.get(context).loginUser(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }
                                      },
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
