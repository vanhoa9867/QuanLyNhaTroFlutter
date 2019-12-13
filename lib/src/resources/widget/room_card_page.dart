import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  double _width;
  double _height;
  double _aspectRatio;

  String name;
  String customer;
  String price;
  String status;
  String roomId;
  String houseId;

  RoomCard(this.name, this.customer, this.price, this.status,this.roomId, this.houseId);


  @override
  Widget build(BuildContext context) {
    _width= MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Card(
      elevation: 5.0,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(left: 15, top: 15, right: 5, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: _height/40),
                ),
                Container(
                  width: _width / 2.75,
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '${price} VNĐ',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(3),
                          color: Colors.grey[200],
                          child: Text(
                            status,
                            softWrap: true,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                /*Flexible(
                  child: Container(
                      width: _width / 2.5,
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: _height/70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      )),
                ),*/
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Container(
                    width: _width / 2.75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child:  GestureDetector(
                            child: Icon(Icons.favorite_border, size: _height/30,),
                            onTap: (){
                              print('Fav');
                            },
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '06 Febuary 2020',
                              style: TextStyle(fontSize: _height/65),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: _height/65,
                                ),
                                Text(
                                  'Thủ Đức, TP.HCM',
                                  style: TextStyle(fontSize: _height/65),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: _width/2.5,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'ic_house_calculation.png',
                fit: BoxFit.cover,
                height: _height/4,
                width: _width/4,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
