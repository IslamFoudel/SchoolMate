import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storage___sq_lite__database__listview__search_and_filtering/models/course.dart';

class DbHelper {
  //attributes
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database? _db;

  //methods
  Future<Database?> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    // define the path to database in system + making our school db
    String path = join(await getDatabasesPath(), 'school.db');
    _db = await openDatabase(path,
        version: 6, onCreate: initDB, onUpgrade: upgradeDB);
    return _db;
  }

  // instructor decided to back code inside onCreate to be simple, we will keep it like nw, its not complex...
  initDB(Database db, int v) {
    // here we create tables for database
    db.execute(
        'create table courses(id integer primary key autoincrement, name varchar(50), content varchar(255), hours integer, level varchar(50))');
  }

  upgradeDB(Database db, int oldV, int newV) async {
    if (oldV < newV) {
      print('Upgrading database from version $oldV to $newV...');
      await db.execute('ALTER TABLE courses ADD COLUMN price integer');
    }
  }

  Future<int?> createCourse(Course course) async {
    Database? db = await createDatabase();
    //db.rawInsert('insert into courses value....'); //rawInsert need a sql code like that,
    // we have easy better way that our package or library provide us 'sqflite':
    return db?.insert('courses', course.toMap()
        //below code to explain clear, but all this work just in the above method, .toMap..
        /*{
      'id': course.id,
      'name': course.name,
      'content': course.content,
      'hours': course.hours
    }*/
        );
  }

  Future<List?> allCourses() async {
    Database? db = await createDatabase();
    //db.rawQuery('select * from courses'); //pure sql code
    return db?.query('courses'); // our plugin magical using...
  }

  Future<int?> delete(int? id) async {
    Database? db = await createDatabase();
    return db?.delete('courses', where: 'id = ?', whereArgs: [id]);
  }

  Future<int?> courseUpdate(Course course) async {
    Database? db = await createDatabase();
    return await db?.update('courses', course.toMap(),
        where: 'id = ?', whereArgs: [course.id]);
  }
}
