import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provider/Provider.dart';
import '../main.dart';
import 'checkvalidate.dart';
import 'signup.dart';
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
final firestore = FirebaseFirestore.instance;

//로그인 화면
class authentic extends StatefulWidget {
  const authentic({Key? key}) : super(key: key);

  @override
  State<authentic> createState() => _authenticState();
}

class _authenticState extends State<authentic> {

  var style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0.sp);

  //이메일을 다 입력후 다음버튼으로 바로 비번치는칸 등 다음칸으로 이동해주기위함
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  //textformfield를 사용하기위한 유일무이한 하나의 키를 만드는 객체임
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //사용자가 친 이메일과 비번을 저장할 state임
  var email='';
  var password='';

  //sharedpref에 유저정보 저장
  saveData(name, email) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString('name', name);
    storage.setString('email', email);
    context.read<Store1>().ChangeUserName(name);
  }


  ///직접 입력해서 하는 로그인할때마다 찜목록에 유저정보 저장
  setUserInfoData() async {
    try {
      await firestore.collection('MyList').doc(auth.currentUser?.uid).collection('UserInfo').doc(auth.currentUser?.displayName).set({'name':auth.currentUser?.displayName, 'email':auth.currentUser?.email});
      print('저장 성공');
    } catch (e) {
      print('에러');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  ///각각의 텍스트필드마다 같은 스타일을 주기위함.  아이콘과 라벨값 빼고
  Textfieldstyle(icon, labeltext){
    return InputDecoration(

      prefixIcon: Icon(icon, color: Colors.black45),
      labelText: labeltext,
      helperStyle: TextStyle(color: Colors.black),

      labelStyle: TextStyle(
          color: Colors.black45
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightGreen),
        borderRadius: BorderRadius.circular(10.w),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(10.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.w),
      ),
      enabledBorder:  OutlineInputBorder(  //유효성검사 통과했을때 박스디자인
        borderSide: BorderSide(color: Colors.lightGreen),
        borderRadius: BorderRadius.circular(10.w),
      ),
    );
  }

  ///스낵바 띄우기
  ShowSnackBar(text){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text), // 필수!
        // Icon 위젯도 가능해용
        duration: Duration(seconds: 2), // 얼마큼 띄울지
        // Duration 으로 시간을 정할 수 있어요
        backgroundColor: Colors.green, // 색상 지정
      ),
    );
  }

  //로그인해주는 로직
  LogIn(var email, var pwd) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email,
          password: pwd
      );
      //로그인 성공시

       //파베에 현재 로그인된 사용자가 있다면 (즉, 파베 로그인 성공시 shared pref에 유저정보 저장)
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        //sharedprfe에 유저정보 저장
        saveData(currentUser.displayName, currentUser.email);
        //파베 찜목록 컬렉션에 유저정보 저장
        setUserInfoData();
      }

      //ShowSnackBar('Sign In Successful');
      Navigator.pop(context);

      //메인창으로 페이지 이동
      Navigator.push(context,
          CupertinoPageRoute(builder: (c) => Main())
      );
    } catch (e) {
      print(e);
      ShowSnackBar('Sign In failed');
    }
  }


  //focusnode들은 state가 사라질때도 남아있는다. 그래서 따로 없애는 처리 해줘야함.
  @override
  void dispose() {
    super.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Sign In'), //APP BAR 만들기

      ),

      body: Container(
        color: Colors.white,
        child: Form(  //textformfield를 사용하기위함
          key: formKey,  //textformfield를 사용하기위
          child: Padding( //body는 appbar아래 화면을 지정.
            padding: EdgeInsets.all(8.0.h),
            child: Center( //가운데로 지정
              child: ListView( //ListView - children으로 여러개 padding설정
                  shrinkWrap: true,
                  children: <Widget>[

                    //이메일을 입력하는 칸
                    Padding(
                        padding:  EdgeInsets.all(16.0.h),
                        child: TextFormField(
                          //autofocus: true,
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress, //이메일형식으로 키보드
                          onSaved: (value){
                            setState((){
                              email = value!.trim();     //유저가 친 이메일 값을 저장해줌. 앞뒤공백잘라서
                            });
                          },
                          validator: (value) => CheckValidate().validateEmail(
                              _emailFocusNode, value!.trim()),
                             autovalidateMode: AutovalidateMode.always,

                            //textInputAction: TextInputAction.next,  //해당칸을 다 입력하면 다음칸으로 바로갈수있는 버튼생성
                            onFieldSubmitted: (_){  //이메일 입력후 다음칸 누르면 비번칸에 포커스 가주도록 세팅
                            FocusScope.of(context).requestFocus(_passwordFocusNode);
                            },
                            decoration:Textfieldstyle(Icons.email, 'E-mail')
                        )
                    ),

                    //비밀번호 입려칸
                    Padding( //두번째 padding <- LIstview에 속함.
                        padding: EdgeInsets.all(16.0.h),
                        child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,  //비번적을때 *로 나오게 하는것
                            onSaved: (value){
                              setState((){
                                password = value!.trim();  //유저가 친 비번 값을 저장해줌
                              });
                            },
                            validator: (value) => CheckValidate().validatePassword(
                                _passwordFocusNode, value!.trim()),
                            autovalidateMode: AutovalidateMode.always,  //유효성 항상 검사
                            //textInputAction: TextInputAction.next,
                            focusNode: _passwordFocusNode,

                            decoration: Textfieldstyle(Icons.lock, 'password')
                        )
                    ),

                    //로그인 버튼
                    Container( //세번째 padding
                      margin: EdgeInsets.fromLTRB(0.h, 15.h, 0.h, 7.h),
                      padding:  EdgeInsets.symmetric(horizontal: 60.0.h),
                      child: SizedBox(
                        height: 40.h,
                        child: ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                            primary: Colors.green
                           ),
                          child: Text(
                            "Sign In",
                            style: style.copyWith(
                              color: Colors.white,),
                          ),
                          onPressed: () {
                            //Form내부에 있는 textformfield들의 유효성 결과에 따라 성공이면 true 리턴.
                            if(formKey.currentState!.validate()){
                              // validation 이 성공하면 true 가 리턴돼요!
                              // validation 이 성공하면 폼 저장하기
                              formKey.currentState?.save();
                              //로그인 로직시작
                              LogIn(email, password);
                            }
                          },
                        ),
                      )
                    ),
                    SizedBox(height: 10.h), //View같은 역할 중간에 띄는 역할
                    Center( //Center <- Listview
                      child: InkWell( //InkWell을 사용 -- onTap이 가능한 이유임.
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'first time to visit "Anyone"?  ',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              'Register',
                              style: TextStyle(
                                //decoration: TextDecoration.underline,
                                color: Colors.green,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}

