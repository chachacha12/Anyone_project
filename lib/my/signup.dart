
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'checkvalidate.dart';


//각각의 텍스트필드마다 같은 스타일을 주기위함.  아이콘과 라벨값 빼고
Textfieldstyle(icon, labeltext){

  return InputDecoration(
    prefixIcon: icon,
    labelText: labeltext,
    helperStyle: TextStyle(color: Colors.red),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

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
        title: Text("회원가입하기"),
      ),
      body: Form(
        key: formKey2,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[

              //이메일적는 칸
              Padding(
                  padding: EdgeInsets.all(16.0.h),
                  child: TextFormField(
                      autofocus: true,
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
                      autofocus: true,
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
                      /*
                      validator: (value){
                        if(value!.isEmpty){
                          return '비밀번호를 입력하세요.';
                        }else{
                          if(passwordcheck != password){
                            return 'Passwords are not the same';
                          }else{
                            return null;
                          }
                        }
                      },
                       */

                      autovalidateMode: AutovalidateMode.always,
                      //textInputAction: TextInputAction.next,
                      focusNode: _passwordcheckFocusNode,

                      decoration: Textfieldstyle(
                          Icon(Icons.lock), 'password check')
                  )
              ),


              //회원가입 버튼
              Container(
                  margin: EdgeInsets.fromLTRB(0.h, 15.h, 0.h, 7.h),
                  padding: EdgeInsets.symmetric(horizontal: 60.0.h),
                  child: SizedBox(
                    height: 40.h,
                    child: ElevatedButton(
                      child: Text(
                        "회원가입하기",
                        style: style.copyWith(
                          color: Colors.white,),
                      ),

                      onPressed: () async {

                        //Form내부에 있는 textformfield들의 유효성 결과에 따라 성공이면 true 리턴.
                        if (formKey2.currentState!.validate()) {
                          // validation 이 성공하면 폼 저장하기
                          formKey2.currentState?.save();

                          //비번이랑 비번확인이랑 같은지 확인
                         if(password != passwordcheck){
                           _passwordcheckFocusNode.requestFocus();
                           controller.clear();
                           print('비번이랑 비번확인이 다름. 다시입력요청하기');
                          }else{
                           print('비번이랑 비번확인이 같음');
                           print(email);
                           print(password);
                         }
                          /*   이상하게 여기서만 Scaffold쓰면 에러남..이거 쓰지말기
                           Scaffold.of(context).showSnackBar(SnackBar(content:
                          Text('회원가입 성공')));
                           */
                        }
                      },
                    ),
                  )
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}