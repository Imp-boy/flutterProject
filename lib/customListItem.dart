import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.lightBlue,
      child: Center(
        child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.blue, 
                borderRadius: BorderRadius.circular(12)
              ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text("用户登录"),
                  Expanded(
                      child: Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text("用户名："),
                      ),
                      Expanded(
                        child: TextField(),
                      )
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text("密码："),
                      ),
                      Expanded(
                        child: TextField(),
                      )
                    ],
                  ))
                ],
              ),
            )),
      ),
    );
  }
}
