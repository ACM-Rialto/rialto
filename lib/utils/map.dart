import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MapWithCenterPin extends StatefulWidget {
  final double width;
  final double height;
  final bool scrollable;
  final bool showVerificationButton;
  final LatLng startingLocation;
  final double zoom;

  MapWithCenterPin(
      {Key key,
      @required this.width,
      @required this.height,
      @required this.zoom,
      this.startingLocation,
      this.scrollable = true,
      this.showVerificationButton = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MapWithCenterPinState();
  }
}

class MapWithCenterPinState extends State<MapWithCenterPin> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng currentLatLng;
  bool verified = false;
  GoogleMapsPlaces _place =
      GoogleMapsPlaces(apiKey: "AIzaSyDGfds7oyWUu5yqfG8Ce-8Dv6SF528x_Jg");

  @override
  void initState() {
    super.initState();
    print('${widget.startingLocation}');
    currentLatLng = widget.startingLocation == null
        ? const LatLng(45.521563, -122.677433)
        : widget.startingLocation;
    if (widget.startingLocation == null) {
      Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((position) {
        _controller.future.then((controller) {
          controller.moveCamera(CameraUpdate.newLatLng(
            new LatLng(position.latitude, position.longitude),
          ));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: widget.width,
          height: widget.height,
          child: _buildMap(),
        ),
        _buildCenterPin(),
        _buildVerifiedCheck(),
        Container(
          width: widget.width,
          height: widget.height,
          child: widget.showVerificationButton
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      child: Icon(
                        Icons.not_listed_location,
                        color: Theme.of(context).accentColor,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        updateVerificationStatus();
                      },
                    ),
                  ),
                )
              : Container(),
        )
      ],
    );
  }

  Future _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: currentLatLng,
        zoom: widget.zoom,
      ),
      gestureRecognizers: widget.scrollable
          ? <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet()
          : null,
      onCameraMove: (position) {
        currentLatLng = position.target;
      },
    );
  }

  Widget _buildCenterPin() {
    const double iconSize = 40.0;
    return Positioned(
      top: (widget.height - iconSize) / 2,
      right: (widget.width - iconSize) / 2,
      child: new Icon(
        Icons.person_pin_circle,
        size: iconSize,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildVerifiedCheck() {
    if (verified) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Align(
          alignment: Alignment.topRight,
          child: FittedBox(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                ),
                Text(
                  "Verified",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Future updateVerificationStatus() async {
    final location = Location(currentLatLng.latitude, currentLatLng.longitude);
    final result =
        await _place.searchNearbyWithRadius(location, 250, type: 'university');
    if (result.results.isNotEmpty) {
      verified = true;
    } else {
      verified = false;
    }
    setState(() {});
  }
}
