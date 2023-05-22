import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../save_color.dart';

class AppInfoScreen extends StatelessWidget {
  final SaveColor myAppColor = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: (myAppColor.darkMode.value) ? Colors.grey[900] : Colors.white,
        appBar: AppBar(
          foregroundColor: (appColorBox.get('color') == 'yellow' || appColorBox.get('color') == 'lime') ? Colors.black : Colors.white,
          backgroundColor: (myAppColor.isBlack.value) ? Colors.black : myAppColor.appColor.value,
          title: const Text('معلومات التطبيق'),
          centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox( height: 30 ),
        
          Container(
            margin: const EdgeInsets.symmetric( horizontal: 12, vertical: 6 ),
            height: 490,
            width: double.infinity,
            decoration: BoxDecoration(
              color: (myAppColor.darkMode.value) ? Colors.black26 : Colors.grey[300],
              border: Border.all(
                color: Colors.blueGrey,
                width: 2
              ),

              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'إسم التطبيق : مفكرتي', 
                    textAlign: TextAlign.right,
                    
                    style: TextStyle(
                      fontSize: 18,
                      color: (myAppColor.darkMode.value) ? Colors.white : Colors.black
                    ),
                    ),
                ),

                Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      height: 2,
                      color: Colors.blueGrey.shade200),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'رقم الإصدار : 1.0',
                    textAlign: TextAlign.right,
                    
                    style: TextStyle(
                      fontSize: 18,
                      color: (myAppColor.darkMode.value) ? Colors.white : Colors.black
                    ),
                    ),
                ),

                Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      height: 2,
                      color: Colors.blueGrey.shade200 ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'تاريخ الإصدار : 17/11/2022',
                    textAlign: TextAlign.right,
                    
                    style: TextStyle(
                      fontSize: 18,
                      color: (myAppColor.darkMode.value) ? Colors.white : Colors.black
                    ),
                    ),
                ),

                Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      height: 2,
                      color: Colors.blueGrey.shade200 ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                '''مميزات التطبيق : إمكانية كتابة ملاحظات لا نهائية وتعديلها ومشاركتها مع الناس وإمكانية حذفها، كما يمكن إدراج أي ملاحظة إلى قائمة ملاحظاتي المفضلة وتخصيص لونك المفضل لتلوين جميع الملاحظات، يحتوي التطبيق على ميزة الوضع الليلي ويتم تفعيله في كامل التطبيق''',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 18,
                        color: (myAppColor.darkMode.value) ? Colors.white : Colors.black
                      ),
                      ),
                  ),

                Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      height: 2,
                      color: Colors.blueGrey.shade200 ),

              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'مطور التطبيق : أحمد أبوبكر أحمد الحاج',
                      textAlign: TextAlign.right,
                      
                      style: TextStyle(
                        fontSize: 18,
                        color: (myAppColor.darkMode.value) ? Colors.white : Colors.black
                      ),
                      ),
                  ),
              ),
              ],  )  ),

            Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(12),
                  width: double.infinity,
                  child: Text(
                    'في حال وجدت أي مشكلة في التطبيق أو لديك إقتراح لتحسين التطبيق لا تتردد في التواصل معي عبر الإيميل التالي',
                    textAlign: TextAlign.right,
                    
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: (myAppColor.darkMode.value) ? Colors.white : Colors.black
                    ) ),
                ),

            Container(
                  padding: const EdgeInsets.only(left: 12.0, bottom: 20),
                  width: double.infinity,
                  child: Text(
                    'ahmedbakri1998s@gmail.com',
                    textAlign: TextAlign.left,
                    
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: (myAppColor.darkMode.value) ? Colors.white : Colors.black
                    ) ),
                ),
        ],
      ) );
  } }