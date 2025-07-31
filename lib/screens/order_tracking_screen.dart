import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:math' as math;

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;
  final String restaurantName;
  final String deliveryAddress;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
    required this.restaurantName,
    required this.deliveryAddress,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  GoogleMapController? _mapController;
  Location location = Location();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  LatLng? _currentLocation;
  LatLng? _deliveryLocation;
  LatLng? _restaurantLocation;
  Timer? _locationTimer;
  
  // محاكاة موقع السائق
  LatLng? _driverLocation;
  int _routeIndex = 0;
  List<LatLng> _simulatedRoute = [];
  
  // معلومات الطلب
  String _orderStatus = 'قيد التحضير';
  String _estimatedTime = '25 دقيقة';
  String _driverName = 'أحمد محمد';
  String _driverPhone = '+966501234567';
  double _driverRating = 4.8;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  @override
  void dispose() {
    _locationTimer?.cancel();
    super.dispose();
  }

  Future<void> _initializeMap() async {
    await _getCurrentLocation();
    _setMockLocations();
    _createSimulatedRoute();
    _startLocationUpdates();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      // في حالة فشل الحصول على الموقع، استخدم موقع افتراضي (الرياض)
      setState(() {
        _currentLocation = const LatLng(24.7136, 46.6753);
      });
    }
  }

  void _setMockLocations() {
    // مواقع وهمية للاختبار (الرياض)
    _restaurantLocation = const LatLng(24.7136, 46.6753); // موقع المطعم
    _deliveryLocation = const LatLng(24.7236, 46.6853); // موقع التوصيل
    _driverLocation = const LatLng(24.7156, 46.6773); // موقع السائق الحالي
  }

  void _createSimulatedRoute() {
    // إنشاء مسار محاكي للسائق
    _simulatedRoute = [
      const LatLng(24.7156, 46.6773),
      const LatLng(24.7166, 46.6783),
      const LatLng(24.7176, 46.6793),
      const LatLng(24.7186, 46.6803),
      const LatLng(24.7196, 46.6813),
      const LatLng(24.7206, 46.6823),
      const LatLng(24.7216, 46.6833),
      const LatLng(24.7226, 46.6843),
      const LatLng(24.7236, 46.6853), // الوجهة النهائية
    ];
  }

  void _startLocationUpdates() {
    _locationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _updateDriverLocation();
    });
  }

  void _updateDriverLocation() {
    if (_routeIndex < _simulatedRoute.length) {
      setState(() {
        _driverLocation = _simulatedRoute[_routeIndex];
        _routeIndex++;
        
        // تحديث حالة الطلب حسب الموقع
        if (_routeIndex <= 2) {
          _orderStatus = 'قيد التحضير';
          _estimatedTime = '20 دقيقة';
        } else if (_routeIndex <= 6) {
          _orderStatus = 'في الطريق';
          _estimatedTime = '10 دقائق';
        } else if (_routeIndex >= _simulatedRoute.length) {
          _orderStatus = 'تم التوصيل';
          _estimatedTime = 'وصل';
          _locationTimer?.cancel();
        }
      });
      _updateMapMarkers();
    }
  }

  void _updateMapMarkers() {
    _markers.clear();
    
    // علامة المطعم
    if (_restaurantLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('restaurant'),
          position: _restaurantLocation!,
          infoWindow: InfoWindow(
            title: widget.restaurantName,
            snippet: 'موقع المطعم',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }

    // علامة موقع التوصيل
    if (_deliveryLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('delivery'),
          position: _deliveryLocation!,
          infoWindow: InfoWindow(
            title: 'موقع التوصيل',
            snippet: widget.deliveryAddress,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    // علامة السائق
    if (_driverLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: _driverLocation!,
          infoWindow: InfoWindow(
            title: _driverName,
            snippet: 'السائق',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      );
    }

    // رسم المسار
    if (_driverLocation != null && _deliveryLocation != null) {
      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: [_driverLocation!, _deliveryLocation!],
          color: const Color(0xFF3B82F6),
          width: 4,
          patterns: [PatternItem.dash(20), PatternItem.gap(10)],
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _updateMapMarkers();
    
    // تحريك الكاميرا لإظهار جميع العلامات
    if (_restaurantLocation != null && _deliveryLocation != null) {
      _fitMarkersInView();
    }
  }

  void _fitMarkersInView() {
    if (_mapController == null) return;
    
    double minLat = math.min(_restaurantLocation!.latitude, _deliveryLocation!.latitude);
    double maxLat = math.max(_restaurantLocation!.latitude, _deliveryLocation!.latitude);
    double minLng = math.min(_restaurantLocation!.longitude, _deliveryLocation!.longitude);
    double maxLng = math.max(_restaurantLocation!.longitude, _deliveryLocation!.longitude);
    
    if (_driverLocation != null) {
      minLat = math.min(minLat, _driverLocation!.latitude);
      maxLat = math.max(maxLat, _driverLocation!.latitude);
      minLng = math.min(minLng, _driverLocation!.longitude);
      maxLng = math.max(maxLng, _driverLocation!.longitude);
    }
    
    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat - 0.01, minLng - 0.01),
          northeast: LatLng(maxLat + 0.01, maxLng + 0.01),
        ),
        100.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تتبع الطلب #${widget.orderId}'),
        centerTitle: true,
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // معلومات الطلب
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF3B82F6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _orderStatus,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'الوصول المتوقع: $_estimatedTime',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.delivery_dining,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // الخريطة
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _currentLocation != null
                    ? GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _currentLocation!,
                          zoom: 13,
                        ),
                        markers: _markers,
                        polylines: _polylines,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: false,
                        mapToolbarEnabled: false,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
          
          // معلومات السائق
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFF3B82F6),
                  child: Text(
                    _driverName.split(' ')[0][0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _driverName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _driverRating.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showContactDialog();
                  },
                  icon: const Icon(
                    Icons.phone,
                    color: Color(0xFF3B82F6),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showMessageDialog();
                  },
                  icon: const Icon(
                    Icons.message,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('الاتصال بالسائق'),
        content: Text('هل تريد الاتصال بـ $_driverName؟\n$_driverPhone'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // هنا يمكن إضافة كود الاتصال الفعلي
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('جاري الاتصال...')),
              );
            },
            child: const Text('اتصال'),
          ),
        ],
      ),
    );
  }

  void _showMessageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إرسال رسالة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('إرسال رسالة إلى $_driverName'),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال الرسالة')),
              );
            },
            child: const Text('إرسال'),
          ),
        ],
      ),
    );
  }
}

