import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = UINavigationController(rootViewController: RootViewController())
		window?.makeKeyAndVisible()
		// Override point for customization after application launch.
		return true
	}
}
