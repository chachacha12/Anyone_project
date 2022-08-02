
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


//유저인증기능
final auth = FirebaseAuth.instance;

//회원가입 및 로그인 시켜주는 화면
class authentic extends StatefulWidget {
  const authentic({Key? key}) : super(key: key);

  @override
  State<authentic> createState() => _authenticState();
}

//각각의 텍스트필드마다 같은 스타일을 주기위함.  아이콘과 라벨값 빼고
Textfieldstyle(icon, labeltext, helpertext){

  return InputDecoration(
    prefixIcon: icon,
    labelText: labeltext,
    helperText: helpertext,
    helperStyle: TextStyle(color: Colors.red),

    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
    ),
    disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.lightGreen
        )
    ),
    errorBorder:OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.red
        )
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.green
        )
    ),
  );
}

class _authenticState extends State<authentic> {

  var inputData = {'이메일':'', '비밀번호':'' }; //유저가 텍스트필드에 쓰는 값들을 맵 형태로 저장
  var style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0.sp);

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



      body: Padding( //body는 appbar아래 화면을 지정.
        padding: EdgeInsets.all(8.0.h),
        child: Center( //가운데로 지정
          child: ListView( //ListView - children으로 여러개 padding설정
            shrinkWrap: true,
            children: <Widget>[

              //이메일을 입력하는 칸
              Padding(
                  padding:  EdgeInsets.all(16.0.h),
                  child: TextField(
                    autofocus: true,
                    onChanged: (text) {
                      inputData['이메일'] = text;
                    },
                    decoration: Textfieldstyle(Icon(Icons.email), 'E-mail','')
                  )
              ),

              //비밀번호 입려칸
              Padding( //두번째 padding <- LIstview에 속함.
                  padding: EdgeInsets.all(16.0.h),
                  child: TextField(
                      autofocus: true,
                    onChanged: (text) {
                      inputData['비밀번호'] = text;
                    },
                      decoration: Textfieldstyle(Icon(Icons.lock), 'password','*6자이상')
                  )
              ),

              //로그인 버튼
              Container( //세번째 padding
                margin: EdgeInsets.fromLTRB(0.h, 15.h, 0.h, 7.h),
                padding:  EdgeInsets.symmetric(horizontal: 60.0.h),
                child: SizedBox(
                  height: 35.h,
                  child: ElevatedButton(
                    child: Text(
                      "Email 로그인",
                      style: style.copyWith(
                        color: Colors.white,),
                    ),
                    onPressed: (){

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
    );
  }
}


/// 회원가입 화면
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var inputData2 = {'이메일':'', '비밀번호':'', '비밀번호확인':''}; //유저가 텍스트필드에 쓰는 값들을 맵 형태로 저장
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0.sp);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("계정 만들기"),
      ),
      body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[

              //이메일적는 칸
              Padding(
                padding: EdgeInsets.all(16.0.h),
                child: TextField(
                    autofocus: true,
                  onChanged: (text) {
                    inputData2['이메일'] = text;
                  },
                    decoration: Textfieldstyle(Icon(Icons.email), 'E-mail','')
                )

              ),

              //이름적는 칸
              Padding(
                  padding: EdgeInsets.all(16.0.h),
                  child: TextField(
                      autofocus: true,
                      onChanged: (text) {
                        inputData2['이름'] = text;
                      },
                      decoration: Textfieldstyle(Icon(Icons.account_circle_sharp), 'Name','write your fullname')
                  )

              ),

              //비밀번호 적는칸
              Padding(
                padding: EdgeInsets.all(16.0.h),
                child: TextField(
                    autofocus: true,
                  onChanged: (text) {
                    inputData2['비밀번호'] = text;
                  },
                    decoration: Textfieldstyle(Icon(Icons.lock), 'Password','*6자이상')
                )
              ),


              //비밀번호 확인 적는칸
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                    autofocus: true,
                  onChanged: (text) {
                    inputData2['비밀번호확인'] = text;
                  },
                 decoration: Textfieldstyle(Icon(Icons.lock), 'Password check','')
                )


              ),

              //회원가입 버튼
              Container(
                margin: EdgeInsets.fromLTRB(0.h, 15.h, 0.h, 7.h),
                padding: EdgeInsets.symmetric(horizontal: 60.0.h),
                child: SizedBox(
                  height: 35.h,
                  child: ElevatedButton(
                    child: Text(
                      "회원가입하기",
                      style: style.copyWith(
                        color: Colors.white,),
                    ),
                    onPressed: (){

                    },
                  ),
                )
              ),
            ],
          ),
        ),
    );
  }
}