



import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:multidelivery/app/common/delegate.dart';

import 'package:multidelivery/controllers/home.dart';
import 'package:multidelivery/app/views/home/widgets/floating_button.dart';
import 'package:multidelivery/shared/icons_platform.dart';


//@required
class BottomNavClipper extends CustomPainter{
  @override
  void paint(Canvas canvas,Size size) {
      Paint paint = Paint()..color = Colors.deepOrange.withOpacity(.9) ..style = PaintingStyle.fill;
      Path path = Path()..moveTo(0, 20);
      path.quadraticBezierTo(size.width * .2, 0, size.width * .35, 0);
      path.quadraticBezierTo(size.width * .4, 0, size.width * .4, 20);
      path.arcToPoint(Offset(size.width * .6, 20),
      radius: Radius.circular(10.0),clockwise: false);
      path.quadraticBezierTo(size.width * .6, 0, size.width * .65, 0);
      path.quadraticBezierTo(size.width * .8, 0, size.width , 20);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawShadow(path, Colors.black, 5, true);
      canvas.drawPath(path, paint);
    }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=> true;
}

class CustomBottomNav extends StatelessWidget {
  final HomeController controller;
  const CustomBottomNav({ Key key,this.controller }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height =80.0 ;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom:18.0),
      child: Container(
        height: height ,
        width: size.width,
        child: ValueListenableBuilder(
          valueListenable: controller.currentPage,
          builder: (context, page,__) {
            return Stack(children: [
              CustomPaint(
                size:Size(size.width,height),
                painter: BottomNavClipper(),
                child: Container(
                  height: height,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _tileIcon(IconsPlatform.home, 0, page ),
                      _tileIcon(IconsPlatform.orders, 1, page),
                      Container(
                        width: size.width * .2,
                      ),
                      _tileIcon(IconsPlatform.search, 3, page,onTap: (){
                        showSearch(context: context, delegate: CustomSearchDelegate());
                      }),
                      _tileIcon(IconsPlatform.person, 2, page)
                    ],
                  ),
                ),
              ),
              CustomFloatingButton()
            ],);
          }
        ),
      ),
    );
  }

  _tileIcon(IconData icon , int page, int currentPage , {Function onTap}){
    final pageActivate = page == currentPage;
    return IconButton(
                    onPressed: onTap ?? (){
                      controller.currentPage.value =page;
                    }, icon: Icon(
                    icon,
                    size: 32,
                    color: pageActivate ? Colors.white : Colors.black87.withOpacity(.85),
                  ));
  }
}