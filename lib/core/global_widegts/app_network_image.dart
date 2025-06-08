import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prettyrini/core/const/image_path.dart';


class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({super.key, required this.src,  this.height = 100,  this.width = 100, this.fit = BoxFit.cover});

  final String src;
  final double height;
  final double width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: src,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context,url)=>Image.asset(ImagePath.loginLogo,height: 50,width: 50,fit:BoxFit.cover,),
      errorWidget: (context, url, error) => Image.asset(ImagePath.loginLogo,height: 50,width: 50,),
    );
  }
}