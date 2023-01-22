import 'package:flutter/material.dart';
import 'package:sqlite/DatabaseHelper.dart';
import 'package:sqlite/InsertUpdateData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sqlite demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  var name=TextEditingController();
  var lastname=TextEditingController();
  var id=TextEditingController();
  DatabaseHelper? dbHelper;
  List<UserData> listdata=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      dbHelper=DatabaseHelper();
      initdata();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("STATE:=======");
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
       print("");
        break;
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("sqlite CRUD"),),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // SizedBox(height: 100,),
            // TextField(
            //   decoration: InputDecoration(
            //       hintText: "Enter Roll No."
            //   ),
            //   controller: id,
            // ),
            // SizedBox(height: 20,),
            // TextField(
            //   decoration: InputDecoration(
            //       hintText: "Enter Name"
            //   ),
            //   controller: name,
            // ),
            // SizedBox(height: 20,),
            // TextField(
            //   decoration: InputDecoration(
            //       hintText: "Enter last name"
            //   ),
            //   controller: lastname,
            // ),
            // SizedBox(height: 20,),
            Row(
              children: [
                Container (
                  //width: double.infinity,
                  child: ElevatedButton(onPressed: () async {
                   Navigator.push(context, MaterialPageRoute(builder: (_)=>InterUpdateData(dbHelper!,null)));
                  }, child: Text("INSERT")),
                ),
                Spacer(),
                Spacer(),
                Container (
                  //width: double.infinity,
                  child: ElevatedButton(onPressed: () async {
                    initdata();
                  }, child: Text("REFresh")),
                ),
                // Spacer(),
                // ElevatedButton(onPressed: () async {
                //  initdata();
                //
                //  }, child: Text("Refresh")),
                // Spacer(),
                // ElevatedButton(onPressed: ()async{
                //   var data={
                //     'roll':int.parse(id.text),
                //     'first_name':name.text,
                //     'last_name':lastname.text
                //   };
                //   dbHelper!.UpdateData(data);
                //   //update method use to update record
                //
                // }, child: Text("UPDATE")),
                // Spacer(),
                // ElevatedButton(onPressed: ()async{
                //   //remove method delete that record in child
                //   dbHelper!.DeleteData(int.parse(id.text));
                // }, child: Text("DELETE")),
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
                child:
            listdata.length!=0?ListView.builder(
              itemCount: listdata.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Name :${listdata[index].Name}"),Spacer(),
                                Text("Age:${listdata[index].age}"),

                              ],
                            ),
                            Text("desigantion:${listdata[index].design}")
                            ,
                            Text("department:${listdata[index].depart}"),
                            Text("salry:${listdata[index].salary}"),

                            Row(
                              children: [
                                ElevatedButton(onPressed: (){  Navigator.push(context, MaterialPageRoute(builder: (_)=>InterUpdateData(dbHelper!,listdata[index])));
                                }, child: Text("Edit")),
                                Spacer(),
                                ElevatedButton(onPressed: (){
                                  showDialog(context: context, builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Delete"),
                                      content: Text("Are you sure to delete??"),
                                      actions: [
                                    TextButton(
                                    child: Text("No"),
                                    onPressed: () {Navigator.pop(context); },
                                    ),
                                    TextButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      dbHelper!.DeleteData(int.parse(listdata[index].id!));
                                      setState(() {
                                        listdata.removeAt(index);
                                      });
                                      Navigator.pop(context);
                                    },
                                    ),
                                      ],
                                    );
                                  },);


                                }, child: Text("Delete")),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },

            ):Container())

          ],
        ),
      ),
    );
  }

  void initdata() async{
    print("DAtatList");
    List<UserData> data=await dbHelper!.ViewData();

    setState(() {
      listdata.clear();
      listdata.addAll(data.reversed);
    });
  }
}

class UserData{
  String? id;
  String? Name;
  int? age;
  String? design;
  String? depart;
  String? salary;

  UserData(this.Name, this.age, this.design, this.depart, this.salary,this.id);
}
