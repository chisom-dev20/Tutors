import 'dart:convert';
import 'dart:typed_data';
import 'package:Tutors/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';


class StudentRegPage extends StatefulWidget {

  @override
  _RegPageState createState() => _RegPageState();
}

//final formKey = new GlobalKey<FormState>();

final formKey1 = new GlobalKey<FormState>();
final formKey2 = new GlobalKey<FormState>();
final formKey3 = new GlobalKey<FormState>();
final surname = TextEditingController();
final  otherNames = TextEditingController();
final  contactAddress = TextEditingController();
final  mobileNumber = TextEditingController();
final  programStudy = TextEditingController();
final  currentLevel = TextEditingController();
final  schoolName = TextEditingController();
final username = TextEditingController();
final  email = TextEditingController();
final  password = TextEditingController();
final  confirmPassword = TextEditingController();




class Maritals{
  int id;
  String name;

  Maritals(this.id, this.name);

  static List<Maritals> getMaritals() {
    return <Maritals>[
      Maritals(1, 'Single'),
      Maritals(2, 'Married'),
      Maritals(3, 'Divorced'),
      Maritals(4, 'Widowed'),
    ];
  }
}

class Genders{
  int id;
  String name;

  Genders(this.id, this.name);

  static List<Genders> getGenders() {
    return <Genders>[
      Genders(1, 'Male'),
      Genders(2, 'Female'),
    ];
  }
}

          
class _RegPageState extends State<StudentRegPage> {

bool vs = false;
bool _obscureText = true;
bool _cobscureText = true;

  onStepContinue(){
    setState(() {
    if (currentStep < 3 - 1) {
              currentStep++;
            } else {
              currentStep = 3 - 1;
            }
          });
              }

void stepAction(){
  if (currentStep == 0){
     setState(() {
      _step1validate = true;
    });
    if (validateAndSave(formKey1))
    {
      onStepContinue();
    }
  }

  else if (currentStep == 1)
  {
     setState(() {
      _step2validate = true;
    });
    if (validateAndSave(formKey2))
    {
      onStepContinue();
    }
 
  }
  else if (currentStep == 2)
  {
    setState(() {
      _step3validate = true;
    });

    if (validateAndSave(formKey3))
    {
      register();
    }
 
  }
}

bool validateAndSave(formKey) {  
    final form = formKey.currentState;
    if (form.validate()) {
      form.save(); 
     return true;
      }
      else {
      return false;
      }
  }

void cdispose(){
  surname.dispose();
  otherNames.dispose();
  contactAddress.dispose();
  mobileNumber.dispose();
  programStudy.dispose();
  username.dispose();
  email.dispose();
  password.dispose();
}

void imageCheck(){
  if (_image == null){
    setState(() {
      _errorMessage = "Upload an image";
    });
    errorDialog();
  }
  else{
    Navigator.pop(context);
    loaderDialog();
  }
}

void register(){
 showDialog(
      context: context, 
      barrierDismissible: true,
      builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
       titlePadding: EdgeInsets.only(top:13, left: 20.0,),
        contentPadding: EdgeInsets.only(top:10, left: 20.0, right: 10.0, bottom: 5.0),
        title: Text("Submit Registration", style: new TextStyle(color: Colors.blue, fontSize: 17.0),),
        content: Text("Are you sure you want to submit?", style: TextStyle(color: Colors.black, fontSize: 15.0),
        ),
          actions: <Widget>[
             FlatButton(
              child: Text("No", style: new TextStyle(color: Colors.black)),
              onPressed:() => Navigator.pop(context),
            ),
            FlatButton(
              child: Text('Yes', style: new TextStyle(color: Colors.blue),),
              onPressed: (){
              imageCheck();
              }
            ),
          ]
      );
      }
    );

}
void loaderDialog() {
  showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context){
      return AlertDialog( 
        content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
      );
      }
    );
  collectDetails();
}


