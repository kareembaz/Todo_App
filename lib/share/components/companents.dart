import 'package:flutter/material.dart';
import 'package:todo_app/layout/Todo_app/cubit/cubit.dart';

const defaultColor = Colors.blue;
Widget defaultButton({
  double width = double.infinity,
  // Color background = Colors.blue,
  Color background =defaultColor,
  bool isUpperCase = true,
  double radius = 3.0,
  @required function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defoultTextButton({
  @required  function,
  @required  String text,
})=> TextButton(onPressed:function, child:Text(text.toUpperCase()),);

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  onSubmit,
  onChange,
  onTap,
  bool isClickable = true,
  bool isPassword = false,
  @required validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  suffixpressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      validator: validate,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixpressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget builtTaskItem(Map model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 40.0,
            child: Text(
              '${model['time']}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${model['data']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          IconButton(
            onPressed: () {
              AppCubit().get(context).updateData(status: 'done', id: model['id']);
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit().get(context)
                  .updateData(status: 'archive', id: model['id']);
            },
            icon: Icon(
              Icons.archive,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );


// Widget myDivider() => Padding(
//       padding: const EdgeInsetsDirectional.only(
//         start: 20.0,
//       ),
//       child: Container(
//         width: double.infinity,
//         height: 1.0,
//         color: Colors.grey[300],
//       ),
//     );
// //
// void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (context) => widget,
//       ),
//     (Route<dynamic> route)=>false,
//     );
//



