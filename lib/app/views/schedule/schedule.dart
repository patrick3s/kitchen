import 'package:flutter/material.dart';

import 'package:multidelivery/app/app_module.dart';
import 'package:multidelivery/controllers/schedule.dart';
import 'package:multidelivery/presenters/schedule.dart';
import 'package:multidelivery/shared/config.dart';
import 'package:multidelivery/src/infra/models/cart.dart';
import 'package:multidelivery/src/infra/models/partner.dart';
import 'package:multidelivery/src/infra/models/schedule.dart';
import 'package:multidelivery/utils/common_widgets.dart';

class ScheduleView extends StatefulWidget {
  final Partner partner;
  ScheduleView({Key key,this.partner}) : super(key: key);

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> implements ScheduleContract {
  Size size;
  SchedulePresenter presenter;
  @override
  void initState() {
    AppModule.to<Config>().showLog('ScheduleView iniciado');
    super.initState();
    presenter = SchedulePresenter(
      this,ScheduleController(AppModule.to<CartModel>(),widget.partner)
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    AppModule.to<Config>().showLog('ScheduleView destruido');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Escolha um horario',
          style: TextStyle(fontSize: size.width * .045, color: Colors.black),
        ),
      ),
      body: FormField<int>(
        key: presenter.controller.form,
        initialValue: presenter.controller.cart.scheduleIndex,
        builder: (state) {
          presenter.controller.selectHour();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                _dateTimePicker(),
                presenter.controller.cart.order.scheduleOrder.title == "Hoje" ? _intervalNow(state) : Container(),
                widget.partner.scheduleOrder.intervals.isEmpty ?  Container():  _showIntervals(state),
               
                ],
              
            ),
          );
        }
      ),
    );
  }

  _dateTimePicker() {
    return InkWell(
        onTap: presenter.dateAvaible,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color:Colors.black
                )
              ),
              child: Text(
                presenter.controller.cart.order.scheduleOrder.title,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ));
  }

  _intervalNow(FormFieldState<int> state){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Para agora',
              style: TextStyle(
                fontSize: size.width * .045,
                fontWeight: FontWeight.bold
              ),
              ),
              Text(widget.partner.deliveryTime,
              style: TextStyle(
                fontSize: size.width * .04,
                color: Colors.grey
              ),
              ),
              ],
            ),
            Row(
              children: [
                Text(!presenter.controller.cart.order.delivery ? "Grátis" : widget.partner.deliveryPriceFormat(),
                style: TextStyle(
                  fontSize: size.width * .045,
                  fontWeight: FontWeight.bold
                ),
                ),
                Checkbox(value: -1 == state.value, onChanged: (value){
                  presenter.controller.cart.scheduleIndex = -1;
                  state.didChange(-1);
                })
            ],)
          ],
        ),
      ),
    );
  }
  _showIntervals(FormFieldState<int> state){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Agendar',
        style: TextStyle(
          fontSize: size.width * .045,
          fontWeight: FontWeight.bold
        ),
        ),

        ...List.generate(widget.partner.scheduleOrder.intervals.length ,(index) => _rowTile(
widget.partner.scheduleOrder.intervals[index],
    index,state
        )).toList()
      ],
    );
  }

  _rowTile(ScheduleIntervalByDay interval , index ,FormFieldState<int> state){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(interval.formatString(),
          style: TextStyle(
            fontSize: size.width * .04,
            fontWeight: FontWeight.bold
          ),),
          Row(
            children: [
              Text(!presenter.controller.cart.order.delivery ? "Grátis" : widget.partner.deliveryPriceFormat(),
                style: TextStyle(
                  fontSize: size.width * .045,
                  fontWeight: FontWeight.bold
                ),
                ),
              Checkbox(value: index == state.value, 
              onChanged: (value){
                presenter.controller.cart.scheduleIndex = index;
                state.didChange(index);
              }),
            ],
          )
        ],
      ),
    );
  }

  @override
  notification(String text) {
    notificationPopup('Atenção', text);
  }

  @override
  refresh() {
    setState(() {
      
    });
  }

  @override
  Future showDate()async {
    return await showDatePicker(context: context, 
          initialDate: DateTime.now(), 
          firstDate: DateTime.now(),
          lastDate: presenter.controller.dateMax()
          );
        
  }
}
