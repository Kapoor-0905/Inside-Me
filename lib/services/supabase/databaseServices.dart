import 'package:supabase_flutter/supabase_flutter.dart';

class DbServices {
  final client = SupabaseClient('https://mhmqroojtswwnzarsqpg.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1obXFyb29qdHN3d256YXJzcXBnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODE2NTU5MTMsImV4cCI6MTk5NzIzMTkxM30.K-_-3tNGM40kTGrfVoakPIdLc8oTrxeyeplsgjuoT_o');

  // final _supabase = Supabase.instance.client;

  // add a new user to the database
  Future addUser(String uid, String email, String name) async {
    var response = await client.from('regUsers').insert({
      'userId': uid,
      'email': email,
      'name': name,
    });
    print(response);
  }

  // save tasks to supabase
  Future saveTask(String id, String task, String desc, double priority,
      String date, bool isCompleted) async {
    var response = await client.from('tasks').insert({
      'taskId': id,
      'task': task,
      'description': desc,
      'priority': priority,
      'date': date,
      'isCompleted': false,
    });
    print(response);
  }

  // get all tasks from supabase
  Future getTasks() async {
    var response = await client.from('tasks').select();
    print(response);
    return response;
  }

  Future getFirstPriorityTasks() async {
    var response = await client.from('tasks').select().eq('priority', 3);
    print(response);
    return response;
  }
}
