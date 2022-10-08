import 'package:cached_network_image/cached_network_image.dart';
import 'package:eros_n/network/app_dio/dio_file_service.dart';
import 'package:eros_n/utils/eros_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

final imageCacheManager = CacheManager(
  Config(
      'CachedNetworkImage',
      fileService: DioFileService()
  ),
);

class ErosCachedNetworkImage extends StatelessWidget {
  const ErosCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.placeholder,
    this.errorWidget,
    this.progressIndicatorBuilder,
    this.httpHeaders,
    this.onLoadCompleted,
    this.checkPHashHide = false,
    this.checkQRCodeHide = false,
    this.onHideFlagChanged,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.medium,
  }) : super(key: key);

  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Map<String, String>? httpHeaders;

  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final VoidCallback? onLoadCompleted;
  final bool checkPHashHide;
  final bool checkQRCodeHide;
  final ValueChanged<bool>? onHideFlagChanged;
  final FilterQuality filterQuality;

  /// If non-null, this color is blended with each image pixel using [colorBlendMode].
  final Color? color;

  /// Used to combine [color] with this image.
  ///
  /// The default is [BlendMode.srcIn]. In terms of the blend mode, [color] is
  /// the source and this image is the destination.
  ///
  /// See also:
  ///
  ///  * [BlendMode], which includes an illustration of the effect of each blend mode.
  final BlendMode? colorBlendMode;

  // ImageWidgetBuilder get imageWidgetBuilder => (context, imageProvider) {
  //       return OctoImage(
  //         image: imageProvider,
  //         width: width,
  //         height: height,
  //         fit: fit,
  //       );
  //     };

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      cacheManager: imageCacheManager,
      // imageBuilder: imageWidgetBuilder,
      httpHeaders: httpHeaders,
      filterQuality: filterQuality,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      // imageUrl: imageUrl.handleUrl,
      imageUrl: imageUrl,
      placeholder: placeholder,
      errorWidget: errorWidget,
      cacheKey: buildImageCacheKey(imageUrl),
      progressIndicatorBuilder: progressIndicatorBuilder,
    );

    return image;
  }
}

ImageProvider getErorsImageProvider(String url) {
  return CachedNetworkImageProvider(
    url,
    cacheManager: imageCacheManager,
    cacheKey: buildImageCacheKey(url),
  );
}
