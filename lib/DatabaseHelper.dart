import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/main.dart';
class DatabaseHelper{

  Database? databse;
  DatabaseHelper(){
   init();
  }
  static String table="Employee";
  static String name="Name";
  static String age="Age";
  static String design="Designaton";
  static String depart="Department";
  static String salary="Salary";

  void init() async{
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bbbssa.db');
    //check db exit or not
    var exists = await databaseExists(path);
    if(!exists){
      print("Create Database");
      try{
        databse = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
              // When creating the db, create the table
              await db.execute(
                  'CREATE TABLE $table (id INTEGER PRIMARY KEY, $name TEXT, $age INTEGER, $design TEXT,$depart TEXT,$salary TEXT) ');
            });

      }catch(e){
      print("EXCEPTION+++++$e");
    }
          }else{
      print("DAtabase Available");
      databse=await openDatabase(path,readOnly: false);
    }
  }

  InsertData(Map<String,dynamic> values)async{
    var result=await databse!.insert(table, values );
    print(" result $result");
  }

  ViewData()async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'bbbssa.db');
    databse=await openDatabase(path,readOnly: false);
    var result=await databse!.rawQuery("select * from $table");
    List<UserData> users=[];

    if(result.length!=0){
      for(var i=0;i<result.length;i++){
        Map<String,dynamic> data=result[i];
        users.add(UserData(data[name],data[age],data[design],data[depart],data[salary],data['id'].toString()));
      }
      return users;
    }else{
      return users;
    }

  }

  UpdateData(Map<String,dynamic> values, id)async{
    var result=await databse!.update(table,values,where: "id='${int.parse(id.toString())}'");
    print(" result $result");
  }
  DeleteData(int roll)async{
    var result=await databse!.delete(table, where: "id='$roll'");
    print(" result $result");
  }

}