import 'package:flutter/material.dart';


//textformfield위젯의 이메일, 비번 등의 형식 유효성 검사를 위한 것

class CheckValidate{

   validateEmail(FocusNode focusNode, String value){  //포커스받을 focusNode와 에러메시지 등의 내용
    if(value.isEmpty){
      //focusNode.requestFocus();
      return 'Enter your email.';
    }else {
      var pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if(!regExp.hasMatch(value)){
        return 'Invalid email format.';
      }else{  //제대로 입력했을시
        return null;
      }
    }
  }

  validatePassword(FocusNode focusNode, String value){
    if(value.isEmpty){        //아예 안썻을때
      return 'Enter your password.';
    }else {                    //뭔가 형식에 안맞을때
      if(value.length < 6){
        return 'Password too short';
      }else if(value.length >15){
        return 'Password too long';
      }else{
        return null;
      }
  }
  }

   validateName(FocusNode focusNode, String value){
     if(value.isEmpty){        //아예 안썻을때
       return 'Enter your name.';
     }else {                    //뭔가 형식에 안맞을때
        return null;
     }
   }



}

