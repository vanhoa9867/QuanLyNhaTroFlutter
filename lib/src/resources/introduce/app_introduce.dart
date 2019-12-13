import 'package:flutter/material.dart';
import 'package:flutter_app/src/resources/home_page.dart';
import 'package:flutter_app/src/resources/home_page_2.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "HỆ THỐNG RIÊNG",
        description:
            "Bạn có thể tự tạo ra một hệ thống phòng trọ tùy theo nhu cầu của mình!",
        pathImage: "assets/ic_house_network.png",
        backgroundColor: Colors.blueAccent,
      ),
    );
    slides.add(
      new Slide(
        title: "TƯƠNG TÁC\nVỚI KHÁCH HÀNG",
        description:
            "Có hệ thống tương tác với khách hàng tiện dụng, việc thông báo, liên hệ trở nên dễ dàng!",
        pathImage: "assets/ic_customer_service.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "DỊCH VỤ\nKÈM THEO ĐẦY ĐỦ",
        description:
        "Có những dịch vụ khi khách hàng ở trọ\n làm tăng tính tiện ích hệ thống của bạn!",
        pathImage: "assets/ic_house_invest.png",
        backgroundColor: Colors.red,
      ),
    );
    slides.add(
      new Slide(
        title: "THỐNG KÊ",
        description:
            "Việc thống kê tự động giúp bạn \ndễ dàng kiểm tra tình trạng của toàn hệ thống thời gian thực.",
        pathImage: "assets/ic_house_graph.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
    slides.add(
      new Slide(
        title: "BẮT ĐẦU NGAY",
        description:
        "Còn chờ gì nữa \nbắt đầu trải nghiệm ứng dụng nào!",
        pathImage: "assets/ic_balloons.png",
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }

  void onDonePress() {
    // Do what you want
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
        slides: this.slides,
        onDonePress: () {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new HomePage()));
        });
  }
}
