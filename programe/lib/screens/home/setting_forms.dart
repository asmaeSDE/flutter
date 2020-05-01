import 'package:flutter/material.dart';
import 'package:programe/shares/constant.dart';


class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

final _formeKey = GlobalKey<FormState>();
final List<String> sugars = ['0','1','2'];


String _current_name;
String _current_lastName;
int _current_Age;




  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formeKey,
      child: Column(
       children : <Widget>[
         Text(
           'Updaye your Settring',
           style : TextStyle(fontSize : 18.0 ),
           ),
           SizedBox(height:20.0),

           TextFormField(
             decoration: textfield ,
             validator: (val) => val.isEmpty ? 'Enter a name' : null,
   onChanged : (val)
   {
setState(() => _current_name = val);
   }
  
           ),
           TextFormField(
             decoration: textfield ,
             validator: (val) => val.isEmpty ? 'Enter a LastName' : null,
   onChanged : (val)
   {
setState(() => _current_lastName = val);
   }
  
           ),
           TextFormField(
             decoration: textfield ,
             validator: (val) => val.isEmpty ? 'Enter an Age' : null,
   onChanged : (val)
   {
setState(() => _current_Age == val);
   }
  
           ),
           SizedBox(height:20.0),

           DropdownButtonFormField
           (
items: sugars.map((sugar){

  return DropdownMenuItem(
value: _current_Age ?? '0',
child: Text('$sugar sugars'),

  );

}).toList(),
           ),
         RaisedButton(
           color: Colors.pink,
           child: Text(
             'update',
             style: TextStyle(color: Colors.white),
           ),
           
           onPressed: () async{
             print(_current_name);
             print(_current_lastName);
             print(_current_Age);
           } ),

       ]
      ),
    );
  }
}
