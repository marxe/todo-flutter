import 'package:flutter/material.dart';

// every component is known as a "widget".
void main() => runApp(new MyApp());

// MyApp Component
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    // it could be also return new MaterialApp(...)
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      title: "My List",
      home: TodoList()
    );
  }
}

class TodoList extends StatefulWidget{
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList>{
  List<String> _myList = [];

  void _addList(String list){
    if(list.length > 0){
        setState(()=> _myList.add(list));
    }
  }

  void _removeList(int index) {
    setState(() => _myList.removeAt(index));
  }

  void _promptRemoveList(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Mark as done? (List: ${_myList[index]})"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: ()=> Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Yes"),
              onPressed: (){
                _removeList(index);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Widget _listWidget(){
    return ListView.builder(
      itemBuilder: (context, index){
        // we need to stop the creating widget when it reach the last _myList item
        if(index < _myList.length){
          return _listItem(_myList[index], index);
        }
      },
    );
  }

  Widget _listItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),
      onLongPress: () => _promptRemoveList(index),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("My List"),
      ),
      body: _listWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushtoAddList,
        tooltip: "Add List",
        child: Icon(Icons.add),
      ),
    );
  }

  void _pushtoAddList(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context){
          return Scaffold(
            appBar: AppBar(
              title: Text("Add List")
            ),
            body: TextField(
              autofocus: true,
              onSubmitted: (val){
                _addList(val);
                Navigator.pop(context);
              },
              decoration: InputDecoration(
                hintText: "List",
                contentPadding: const EdgeInsets.all(10)
              ),
            ),
          );
        }
      )
    );
  }
}