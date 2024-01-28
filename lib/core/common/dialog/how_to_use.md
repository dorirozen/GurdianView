

note !!
אם ארצה להשתמש ב מולטי פרוביידר אז לנסות בלי להעביר VALUE הלאה..
ולהוסיף NOTIFYLISTENERS לפרמטרים..
ככה שאשנה ערך למודל ההתראה הערכים בתוכו ישתנו כשאלחץ על כפתור אחר ..
ובעצם צריך להוסיף פונקציה לכפתור שאוכל לשנות בו ערכים
תוך כדי ריצה של כפתור נוסף.. בעצם יציג אותו אובייקט אולי עם ערכים שונים פשוט.

**wrapping the class with want to use a dialog**
1. DialogManager(child:HomeView())
**inside it we will need to provide the type of the factory dialog we want to use.**
2. return ChangeNotifierProvider.value(
value: DialogMaker(),
child: Consumer<DialogMaker>(
3. enter the params..
builder: (context, model, child) => Scaffold(
child: Text('Show Dialog'),
onPressed: () {
*here we gonna active it.*
4. model.showDialog();


/*

import 'package:flutter/material.dart';
import 'package:guardian_view/dialog/viewmodels/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
@override
Widget build(BuildContext context) {
return ChangeNotifierProvider.value(
value: HomeViewModel(),
child: Consumer<HomeViewModel>(
builder: (context, model, child) => Scaffold(
body: Center(
child: ElevatedButton(
child: Text('Show Dialog'),
onPressed: () {
model.showDialog();
},
),
),
),
),
);
}
}

*/