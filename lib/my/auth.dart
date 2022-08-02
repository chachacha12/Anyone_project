import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'checkvalidate.dart';
import 'signup.dart';
//로그인과 회원가입을 담당하는 두 화면이 있음

//유저인증기능
final auth = FirebaseAuth.instance;

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

//로그인 시켜주는 화면
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
        title: Text('로그인'), //APP BAR 만들기
        actions: <Widget>[
          IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.star),
          ),
        ],
      ),


      body: Form(  //textformfield를 사용하기위함
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
                        autofocus: true,
                        focusNode: _emailFocusNode,
                        keyboardType: TextInputType.emailAddress, //이메일형식으로 키보드
                        onSaved: (value){
                          setState((){
                            email = value!;     //유저가 친 이메일 값을 저장해줌
                          });
                        },
                        validator: (value) => CheckValidate().validateEmail(
                            _emailFocusNode, value!),
                          autovalidateMode: AutovalidateMode.always,

                          //textInputAction: TextInputAction.next,  //해당칸을 다 입력하면 다음칸으로 바로갈수있는 버튼생성
                          onFieldSubmitted: (_){  //이메일 입력후 다음칸 누르면 비번칸에 포커스 가주도록 세팅
                          FocusScope.of(context).requestFocus(_passwordFocusNode);
                          },

                          decoration:Textfieldstyle(Icon(Icons.email), 'E-mail')
                      )
                  ),

                  //비밀번호 입려칸
                  Padding( //두번째 padding <- LIstview에 속함.
                      padding: EdgeInsets.all(16.0.h),
                      child: TextFormField(
                          onSaved: (value){
                            setState((){
                              password = value!;  //유저가 친 비번 값을 저장해줌
                            });
                          },
                          validator: (value) => CheckValidate().validatePassword(
                              _passwordFocusNode, value!),
                          autovalidateMode: AutovalidateMode.always,
                          //textInputAction: TextInputAction.next,
                          focusNode: _passwordFocusNode,

                          decoration: Textfieldstyle(Icon(Icons.lock), 'password')
                      )
                  ),

                  //로그인 버튼
                  Container( //세번째 padding
                    margin: EdgeInsets.fromLTRB(0.h, 15.h, 0.h, 7.h),
                    padding:  EdgeInsets.symmetric(horizontal: 60.0.h),
                    child: SizedBox(
                      height: 40.h,
                      child: ElevatedButton(
                        child: Text(
                          "Email 로그인",
                          style: style.copyWith(
                            color: Colors.white,),
                        ),
                        onPressed: () async {
                          //Form내부에 있는 textformfield들의 유효성 결과에 따라 성공이면 true 리턴.
                          if(formKey.currentState!.validate()){
                            // validation 이 성공하면 true 가 리턴돼요!

                            // validation 이 성공하면 폼 저장하기
                            formKey.currentState?.save();

                            Scaffold.of(context).showSnackBar(SnackBar(content:
                            Text('로그인 성공')));
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
                            'first time to do "Anyone"?  ',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            'Register',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blueAccent,
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
    );
  }
}