void errorDialog(){
  Navigator.pop(context);
  showDialog(
      context: context, 
      barrierDismissible: true,
      builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        contentPadding: EdgeInsets.only(top:10, left: 30.0, right: 10.0, bottom: 5.0),
        title: Row(
          children: [
            Icon(Icons.cancel, 
            color: Colors.red),
            Container( margin: EdgeInsets.only(left: 7),
              child: Text("Registration Unsuccessful", style: new TextStyle(color: Colors.red, fontSize: 17.0),)),
          ]
        ),
        titlePadding: EdgeInsets.only(top:13, left: 10.0,),
        content: Text('$_errorMessage ...please try again', style: new TextStyle(color: Colors.black)),
      actions: [
        FlatButton(
              child: Text("Cancel", style: new TextStyle(color: Colors.black)),
              onPressed:() => Navigator.pop(context),
            ),
            FlatButton(
              child: Text('Ok', style: new TextStyle(color: Colors.red),),
              onPressed: (){
               Navigator.pop(context);
              }
            ),
      ],
      );
      }
    );
}

void successDialog(){
  Navigator.pop(context);
  showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.blue),
            Container( margin: EdgeInsets.only(left: 7),
              child: Text("Registration Successful", style: new TextStyle(color: Colors.blue, fontSize: 17.0),)),
          ]
        ),
        contentPadding: EdgeInsets.only(top:10, left: 30.0, right: 10.0, bottom: 5.0),
        titlePadding: EdgeInsets.only(top:13, left: 10.0,),
        content: Text('$_errorMessage'),
      actions: [
            FlatButton(
              child: Text('Ok', style: new TextStyle(color: Colors.blue),),
              onPressed: (){
               Navigator.pop(context);
               Navigator.push(
              context,
            MaterialPageRoute(builder: (context) => LoginPage(
            )
            )
             );
             //cdispose();
              }
            ),
      ],
    );
    }
  );
}


  bool _step1validate = false;
  bool _step2validate = false;
  bool _step3validate = false;
  DateTime pickedDate;
  String _errorMessage;
  String dob; 
  String phoneNum;
  String job;
  String _regDate;
  String _dob;
  bool _isIos;



