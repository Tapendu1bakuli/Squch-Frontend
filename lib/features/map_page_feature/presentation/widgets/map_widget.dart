import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizing/sizing.dart';
import 'package:squch/features/map_page_feature/presentation/controller/map_controller.dart';

class MapWidget extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return  CustomGoogleMapMarkerBuilder(
      //screenshotDelay: const Duration(seconds: 4),
      customMarkers: controller.customMarkers ?? <MarkerData>[],
      builder: (BuildContext context, Set<Marker>? markers) {
        print("Markers => ${markers}");
        return  GoogleMap(
              padding: EdgeInsets.only(
                  top: 20.ss,
                  bottom: controller.mapBottomPadding.value,right: 5.ss,left: 5.ss),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              buildingsEnabled: true,
              fortyFiveDegreeImageryEnabled: true,
              liteModeEnabled: false,
              tiltGesturesEnabled: false,
              mapToolbarEnabled: true,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              scrollGesturesEnabled: true,
              compassEnabled: true,
              minMaxZoomPreference: MinMaxZoomPreference(4.0,18),
              initialCameraPosition: CameraPosition(
                target: LatLng(controller.currLat, controller.currLong),
                zoom: controller.mapZoomLevel.value,
              ),
              markers: markers != null? markers: <Marker>{},
              onMapCreated: controller.onMapCreated,
              polylines: controller.polyline.value);

      },
    );
  }
}
