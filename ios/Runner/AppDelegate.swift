import UIKit
import Flutter
//import google
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    //GMSServices.provideAPIKey(AIzaSyBLmpxMi1LTBieITR4dWMFqFtCGzQ57b08)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
