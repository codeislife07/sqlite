import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite/DatabaseHelper.dart';
import 'package:sqlite/main.dart';

class InterUpdateData extends StatefulWidget
{
  final String table="Employee";
   final String name="Name";
   final String age="Age";
   final String design="Designaton";
   final String depart="Department";
   final String salary="Salary";
  DatabaseHelper dbHelper;
  UserData? listdata;
  InterUpdateData(this.dbHelper,this.listdata );
  @override
  State<StatefulWidget> createState()=>InterUpdateDataState();

}

class InterUpdateDataState extends State<InterUpdateData> {
  var name=TextEditingController();
  var age=TextEditingController();
  var dept=TextEditingController();
  var desg=TextEditingController();
  var salary=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.listdata!=null){
      setState(() {
        name.text=widget.listdata!.Name.toString();
        age.text=widget.listdata!.age.toString();
        desg.text=widget.listdata!.design.toString();
        dept.text=widget.listdata!.depart.toString();
        salary.text=widget.listdata!.salary.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
     appBar: AppBar(
       title: Text(widget.listdata==null?"Save":"Update"),
     ),
     body: ListView(
       children: [
           SizedBox(height: 100,),
           Row(
             children: [
               Text("Name:"),SizedBox(width: 10,),
             Expanded(
               child: TextField(
                   decoration: InputDecoration(
                       hintText: "Enter last name"
                   ),
                   controller: name,
                 ),
             ),
             ],
           ),
           SizedBox(height: 20,),
           Row(
             children: [
               Text("Age:"),SizedBox(width: 10,),
               Expanded(
                 child: TextField(
                   keyboardType: TextInputType.number,
                   decoration: InputDecoration(
                       hintText: "Enter Age"
                   ),
                   onChanged: (String? value){
                     if(int.parse(value!)>=18){

                     }
                   },
                   controller: age,
                 ),
               ),
             ],
           ),
         SizedBox(height: 20,),
         Row(
           children: [
             Text("Dept:"),SizedBox(width: 10,),
             Expanded(
               child: TextField(
                 decoration: InputDecoration(
                     hintText: "Enter Department"
                 ),
                 controller: dept,
               ),
             ),
           ],
         ),
         SizedBox(height: 20,),
         Row(
           children: [
             Text("Design:"),SizedBox(width: 10,),
             Expanded(
               child: TextField(
                 decoration: InputDecoration(
                     hintText: "Enter Desig."
                 ),
                 controller: desg,
               ),
             ),
           ],
         ),
         SizedBox(height: 20,),
         Row(
           children: [
             Text("Salary:"),SizedBox(width: 10,),
             Expanded(
               child: TextField(
                 keyboardType: TextInputType.number,
                 decoration: InputDecoration(
                     hintText: "Enter salry"
                 ),
                 controller: salary,
               ),
             ),
           ],
         ),
         SizedBox(height: 20,),
         ElevatedButton(onPressed: (){

           if(name.text.isEmpty || age.text.isEmpty || desg.text.isEmpty || dept.text.isEmpty || salary.text.isEmpty){
             final snackBar = SnackBar(
               content: const Text('Enter All fields'),

             );
             ScaffoldMessenger.of(context).showSnackBar(snackBar);
           }else{
             var data={
               widget.name:name.text,
               widget.age:int.parse(age.text),
               widget.depart:dept.text,
               widget.design:desg.text,
               widget.salary:salary.text,
             };
             if(widget.listdata==null){
               widget.dbHelper!.InsertData(data);
               Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_)=>MyHomePage(title: "Flutter Demo")), (route) => false);
             }else{
               print("update");
               widget.dbHelper.UpdateData(data,widget.listdata!.id);
               Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_)=>MyHomePage(title: "Flutter Demo")), (route) => false);
             }
           }


         },   child: Text(widget.listdata==null?"Save":"Update"))
       ],
     ),
   );
  }
}