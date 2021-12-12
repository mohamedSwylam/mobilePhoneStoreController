import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kinda_chees/layout/cubit/states.dart';
import 'package:kinda_chees/local/cache_helper.dart';
import 'package:kinda_chees/models/product_model.dart';
import 'package:kinda_chees/modules/cart_screen.dart';
import 'package:kinda_chees/modules/feeds.dart';
import 'package:kinda_chees/modules/home.dart';
import 'package:kinda_chees/modules/search/search_screen.dart';
import 'package:kinda_chees/modules/user_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:kinda_chees/shared/constants/constant.dart';
import 'package:uuid/uuid.dart';
class StoreAppCubit extends Cubit<StoreAppStates> {
  StoreAppCubit() : super(StoreAppInitialState());

  static StoreAppCubit get(context) => BlocProvider.of(context);
  int selectedIndex =0;
  var pages = [
  {
  'page': UploadProductScreen(),
  'title': 'Home Screen',
  },
  {
  'page': FeedScreen(),
  'title': 'Feeds Screen',
  },
  {
  'page': SearchScreen(),
  'title': 'SearchScreen',
  },
  {
  'page': CartScreen(),
  'title': 'Cart Screen',
  },
  {
  'page': UserScreen(),
  'title': 'User Screen',
  },
  ];
  void selectedPage(int index) {
      selectedIndex = index;
      emit(StoreAppBottomBarChangeState());
  }
  void selectedSearch() {
      selectedIndex = 2;
      emit(StoreAppBottomBarSearchState());
  }

  bool isDark = false;

 void changeThemeMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(StoreAppChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {});
      emit(StoreAppChangeThemeModeState());
    }
  }
  void changeThemeModeToDark({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(StoreAppChangeThemeModeState());
    } else {
      isDark = true;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {});
      emit(StoreAppChangeThemeModeState());
    }
  }
  void changeThemeModeToLight({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(StoreAppChangeThemeModeState());
    } else {
      isDark = false;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {});
      emit(StoreAppChangeThemeModeState());
    }
  }
  File productImage;
  String url='https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';
  var picker = ImagePicker();
  Future<void> getProfileImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      uploadProfileImage();
      emit(StoreAppPickedProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(StoreAppPickedProfileImageErrorState());
    }
  }
  void uploadProfileImage() {
    emit(UploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('products/${Uri.file(productImage.path).pathSegments.last}')
        .putFile(productImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadPickedProfileImageSuccessState());
        url=value;
        print(value);
      }).catchError((error) {
        emit(UploadPickedProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadPickedProfileImageErrorState());
    });
  }
  void pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
    await picker.getImage(source: ImageSource.camera, imageQuality: 10);
    final pickedImageFile = File(pickedImage.path);
    productImage = pickedImageFile;
    uploadProfileImage();
    emit(StoreAppPickedProfileImageCameraSuccessState());
  }

  void remove() {
    url = 'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';
    uploadProfileImage();
    emit(StoreAppRemoveProfileImageSuccessState());
  }
  var productTitleController = TextEditingController();
  var productPrice ;
  var productDescriptionController = TextEditingController();
   String productCategory='صنف المنتج';
   String productBrand='ماركه المنتج';

  var uuid = Uuid();
  void changeCategory(String value) {
   productCategory = value;
    emit(StoreAppChangeUploadProductCategorySuccessState());
  }
  void inputPrice(value) {
   productPrice = value;
    emit(StoreAppInputPriceSuccessState());
  }
  void changeBrand(String value) {
    productBrand = value;
    emit(StoreAppChangeUploadProductBrandSuccessState());
  }
  void createProduct(context) {
    final productId=uuid.v4();
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .set({
      'id': productId.toString(),
      'title': productTitleController.text,
      'description': productDescriptionController.text,
      'price': productPrice,
      'imageUrl': url,
      'productCategoryName': productCategory,
      'brand': productBrand,
      'isPopular': true,
    }).then((value) {
      Navigator.canPop(context)?Navigator.pop(context):null;
      emit(CreateProductSuccessState());
    }).catchError((error) {
      emit(CreateProductErrorState(error.toString()));
    });
  }
  List<Product> products = [];
  void getProduct() async {
    emit(GetProductLoadingStates());
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productsSnapshot) {
      products = [];
      productsSnapshot.docs.forEach((element) {
        // print('element.get(productBrand), ${element.get('productBrand')}');
        products.insert(
          0,
          Product(
              id: element.get('id'),
              title: element.get('title'),
              description: element.get('description'),
              price: element.get('price'),
              imageUrl: element.get('imageUrl'),
              brand: element.get('brand'),
              productCategoryName: element.get('productCategoryName'),
              isPopular: true),
        );
      });
      emit(GetProductSuccessStates());
    }).catchError((error) {
      emit(GetProductErrorStates());
    });
  }

  void removeProduct(productId) async {
    emit(RemoveProductLoadingStates());
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId).delete()
        .then((_) {
      getProduct();
      emit(RemoveProductSuccessStates());
    }).catchError((error) {
      emit(RemoveProductErrorStates());
    });
  }
}
var uuid = Uuid();

