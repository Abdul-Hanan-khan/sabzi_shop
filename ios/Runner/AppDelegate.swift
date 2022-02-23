import UIKit
import Flutter
import Firebase
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  GMSServices.provideAPIKey("AIzaSyDodI_dtDEr_P9ur1yYfW80QM3NQoStAxA")
    GeneratedPluginRegistrant.register(with: self)
//      FirebaseApp.configure() 
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
