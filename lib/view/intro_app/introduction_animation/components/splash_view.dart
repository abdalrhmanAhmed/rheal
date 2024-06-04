import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'images/shura_logo.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "تطبيق رحيل",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "من خلال التطور الملحوظ الذي تشهده الإمارة في زيادة عمليات البنية التحتية والتوسع العمراني وجلب أفضل الممارسات العالمية و إستنادا لإستراتيجية إمارة الفجيرة في استخدام التقنيات الحديثة  قام مكتب شؤون المقابر بتوجيهات من سيدي سمو ولي عهد إمارة الفجيرة بعمل تطبيق ذكي لمشروع البيانات الجيومكانية بالتعاون مع مركز الفجيرة لنظم المعلومات الجغرافية. وسعيا من مكتب شؤون المقابر في إمارة الفجيرة تم إعداد هذا التطبيق لسهولة تحديد القب ور وإرشاد الزائرين لذوييهم و أقاربهم وكذلك يهدف المشروع إلي سهولة نظام المالحة العالمي واستخدام التجوال الإفتراضي للوصول إلى القبر المنشود.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15,height: 1.8),
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 58,
                  padding: EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: Color(0xFF54D3C2),
                  ),
                  child: Text(
                    "هيا نبدأ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
