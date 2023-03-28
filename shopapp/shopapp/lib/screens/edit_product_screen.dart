import 'package:flutter/material.dart';
import 'package:shopapp/providers/product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class editproductscreen extends StatefulWidget {
  static const RouteNamed = '/editproducts';
  const editproductscreen({Key key}) : super(key: key);

  @override
  State<editproductscreen> createState() => _editproductscreenState();
}

class _editproductscreenState extends State<editproductscreen> {
  final _pricefocusnode = FocusNode();
  final _descfocusnode = FocusNode();
  final _imageurcontroller = TextEditingController();
  final _imageurlfocusnode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedproduct =
      product(id: null, title: '', price: 0, imageurl: '', description: '');
  var _initvalues = {
    'title': '',
    'description': '',
    'price': '',
    'imageurl': '',
  };
  var isinit = true;
  var isloading = false;
  void dispose() {
    _imageurlfocusnode.removeListener(() {
      _updateimageurl();
    });
    _descfocusnode.dispose();
    _pricefocusnode.dispose();
    _imageurcontroller.dispose();
    _imageurlfocusnode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _imageurlfocusnode.addListener(() {
      _updateimageurl();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isinit) {
      final prodid = ModalRoute.of(context).settings.arguments as String;
      if (prodid != null) {
        _editedproduct =
            Provider.of<products>(context, listen: false).findbyid(prodid);
        _initvalues = {
          'title': _editedproduct.title,
          'description': _editedproduct.description,
          'price': _editedproduct.price.toString(),
          'imageurl': '',
        };
        _imageurcontroller.text = _editedproduct.imageurl;
      }
    }
    isinit = false;
    super.didChangeDependencies();
  }

  void _updateimageurl() {
    if (!_imageurlfocusnode.hasFocus) {
      setState(() {});
    }
  }

  Future <void> _saveform() async{
    final isvalid = _form.currentState.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      isloading = true;
    });

    if (_editedproduct.id != null) {
      await Provider.of<products>(context, listen: false)
          .updateproduct(_editedproduct.id, _editedproduct);
     
    } else {
      try{
        await Provider.of<products>(context, listen: false)
          .addproduct(_editedproduct);

      }
      catch(error){
            await showDialog(context: context, builder: (ctx){
              return AlertDialog(title: Text('Error Ocuured'),content: Text('Something Went Wrong.'), actions: [
                TextButton(onPressed: (){
                  Navigator.of(ctx).pop();
                }, child: Text('Close'))
              ],);
            });
        //   }finally{
        //     setState(() {
        //   isloading = false;
        //   Navigator.of(context).pop();
        // });

        //   }
    }
         setState(() {
        isloading = false;
      });
      Navigator.of(context).pop();
         
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,

      //backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text('Edit Products'),
        actions: [IconButton(onPressed: _saveform, icon: Icon(Icons.save))],
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initvalues['title'],
                        decoration: InputDecoration(label: Text('Title')),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_pricefocusnode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a  Value here';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _editedproduct = product(
                              id: _editedproduct.id,
                              isfavourite: _editedproduct.isfavourite,
                              title: newValue,
                              price: _editedproduct.price,
                              imageurl: _editedproduct.imageurl,
                              description: _editedproduct.description);
                        },
                      ),
                      TextFormField(
                        initialValue: _initvalues['price'],
                        decoration: InputDecoration(label: Text('Price' , )),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _pricefocusnode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_descfocusnode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a  Valid Value here';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please provide a  Valid Value here';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Please provide a  Valid Value here';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _editedproduct = product(
                              id: _editedproduct.id,
                              isfavourite: _editedproduct.isfavourite,
                              title: _editedproduct.title,
                              price: double.parse(newValue),
                              imageurl: _editedproduct.imageurl,
                              description: _editedproduct.description);
                        },
                      ),
                      TextFormField(
                        initialValue: _initvalues['description'],
                        decoration: InputDecoration(label: Text('Description' , ), ),
                        textInputAction: TextInputAction.next,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descfocusnode,
                        onSaved: (newValue) {
                          _editedproduct = product(
                            id: _editedproduct.id,
                            isfavourite: _editedproduct.isfavourite,
                            title: _editedproduct.title,
                            price: _editedproduct.price,
                            imageurl: _editedproduct.imageurl,
                            description: newValue,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a  Value here';
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: _imageurcontroller.text.isEmpty
                                ? Text('Enter a Url' , style: TextStyle(color: Colors.white))
                                : FittedBox(
                                    child:
                                        Image.network(_imageurcontroller.text),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(label: Text('Add Url' ,)),
                              textInputAction: TextInputAction.done,
                              controller: _imageurcontroller,
                              onFieldSubmitted: (_) {
                                _saveform();
                              },
                              onSaved: (newValue) {
                                _editedproduct = product(
                                    id: _editedproduct.id,
                                    isfavourite: _editedproduct.isfavourite,
                                    title: _editedproduct.title,
                                    price: _editedproduct.price,
                                    imageurl: newValue,
                                    description: _editedproduct.description);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a  Value here';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
