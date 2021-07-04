import 'package:Tutors/student_reg_page.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType{
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {

final formKey = new GlobalKey<FormState>();

FormType _formType = FormType.register;

bool _isIos;
final _passwordController = TextEditingController();
final _emailController = TextEditingController();
final _nameController = TextEditingController();

String _email;
String _password;
String _name;

void login()
{

}
  @override
  Widget build(BuildContext context) {
   final height = MediaQuery.of(context).size.height;
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
   return new Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
                          child: SingleChildScrollView(
                  child: new Container(
                    //color: Colors.orangeAccent,
                    padding: EdgeInsets.only(left: 25.0, right: 25.0,),
                    margin: null,
                    child: new Form(
                      key: formKey,
                      child: new Center(
                      child: Container(
                        height: height,
                               child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          verticalDirection: VerticalDirection.down,
                        children: _addBanner() + 
                        buildSubmitButtons()
                    ),
                      ), 
                  )
          ),
                ),
              ),
            )
          );
  }
   List<Widget> _addBanner(){
          return[
            new Hero(tag: 'logo', 
            child: Container(
              child: Image.asset('images/tlogo.jpeg'),
              height: 100.0,
            ),
            ),
          ];
   }


        List<Widget> buildSubmitButtons() { 
          if (_formType == FormType.login) {
          return[
           new TextFormField(
            decoration: new InputDecoration(labelText: 'Email', icon: Icon(Icons.alternate_email, size: 20.0, color: Colors.orange,), ),
            controller: _emailController,
            validator: (_emailController) => _emailController.isEmpty ? 'Email can/t be empty' : null, 
            ),
            new TextFormField(
            decoration: new InputDecoration(labelText: 'Password', icon: Icon(Icons.lock_outline, size: 20.0,), ),
            obscureText: true,
            controller: _passwordController,
            validator: (_passwordController) => _passwordController.isEmpty ? 'Password cant be empty': null,
            ),
            SizedBox(height: 30),
             RaisedButton(
              child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
              onPressed: login,
              color: Colors.orangeAccent,
              ),
               new Divider(
              color: Colors.orange,
              height: 5.0,
            ),
            SizedBox(height:30),
             FlatButton(
             child: new Text('Register with us', style: new TextStyle(fontSize: 15.0)),
             onPressed: () {
              setState(() {
                _formType = FormType.register;
              });
            },
             textColor: Colors.black,
             ),
          ];
          } else {
            return[
              SizedBox(height: 50,),

              GestureDetector(
                onTap: () =>  Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudentRegPage(
        )
        )
                ),
                    child: 
                Container(
                height: 50,
                width: 230,
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all((Radius.circular(15.0)),),),
                child: Center(
                  child: Text('Register as a Student', style: TextStyle(fontSize: 15, color: Colors.white),)
                ),
              ),
              ),
              SizedBox(height: 20,),
              new Container(
                height: 50,
                width: 230,
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all((Radius.circular(15.0)),),),
                child: Center(
                  child: Text('Register as a Tutor', style: TextStyle(fontSize: 15, color: Colors.white),)
                ),
              ),
            
            new Divider(
              color: Colors.orange,
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
            new Text('Have an account?', style: new TextStyle(fontSize: 15.0)), 
            new FlatButton(
            child: new Text('Login', style : new TextStyle(fontSize: 15.0),),
            textColor: Colors.orange,
            onPressed: () {
              setState(() {
                _formType = FormType.login;
              });
            },
             ),
            ],
            ),
            ];
          }
        }
        
}