import UIKit
import Flutter

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.setTitle("Open Flutter Module", for: .normal)
        button.addTarget(self, action: #selector(openFlutterModule), for: .touchUpInside)
        button.frame = CGRect(x: 60, y: 300, width: 250, height: 50)
        self.view.addSubview(button)
    }

    @objc func openFlutterModule() {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)

        let channel = FlutterMethodChannel(name: "jodetx/payment", binaryMessenger: flutterViewController.binaryMessenger)

        channel.setMethodCallHandler { (call, result) in
            if call.method == "paymentResult",
               let args = call.arguments as? [String: Any],
               let status = args["status"] as? String,
               let amount = args["amount"] as? Double {
                
                let alert = UIAlertController(
                    title: "Payment \(status)",
                    message: "Amount: ₹\(amount)",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                flutterViewController.dismiss(animated: true)
                self.present(alert, animated: true)
            }
        }

        self.present(flutterViewController, animated: true, completion: nil)
    }
}
