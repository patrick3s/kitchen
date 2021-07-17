

import 'package:flutter/material.dart';

class ErrorView extends StatefulWidget {
  const ErrorView({ Key key }) : super(key: key);

  @override
  _ErrorViewState createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  Size size;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child:Image.asset('assets/error.png',
                  fit: BoxFit.cover,
                  )),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Desculpe, houve um erro tente novamente mais tarde',
                        style: TextStyle(
                          fontSize: size.width * .045
                        ),
                        ),),
                    ))
              ],
            )),
    );
  }
}