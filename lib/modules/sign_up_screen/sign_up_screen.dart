
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kinda_chees/modules/Login_screen/login_screen.dart';
import 'package:kinda_chees/shared/components/components.dart';
import 'package:kinda_chees/styles/colors/colors.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SignUpScreen extends StatelessWidget {
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
         /*if(state is SignUpSuccessState){
            navigateAndFinish(context, LoginScreen());
          }*/
        },
        builder: (context, state) {
          var profileImage=SignUpCubit.get(context).profileImage;
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 1.3,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: WaveWidget(
                        config: CustomConfig(
                          gradients: [
                            [Colors.teal,Colors.teal],
                            [Colors.tealAccent,Colors.green[100]],
                          ],
                          durations: [19440, 10800],
                          heightPercentages: [0.20, 0.25],
                          blur: MaskFilter.blur(BlurStyle.solid, 10),
                          gradientBegin: Alignment.bottomLeft,
                          gradientEnd: Alignment.topRight,
                        ),
                        waveAmplitude: 0,
                        size: Size(
                          double.infinity,
                          double.infinity,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50,),
                        Center(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                                  radius: 60,
                                  backgroundColor: ColorsConsts.backgroundColor,
                                ),
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                   // ChatAppCubit.get(context).getProfileImage();
                                  },
                                  icon: Icon(
                                    Feather.camera,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                backgroundColor: Colors.teal,
                                radius: 18,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: defaultFormField(
                              type: TextInputType.text,
                              controller: nameController,
                              onSubmit: (){},
                              prefix: Icons.person,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'الاسم الذي ادخلته غير صالح';
                                }
                                return null;
                              },
                              context: context,
                              labelText: 'ادخل اسمك'
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: defaultFormField(
                              type: TextInputType.emailAddress,
                              controller: emailController,
                              onSubmit: (){},
                              prefix: Icons.email,
                              validate: (String value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'بريد الكتروني غير صالح';
                                }
                                return null;
                              },
                              context: context,
                              labelText: 'ادخل البريد الالكتروني'
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: defaultFormField(
                              type: TextInputType.phone,
                              controller: phoneController,
                              onSubmit: (){},
                              prefix: Icons.phone,
                              validate: (String value) {
                                if (value.isEmpty || value.length < 10) {
                                  return 'رقم هاتف غير صالح';
                                }
                                return null;
                              },
                              context: context,
                              labelText: 'ادخل رقم هاتفك'
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: defaultFormField(
                              type: TextInputType.visiblePassword,
                              controller: passwordController,
                              onSubmit: (){},
                              prefix: Icons.lock,
                              validate: (String value) {
                                if (value.isEmpty || value.length < 7) {
                                  return 'كلمه المرور غير صالحه';
                                }
                                return null;
                              },
                              isPassword: SignUpCubit.get(context).isPasswordShown,
                              suffixPressed: () {
                                SignUpCubit.get(context).changePasswordVisibility();
                              },
                              suffix: SignUpCubit.get(context).suffix,
                              context: context,
                              labelText: 'ادخل كلمه المرور'
                          ),
                        ),
                        SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition: state is! SignUpLoadingState,
                          builder: (context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              side: BorderSide(
                                                  color: ColorsConsts.backgroundColor),
                                            ),
                                          )),
                                      onPressed: (){
                                      /*  if(formKey.currentState.validate()){
                                          SignUpCubit.get(context).userSignUp(
                                              name: nameController.text,
                                              password: passwordController.text,
                                              phone:  phoneController.text,
                                              email: emailController.text,
                                          );
                                        }*/
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'تسجيل',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Icon(
                                            Feather.user_plus,
                                            size: 18,
                                          )
                                        ],
                                      )),
                                  width: 130,
                                ),
                                SizedBox(width: 20),
                              ],
                            );
                          },
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
