import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/registration/registration_bloc.dart';
import 'package:login_registration_userinfo_bloc_firebase/bloc/registration/registration_state.dart';
import 'package:login_registration_userinfo_bloc_firebase/loginScreen.dart';
import 'package:login_registration_userinfo_bloc_firebase/style.dart';

import 'bloc/registration/registration_event.dart';
import 'helper/auth_helper.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegistrationBloc>().add(LoadDropDownList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  if (state is DropDownLoadedState) {
                    return DropdownButton<String>(
                      onChanged: (String? newValue) {
                        context.read<RegistrationBloc>().add(
                              DropdownItemSelected(newValue!),
                            );
                      },
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 35,
                      elevation: 50,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(5),
                      iconEnabledColor: Colors.black,
                      padding: EdgeInsets.all(20),
                      underline: Container(
                        width: 10,
                        height: 2,
                        color: Colors.black,
                      ),
                      value: state.selectedItem,
                      hint: Text(
                        'User Type',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      items: state.dropdownlist.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    );
                  }
                  return Text('');
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                decoration: AppInputDeceration("Email"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passController,
                decoration: AppInputDeceration("Password"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameController,
                decoration: AppInputDeceration("Name"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: ageController,
                decoration: AppInputDeceration("Age"),
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      final email = emailController.text;
                      final password = passController.text;
                      final name = nameController.text;
                      final age = ageController.text;

                      // final currentState =
                      //     context.read<RegistrationBloc>().state;
                      // String? userType;
                      //
                      // if (currentState is DropDownLoadedState) {
                      //   userType = currentState.selectedItem;
                      //   print((userType));
                      // }
                      final currentState =
                          context.read<RegistrationBloc>().state;
                      String? userType;
                      if (currentState is DropDownLoadedState) {
                        userType = currentState.selectedItem;
                      }
                      //print(userType.toString());

                      // context.read<RegistrationBloc>().add(
                      //   RegisterUser(email, name, age, password, userType),
                      // );

                      final AuthHelper obj = AuthHelper();
                      obj.Registration(
                          userType, email, name, age, password, context);
                      print('registration success');
                    },
                    child: SuccessButtonChild("Registration"),
                    style: AppButtonStyle(),
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Created an Account ?",
                            style: HeadText7(colorDarkBlue),
                          ),
                          Text(
                            " Login",
                            style: HeadText7(colorGreen),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
