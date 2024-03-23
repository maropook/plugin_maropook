import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let helloMethodChannel = FlutterMethodChannel(name: "appInfo",binaryMessenger: controller as! FlutterBinaryMessenger)
    helloMethodChannel.setMethodCallHandler({
      (call:FlutterMethodCall,result:FlutterResult) -> Void in
      switch call.method{
          case "getAppVersion":
              result(Bundle.main.object(forInfoDictionaryKey:"CFBundleShortVersionString") as? String)
          default:
             result("iOS d " + UIDevice.current.systemVersion)
      }
    })
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
