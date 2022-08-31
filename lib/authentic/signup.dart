import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'checkvalidate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'login.dart';

//파베 유저인증기능에 필요한 객체
final auth = FirebaseAuth.instance;


/// 회원가입 화면
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0.sp);

  //이메일을 다 입력후 다음버튼으로 바로 비번치는칸 등 다음칸으로 이동해주기위함 + 내가만든 checkvalidate위젯에다가 보낼때 사용
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordcheckFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();

  //textformfield를 사용하기위한 유일무이한 하나의 키를 만드는 객체임
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  //사용자가 친 이름, 이메일과 비번을 저장할 state임
  var name = '';
  var email = '';
  var password = '';
  var passwordcheck = '';
  var controller = TextEditingController();  //비번입력값 != 비번확인입력값 일때 비번확인 textformfield 다 지워주기위해필요


  //각각의 텍스트필드마다 같은 스타일을 주기위함.  아이콘과 라벨값 빼고
  Textfieldstyle(icon, labeltext){
    return InputDecoration(
      prefixIcon: icon,
      labelText: labeltext,
      helperStyle: TextStyle(color: Colors.red),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.w),
      ),
    );
  }

  //스낵바 띄우기
  ShowSnackBar(text){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text), // 필수!
        // Icon 위젯도 가능해용
        duration: Duration(seconds: 3), // 얼마큼 띄울지
        // Duration 으로 시간을 정할 수 있어요
        backgroundColor: Colors.blue, // 색상 지정
      ),
    );
  }

  //파이어베이스 회원가입시켜주는 로직
  SignUp(var email, var name, var pwd) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
        email: email.toString(),
        password: pwd.toString(),
      );
      result.user?.updateDisplayName(name.toString());
      print('파베에 회원가입성공');
      ShowSnackBar('Register Successful');
      //현재 회원가입창은 꺼주기
      Navigator.pop(context);

    } catch (e) {
      print(e);
      ShowSnackBar('Register failed');
    }
  }



  //focusnode들은 state가 사라질때도 남아있는다. 그래서 따로 없애는 처리 해줘야함.
  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordcheckFocusNode.dispose();
    _nameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: formKey2,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[

                //이메일적는 칸
                Padding(
                    padding: EdgeInsets.all(16.0.h),
                    child: TextFormField(
                        //autofocus: true,
                        focusNode: _emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        //이메일형식으로 키보드
                        onSaved: (value) {
                          setState(() {
                            email = value!.trim(); //유저가 친 이메일 값을 저장해줌
                          });
                        },
                        validator: (value) =>
                            CheckValidate().validateEmail(
                                _emailFocusNode, value!.trim()),
                        autovalidateMode: AutovalidateMode.always,

                        //textInputAction: TextInputAction.next,  //해당칸을 다 입력하면 다음칸으로 바로갈수있는 버튼생성
                        onFieldSubmitted: (_) { //이메일 입력후 다음칸 누르면 비번칸에 포커스 가주도록 세팅
                          FocusScope.of(context).requestFocus(_nameFocusNode);
                        },
                        decoration: Textfieldstyle(Icon(Icons.email), 'E-mail')
                    )
                ),

                //이름적는 칸
                Padding(
                    padding: EdgeInsets.all(16.0.h),
                    child: TextFormField(
                        //autofocus: true,
                        keyboardType: TextInputType.name,
                        //이름형식으로 키보드
                        onSaved: (value) {
                          setState(() {
                            name = value!.trim(); //유저가 친 이메일 값을 저장해줌
                          });
                        },
                        validator: (value) =>
                            CheckValidate().validateName(_nameFocusNode, value!.trim()),

                        autovalidateMode: AutovalidateMode.always,

                        //textInputAction: TextInputAction.next,  //해당칸을 다 입력하면 다음칸으로 바로갈수있는 버튼생성
                        onFieldSubmitted: (_) { //이메일 입력후 다음칸 누르면 비번칸에 포커스 가주도록 세팅
                          FocusScope.of(context).requestFocus(_passwordFocusNode);
                        },

                        decoration: Textfieldstyle(
                            Icon(Icons.account_circle_sharp), 'Name')
                    )

                ),


                //비밀번호 적는칸
                Padding(
                    padding: EdgeInsets.all(16.0.h),
                    child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,  //비번적을때 *로 나오게 하는것
                        onSaved: (value) {
                          setState(() {
                            password = value!.trim(); //유저가 친 비번 값을 저장해줌
                          });
                        },
                        validator: (value) =>
                            CheckValidate().validatePassword(
                                _passwordFocusNode, value!.trim()),
                        autovalidateMode: AutovalidateMode.always,

                        onFieldSubmitted: (_) { //이메일 입력후 다음칸 누르면 비번칸에 포커스 가주도록 세팅
                          FocusScope.of(context).requestFocus(
                              _passwordcheckFocusNode);
                        },
                        //textInputAction: TextInputAction.next,
                        focusNode: _passwordFocusNode,

                        decoration: Textfieldstyle(Icon(Icons.lock), 'password')
                    )
                ),
                //비밀번호 확인 적는칸
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                        controller: controller,  //유저가 가입버튼 눌렀을때 만약 비번과 비번확인 문자가 다르면 비번확인칸 다 지워주기위해필요
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,  //비번적을때 *로 나오게 하는것
                        onSaved: (value) {
                          setState(() {
                            passwordcheck = value!.trim(); //유저가 친 비번 값을 저장해줌
                          });
                        },
                        validator: (value) =>
                            CheckValidate().validatePassword(
                                _passwordcheckFocusNode, value!.trim()),
                        autovalidateMode: AutovalidateMode.always,
                        //textInputAction: TextInputAction.next,
                        focusNode: _passwordcheckFocusNode,

                        decoration: Textfieldstyle(
                            Icon(Icons.lock), 'password check')
                    )
                ),


                //회원가입 버튼
                Container(
                    margin: EdgeInsets.fromLTRB(0.h, 15.h, 0.h, 10.h),
                    padding: EdgeInsets.symmetric(horizontal: 60.0.h),
                    child: SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        child: Text(
                          "Register",
                          style: style.copyWith(
                            color: Colors.white,),
                        ),

                        onPressed: () {
                          //Form내부에 있는 textformfield들의 유효성 결과에 따라 성공이면 true 리턴.
                          if (formKey2.currentState!.validate()) {
                            // validation 이 성공하면 폼 저장하기
                            formKey2.currentState?.save();
                            //비번이랑 비번확인이랑 같은지 확인
                           if(password != passwordcheck){
                             _passwordcheckFocusNode.requestFocus();  //textfield에 포커스주기
                             controller.clear(); //입력 지우기
                             ShowSnackBar('Password and password check input are different.');
                            }else{                          //회원가입 성공로직
                             print('비번이랑 비번확인이 같음');
                             //파베 회원가입 해주는 로직
                             SignUp(email, name, password);

                             //shared pref에 유저 정보 저장
                             //saveData(name, email);
                           }
                          }
                        },
                      ),
                    )
                ),

                //로그인페이지 이동 버튼
                GestureDetector(
                  child: Text(
                    'Go to Sign In', textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blueAccent,
                      fontSize: 14.sp,
                    ),
                  ),
                  onTap: (){           //로그인페이지 이동
                    //Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            authentic() ));
                  },
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}