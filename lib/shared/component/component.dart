import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_veiw.dart';

Widget myDivider() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(start: 50, end: 50),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey[400],
    ),
  );
}

Widget articleItems(context, article) {
  return InkWell(
    onTap: (){
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepOrange,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${article['urlToImage']}'),
                )),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                      "${article['title']}",
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${article['publishedAt']}",
                        style: const TextStyle(fontSize: 15, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Text(
                      //   "${article['author']}",
                      //   style: const TextStyle(fontSize: 18, color: Colors.black),
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget customTextFormField(
    {required TextEditingController controller,
    required TextInputType textInputType,
    required IconData prefix,
    IconData? suffix,
    Function? suffixPressed,
    required String label,
    bool isPassword = false,
    Function? validate}) {
  return TextFormField(
    validator: validate!(),
    obscureText: isPassword,
    controller: controller,
    style: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
    keyboardType: textInputType,
    decoration: InputDecoration(
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: suffixPressed!(),
              icon: Icon(
                suffix,
              ),
            )
          : null,
      labelText: label,
      labelStyle: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      border: OutlineInputBorder(
        gapPadding: 10,
      ),
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
