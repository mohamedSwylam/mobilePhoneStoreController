import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:kinda_chees/layout/cubit/cubit.dart';
import 'package:kinda_chees/layout/cubit/states.dart';
import 'package:kinda_chees/modules/Login_screen/login_screen.dart';
import 'package:kinda_chees/shared/components/components.dart';
import 'package:kinda_chees/shared/constants/constant.dart';
import 'package:kinda_chees/styles/colors/colors.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class UploadProductScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreAppCubit, StoreAppStates>(
      listener: (context, state) {
        if (state is CreateProductSuccessState) {
          showToast(text: ' تم اضافه المنتج بنجاح', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        var profileImage = StoreAppCubit.get(context).productImage;
        var cubit = StoreAppCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Expanded(
                          //  flex: 2,
                          child: profileImage == null
                              ? Container(
                                  margin: EdgeInsets.all(10),
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(4),
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.all(10),
                                  height: 200,
                                  width: 200,
                                  child: Container(
                                    height: 200,
                                    // width: 200,
                                    decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.only(
                                      //   topLeft: const Radius.circular(40.0),
                                      // ),
                                      color: Theme.of(context).backgroundColor,
                                    ),
                                    child: Image.file(
                                      profileImage,
                                      fit: BoxFit.fill,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'اختر طريقه',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  ColorsConsts.gradiendLStart),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  StoreAppCubit.get(context)
                                                      .pickImageCamera();
                                                  Navigator.pop(context);
                                                },
                                                splashColor: Colors.teal,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color: Colors.teal,
                                                      ),
                                                    ),
                                                    Text(
                                                      'الكاميرا',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorsConsts
                                                              .title),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  StoreAppCubit.get(context)
                                                      .getProfileImageGallery();
                                                  Navigator.pop(context);
                                                },
                                                splashColor: Colors.teal,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color: Colors.teal,
                                                      ),
                                                    ),
                                                    Text(
                                                      'المعرض',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ColorsConsts
                                                              .title),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  StoreAppCubit.get(context)
                                                      .remove();
                                                  Navigator.pop(context);
                                                },
                                                splashColor: Colors.teal,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      'حذف',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Feather.camera,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            backgroundColor: Colors.teal,
                            radius: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Container(
                          width: 210,
                          child: TextFormField(
                            controller: cubit.productTitleController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'ادخل اسم المنتج';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'اسم المنتج',
                                fillColor: Theme.of(context).backgroundColor),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 120,
                          child: TextFormField(
                            key: ValueKey('Price \$'),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'ادخل سعر المنتج';
                              }
                              return null;
                            },
                            onSaved: (value)=> StoreAppCubit.get(context).inputPrice(value),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'سعر المنتج',
                                fillColor: Theme.of(context).backgroundColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: double.infinity,
                      child: TextFormField(
                        controller: cubit.productDescriptionController,
                        maxLines: 10,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'ادخل وصف المنتج';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'وصف المنتج',
                            fillColor: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: 160,
                          height: 40,
                          child: DropdownButton<String>(
                            items: [
                              DropdownMenuItem<String>(
                                child: Text('redmi'),
                                value: 'redmi',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('itel'),
                                value: 'itel',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('lenovo'),
                                value: 'lenovo',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('other'),
                                value: 'other',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('Apple'),
                                value: 'Apple',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('oppo'),
                                value: 'oppo',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('realme'),
                                value: 'realme',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('nokia'),
                                value: 'nokia',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('Samsung'),
                                value: 'Samsung',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('Huawei'),
                                value: 'Huawei',
                              ),DropdownMenuItem<String>(
                                child: Text('sony'),
                                value: 'sony',
                              ),DropdownMenuItem<String>(
                                child: Text('vivo'),
                                value: 'vivo',
                              ),DropdownMenuItem<String>(
                                child: Text('tecno'),
                                value: 'tecno',
                              ), DropdownMenuItem<String>(
                                child: Text('infnix'),
                                value: 'infnix',
                              ),
                            ],
                            onChanged: (value) => cubit.changeBrand(value),
                            hint: Center(child: Text('${cubit.productBrand}')),
                            borderRadius: BorderRadius.circular(10),
                            isExpanded: true,
                            isDense: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          width: 160,
                          height: 40,
                          child: DropdownButton<String>(
                            items: [
                              DropdownMenuItem<String>(
                                child: Text('phones'),
                                value: 'phones',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('headphones'),
                                value: 'headphones',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('charger'),
                                value: 'charger',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('used'),
                                value: 'used',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('mobile'),
                                value: 'mobile',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('cable'),
                                value: 'cable',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('watches'),
                                value: 'watches',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('memory'),
                                value: 'memory',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('cover'),
                                value: 'cover',
                              ),
                              DropdownMenuItem<String>(
                                child: Text('screen'),
                                value: 'screen',
                              ),DropdownMenuItem<String>(
                                child: Text('tablet'),
                                value: 'tablet',
                              ),DropdownMenuItem<String>(
                                child: Text('powerbank'),
                                value: 'powerbank',
                              ), DropdownMenuItem<String>(
                                child: Text('computer'),
                                value: 'computer',
                              ),
                            ],
                            onChanged: (value) => cubit.changeCategory(value),
                            hint: Center(child: Text('${cubit.productCategory}')),
                            borderRadius: BorderRadius.circular(10),
                            isExpanded: true,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 10),
                      Container(
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(
                                    color: ColorsConsts.backgroundColor),
                              ),
                            )),
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                StoreAppCubit.get(context)
                                    .createProduct(context);
                                StoreAppCubit.get(context).getProduct();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'اضافه منتج',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.add,
                                  size: 18,
                                )
                              ],
                            )),
                        width: 180,
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
