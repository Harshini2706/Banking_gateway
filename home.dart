import 'package:flutter/material.dart';
import 'package:razor_flutter/razorpay_flutter.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
          

      home:MyHomePage(),
    );

  }
}

class MyHomePage extends StatelessWidget{

  @override
Widget build(BuildContext context){
    return Scaffold(
      body: Column(
       mainAxisAlignment:MainAxisAlignment.center ,
        crossAxisAlignment:CrossAxisAlignment.center,
         
         mainAxisSize:MainAxisSize.min,

          children:[
            SizedBox(
              height: 40,
            ),
            Icon(
               Icons.account_balance,
              size:40.0,
            ),
            SizedBox(
              height: 60,
            ),
            Text("Welcome to TK Mobile Banking",style:const TextStyle(fontWeight: FontWeight.bold,color:Colors.green,fontSize: 24.0, )
            ),
            SizedBox(
              height: 20,
            ),
            
            Text("Banking Is Necessary",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0, color:Colors.lightBlueAccent)),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text('Continue',style: const TextStyle(color:Colors.greenAccent,fontSize:20.0 ,fontWeight: FontWeight.bold, )),
             onPressed: () {
               Navigator.push(context,MaterialPageRoute(
                 builder:(context)=>LoginPage()
               ));
               print("ElevatedButton");
             },
              style: ElevatedButton.styleFrom(primary: (const Color(0x801c33))),

               )

        ]
               ),
      
);

}
}

class LoginPage extends StatefulWidget{
  LoginPage({Key key}) :super(key: key);
  @override
  _LoginPageState createState()=>_LoginPageState();
}
class _LoginPageState extends State<LoginPage>{

  Razorpay razorpay;
  TextEditingController textEditingController=new TextEditingController();
  @override
  void initState(){
    super.initState();

    razorpay= new Razorpay();

   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }
  @override
  void dispose(){
    super.dispose();
    razorpay.clear();
  }
  void openCheckout(){
    var options={
      "key":"rzp_test_g6ggnb0Dw7RNtc",
      "amount":textEditingController.text,
      "name":"Intern_app",
      "description":"Payment for the product",
      "prefill":{
        "contact":"9977665510",
        "email":"19tuit029@skct.edu.in"
      },
      "external":{
        "wallets":["paytm"]
      } 
    };
    try{
      razorpay.open(options);
    }
    catch(e){
      print(e.toString());
    }
  }
  void handlePaymentSuccess(){
    print("Payment success");
  }
  void  handlePaymentError(){
    print("Payment Error");
  }
  void handleExternalWallet(){
    print("External Wallet");
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
          appBar:AppBar(title: Text("Payment gateway"), ),
          body:Column(
            children:[
              TextField(
                controller:textEditingController,
                decoration:InputDecoration(
                  hintText:"Amount to Pay"
                ),
              ),
              SizedBox(
                height:40
              ),
              RaisedButton(
                color:Colors.cyan,
                child:Text("Pay now",style: TextStyle(color:Colors.white), ),
                onPressed:(){
                  openCheckout();
                }
              )
            ]
          )
            
          );
  }
}
