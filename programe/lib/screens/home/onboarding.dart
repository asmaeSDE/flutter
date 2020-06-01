import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:programe/screens/authenticate/authenticate.dart';
import 'package:progress_dialog/progress_dialog.dart';


class onboarding extends StatefulWidget {


  
  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {

ProgressDialog pr;
final  pageDecoration= PageDecoration(
 
  contentPadding: EdgeInsets.all(10),
  
  bodyTextStyle: 
  PageDecoration().bodyTextStyle.copyWith(color :Colors.black 
  , fontFamily: 'Montserrat',
  fontSize: 26.0,
  ),
  titleTextStyle: PageDecoration().titleTextStyle.copyWith(color:Colors.green,fontFamily: 'Quicksand',fontSize: 40.0),
  
  
);


List<PageViewModel> getPages()
{
  return [
PageViewModel(
title: "Bienvenu Dans votre application ",
image: Image.asset("images/1.png"),
body: "formsApp, pour vos Questionnaires",

 decoration: pageDecoration
),

PageViewModel(

title: "Collecter les données de L'entreprise",
image: Image.asset("images/2.png"),
body: "Des possibilités très riches pour la création de vos sondages",
decoration: pageDecoration

),


PageViewModel(

title: "Bee One",
image: Image.asset("images/Agridata.png"),
body: "L’ERP leader pour le métier agricole, une richesse fonctionnelle exceptionnelle. Faites le choix de la maîtrise et la performance",
decoration: pageDecoration,
footer: RaisedButton(onPressed: ()
{

},
),

),

  ];
}

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
pr.style(
  message: 'Downloading file...',
  borderRadius: 10.0,
  backgroundColor: Colors.white,
  progressWidget: CircularProgressIndicator(),
  elevation: 10.0,
  insetAnimCurve: Curves.easeInOut,
  progress: 0.0,
  maxProgress: 100.0,
  progressTextStyle: TextStyle(
     color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );


pr.update(
  progress: 50.0,
  message: "Please wait...",
  progressWidget: Container(
    padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
  maxProgress: 100.0,
  progressTextStyle: TextStyle(
    color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  messageTextStyle: TextStyle(
    color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
  );

    return Scaffold(
      body: IntroductionScreen(
       globalBackgroundColor: Colors.green[100],
       
       pages: getPages(),
next: const Icon(Icons.arrow_forward),
     
        showSkipButton: true,
        skip:  Text(
          "Skip",

          style: TextStyle(
        color: Colors.orange,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w600),
          ),
          
       done: Text(
         'Done',
         style:TextStyle(
           color: Colors.black,
           fontFamily: 'Montserrat',
          fontWeight: FontWeight.w700,
          
           ),
       ),


       onDone: (){
 pr.show();
 Future.delayed(Duration(seconds: 3)).then((value) {
              pr.hide().whenComplete(() {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => authenticate()));
              });
 });
       },
      onSkip: () {
        
 
              
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext context) => authenticate()));
            

    // You can also override onSkip callback
  },
  dotsDecorator: DotsDecorator(
    size: const Size.square(10.0),
    activeSize: const Size(20.0, 10.0),
    color: Colors.black26,
    spacing: const EdgeInsets.symmetric(horizontal: 3.0),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0)
    ),
  
  ), 

       ),
      
      );
   
  }
}