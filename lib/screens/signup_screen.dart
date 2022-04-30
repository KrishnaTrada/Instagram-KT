import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_kt/resourses/auth_methods.dart';
import 'package:instagram_kt/utils/colors.dart';
import 'package:instagram_kt/utils/utils.dart';
import 'package:instagram_kt/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);

    setState(() {
      _isLoading = false;
    });

    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // instagram logo svg
              SvgPicture.asset(
                "assets/images/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // circular avatar
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64, backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg"),
                        ),
                  Positioned(
                    bottom: -10,
                    right: 10,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: blueColor,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              //usename field
              TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: 'Enter username',
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              // email field
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your Email',
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 24,
              ),
              // password field
              TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  isPass: true),
              const SizedBox(
                height: 24,
              ),
              // bio field
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 32,
              ),
              // button
              InkWell(
                onTap: signUpUser,
                child: Container(
                  child: _isLoading 
                  ? const Center(child: CircularProgressIndicator(color : primaryColor),
                  
                  ) 
                  : const Text('Sign Up'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              // sign up text
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Already have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: (() {}),
                    child: Container(
                      child: const Text(
                        "Log in",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