void collectDetails()
  {
    setState(() {
    dob = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
    _regDate = '${regDate.year}-${regDate.month}-${regDate.day}'; 
    });
    userRegister();
  }

 

  Future userRegister() async{
     
  // SERVER LOGIN API URL
  try
    {
  String apiurl = "http://192.168.71.2/ecgcp/engine.php";
  
   var response = await http.post(Uri.parse(apiurl), body: {
  'Staffid' : username.text,
  'Surname' : surname.text,
  'OtherNames' : otherNames.text,
  'DOB': dob,
  'Maritalstatus' : _selectedMarital.name,
  'dateReg' : _regDate,
  'programStudy': programStudy.text,
  'Phone' : mobileNumber.text,
  'Email' : email.text,
  'contadress' : contactAddress.text,
  'District' : "accra",
  'ContPerMonth' : password.text,
  'gender' : _selectedGender.name,
  'region' : "accas",
  'image' : base64Image
   });

    if(response.statusCode == 200){
    var jsondata = json.decode(response.body);
    

      if(jsondata["error"] == true){
          setState(() {
              _errorMessage = jsondata["message"];
          });
          errorDialog();
      }

    else if (jsondata["message"] == 'User Registration Successful') {
          setState(() {
            _errorMessage = "Your Registration details have been recieved and the password will be sent to ur SMS after it has been approved";
          });
    successDialog();
  }
    }
       
       else{
        setState(() {
           _errorMessage = "Error during connecting to server.";
        });
        errorDialog();
         }
  }

  catch(e)
  {
   setState(() {
           _errorMessage = "Error during connecting to server.";
        });
   errorDialog();
  }
     }
  
  
  DateTime date;
  DateTime regDate = DateTime.now();

   
    _pickDate() async{
   DateTime date = await showDatePicker(
      context: context, 
      initialEntryMode: DatePickerEntryMode.input,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(), 
      firstDate: DateTime(DateTime.now().year-121), 
      lastDate: DateTime(DateTime.now().year+29)
      );
    if (date != null)
    setState(() {
      pickedDate = date;
      _dob = '${pickedDate.month}/${pickedDate.day}/${pickedDate.year}';
    });
    print(pickedDate);
    print(_selectedMarital.name);
  }

 

  String gender = " ";
  List<Genders> _genders = Genders.getGenders();
  List <DropdownMenuItem<Genders>> _dropdownMenuItems;
  Genders _selectedGender;


   File _image;

   List<DropdownMenuItem<Genders>>buildDropdownMenuItems(List genders){
    List<DropdownMenuItem<Genders>> items = List();
      for(Genders gender in genders) {
        items.add(DropdownMenuItem(value: gender, 
        child: Text(gender.name),
        )
        );
      }
        return items;
      }

    String select;
   onChangeDropdownItem(Genders selectedGender){
    setState((){
      _selectedGender = selectedGender;
    });
    }

  String marital = " ";
  List<Maritals> _maritals = Maritals.getMaritals();
  List <DropdownMenuItem<Maritals>> _dropdownMaritalItems;
  Maritals _selectedMarital;



   List<DropdownMenuItem<Maritals>>buildDropdownMaritalItems(List maritals){
    List<DropdownMenuItem<Maritals>> items = List();
      for(Maritals marital in maritals) {
        items.add(DropdownMenuItem(value: marital, 
        child: Text(marital.name),
        )
        );
      }
        return items;
      }

   onChangedDropdownItem(Maritals selectedMarital){
    setState((){
      _selectedMarital= selectedMarital;
    });
    }

    void test(){
      print ("dah");
    }
     
        
             _showSelectImageDialog(){
            if (Platform.isIOS)
            iosBottomSheet();
            else
            androidDialog();
          }
            
            iosBottomSheet() {
              // ignore: missing_required_param
              showCupertinoModalPopup(
                  // context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      title: Text('Add photo'),
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: Text('Take Photo'),
                          onPressed: () => _handleImage(ImageSource.camera),
                        ),
                        CupertinoActionSheetAction(
                          child: Text('Choose from Gallery'),
                          onPressed: () => _handleImage(ImageSource.gallery),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                    );
                  });
            }

            androidDialog() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      shape: Border.all(style: BorderStyle.solid),
                      title: Text(
                        'Add Photo',
                        style: TextStyle(color: Colors.blue),
                      ),
                      children: <Widget>[
                        SimpleDialogOption(
                          child: Text('Take Photo'),
                          onPressed: () {
                            Navigator.pop(context);
                            _handleImage(ImageSource.camera);
                            },
                        ),
                        SimpleDialogOption(
                          child: Text('Choose from Gallery'),
                          onPressed: () {
                            Navigator.pop(context);
                            _handleImage(ImageSource.gallery);
                            },
                        ),
                        SimpleDialogOption(
                          padding: EdgeInsets.only(left: 200, top: 25),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  });
            }
          
          String base64Image;
          Uint8List _bytesImage;

            _handleImage(ImageSource source) async {
              // ignore: deprecated_member_use
              File imageFile = await ImagePicker.pickImage(source: source);
              List<int> imageBytes = imageFile.readAsBytesSync();
              print(imageBytes);
              base64Image = base64Encode(imageBytes);
              setState(() {
                base64Image = base64Encode(imageBytes);
                print(base64Image);
                _image = imageFile;
                 _bytesImage = Base64Decoder().convert(base64Image);
              });
            }
          
           StepperType stepperType = StepperType.horizontal;
            int currentStep;
          
      List<StepState> _listState;
          @override
          void initState()
            {
             // pickedDate = DateTime.now(); 
              _dropdownMenuItems = buildDropdownMenuItems(_genders);
              _dropdownMaritalItems = buildDropdownMaritalItems(_maritals);
              super.initState();
              currentStep = 0;
              _listState = [
            StepState.indexed,
            StepState.editing,
            StepState.complete,
              ];
              super.initState();
            }

        List<Step> _createSteps (BuildContext context){
          List<Step> steps = <Step> [
            Step(
                title: const Text('Basic'),
                isActive: currentStep >= 0? true : false,
                state: currentStep == 0
            ? _listState[1]
            : currentStep > 0 ? _listState[2] : _listState[0],
                content: Form(
                  key: formKey1,
                 autovalidate: _step1validate,
                  child: Column(
                    children: <Widget>[
                      Text("Basic Details", style: TextStyle(color: Colors.blueGrey, fontSize: 20.0 )),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Surname'),
                        controller: surname,
                        validator: (surname){
                          if (surname.isEmpty){
                            return 'Surname is Empty';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Other Names'),
                        controller: otherNames,
                       
                        validator: (otherNames){
                          if (otherNames.isEmpty){
                            return 'Other Names is Empty';
                          }
                         
                          return null;
                        },
                      ),
                      
                        Container(
                          height: 70,
                          width: 320,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, left:0),
                            child: Container(
                              height: 70,
                              width: 130,
                              child: DropdownButtonFormField(
                              decoration: InputDecoration(labelText: 'Gender'),
                              value: _selectedGender,
                              items: _dropdownMenuItems,
                              onChanged: onChangeDropdownItem,
                              validator: (_selectedGender){
                              if (_selectedGender == null){
                               return '*';
                             }
                             return null;
                            },
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left:4, top:0, right:5.0),
                            child:
                              Container(
                                height: 70,
                                width: 130,
                                child: GestureDetector(
                                  onTap: _pickDate,
                                  child: DropdownButtonFormField(
                                  decoration: InputDecoration(labelText: 'Date of Birth'),
                                  hint: pickedDate == null? null : Text('$_dob', style: TextStyle(color: Colors.black)
                                  ),
                                  value: pickedDate,
                                  items: null,
                                  onChanged: null,
                                  validator: (pickedDate){
                                  if (pickedDate == null){
                                   return '*';
                                  }
                                return null;
                                  },
                                  ),
                                ),
                              ),
                          ),
                            ],
                          ),
                        ),
                    
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Contact Address'),
                        controller: contactAddress,
                        validator: (contactAddress){
                          if (contactAddress.isEmpty){
                            return 'Contact Address is Empty';
                          }
                          return null;
                        },
                      ),

                       TextFormField(
                          decoration: InputDecoration(labelText: 'Mobile Number'),
                          controller: mobileNumber,
                          keyboardType: TextInputType.number,
                          validator: (mobileNumber){
                          if (mobileNumber.isEmpty){
                            return 'Mobile Number is Empty';
                          }
                          return null;
                          },
                        ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              

              Step(
                isActive: currentStep >0 ? true : false,
                state: currentStep == 1
                   ? _listState[1]
                  : currentStep > 1 ? _listState[2] : _listState[0],
                title: const Text('Work'),
               // subtitle: Text('Work Details'),
                content: 
                Form(
                  key: formKey2,
                  autovalidate: _step2validate,
                     child: Column(
                    children: <Widget>[
                       Text("Work Details", style: TextStyle(color: Colors.blueGrey, fontSize: 20.0 )),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Name of School'),
                        controller: schoolName,
                        validator: (schoolName){
                        if (schoolName.isEmpty){
                          return 'Name of School is Empty';
                        }
                        return null;
                      },
                      ),
                        
                        TextFormField(
                        decoration: InputDecoration(labelText: 'Program of Study'),
                        controller: programStudy,
                        validator: (programStudy){
                        if (programStudy.isEmpty){
                          return 'Work Address is Empty';
                        }
                        return null;
                      },    
                        ),
                    
                      Padding(
                        padding: EdgeInsets.only(bottom:30.0),
                        child: TextFormField(
                        decoration: InputDecoration(labelText: 'Current Level'),
                        controller: currentLevel,
                        validator: (currentLevel){
                        if (currentLevel.isEmpty){
                          return 'Current levek is Empty';
                        }
                        return null;
                      },    
                        ),
                      ),
                    ],
                  ),
                ),
              ),
  
              
              Step(
                isActive: currentStep >1? true : false ,
                state: currentStep == 2
                ? _listState[1]
                : currentStep > 2 ? _listState[2] : _listState[0],
                title: const Text('Account'),
                content: Form(
                  key: formKey3,
                  autovalidate: _step3validate,
                  child: Column(
                    children: <Widget>[ 
                     Text("Account Details", style: TextStyle(color: Colors.blueGrey, fontSize: 20.0 )),
                     SizedBox(height:20),
                    GestureDetector(
                      onTap: _showSelectImageDialog,
                       child: 
                       CircleAvatar(
                        radius: 83.0,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:  _image == null? null : FileImage (_image),
                        child: _image == null? Center(
                                child: Icon(       
                                        Icons.person_add,
                                        color: Colors.blue,
                                        size: 130.0,
                                      ),
                              ): null
                        ),
                     ), 
                     SizedBox(height:10.0),
                     Text('*You must upload a standard passport photogragh', style: TextStyle(fontSize: 12.0, color: Colors.red, fontStyle: FontStyle.italic)),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Username'),
                        controller: username,
                        validator: (username){
                        if (username.isEmpty){
                      return 'Username is Empty';
                         }
                           return null;
                       }
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                         validator: (email){
                          if (email.isEmpty){
                            return 'Email is Empty';
                          }
                          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email))
                          {
                            return 'Email is not valid';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password',
                         suffixIcon: InkWell(
                    onTap:  () =>
                      setState(() {
                     _obscureText = !_obscureText;
                    }),
                    child: Icon(
                      _obscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 17.0,
                      color: Colors.black,
                    ),
                  ),
                        ),
                        controller: password,
                        obscureText: _obscureText, 
                        validator: (password){
                          if (password.isEmpty){
                            return 'Contribution is Empty';
                          }
                          return null;
                        },
                      ),
                       TextFormField(
                        decoration: InputDecoration(labelText: 'Confirm Password',
                        suffixIcon: InkWell(
                    onTap:  () =>
                      setState(() {
                     _cobscureText = !_cobscureText;
                    }),
                    child: Icon(
                      _cobscureText
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: 17.0,
                      color: Colors.black,
                    ),
                  ),),
                        controller: confirmPassword,
                        
                        obscureText: true,
                        validator: (confirmPassword){
                          if (confirmPassword.isEmpty){
                            return '*';
                          }
                          return null;
                        },
                  ),
                  SizedBox(
                    height: 30
                  )
                    ],
                  ),
                ),
              ),
            ];
            return steps;
             }
          
            switchStepType() {
              setState(() => stepperType == StepperType.horizontal
                  ? stepperType = StepperType.vertical
                  : stepperType = StepperType.horizontal);
            }
          
          
            @override
            Widget build(BuildContext context) {
              _isIos = Theme.of(context).platform == TargetPlatform.iOS;
              List<Step> _stepList = _createSteps(context);
              return new Scaffold(
                body: Column(children: <Widget>[
                    Expanded(
                      child: Stepper(
                         controlsBuilder:
                         (BuildContext context, { VoidCallback onStepContinue, VoidCallback onStepCancel }) {
                         return Row(
                           children: <Widget>[
                            FlatButton(
                              onPressed: onStepCancel,
                              child: Text('BACK'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left:40.0),
                              child: RaisedButton(
                                color: Colors.orangeAccent,
                                onPressed:
                                stepAction,
                                child: currentStep == 2? Text('FINISH') : Text('NEXT'),
                              ),
                            ),
                          ],
                      );
                         },
                          steps: _stepList,
                          type: stepperType,
                          currentStep: currentStep,
                          onStepContinue: onStepContinue,

                          onStepCancel: (){ 
                             setState(() {
                        if (currentStep > 0) {
                          currentStep--;
                        } else {
                          currentStep = 0;
                        }
                      });
                          },
                          onStepTapped: null,
                          ),
                    ),
                ]),

                floatingActionButton: FloatingActionButton(
                  tooltip: 'Toggle the page between vertical and horizontal',
                  onPressed: switchStepType,
                  child: stepperType == StepperType.horizontal? Icon(Icons.swap_vert): Icon(Icons.swap_horiz),
                ),
              );
            }
          }

          
  
     
    
          
          
         
