import Flutter
import SBPPayment
import UIKit

public class SwiftSbpPaymentsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "github.com/MrOlolo/sbp_payments", binaryMessenger: registrar.messenger())
        let instance = SwiftSbpPaymentsPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "showBanks":
            if let topController = getTopViewController() {
                SBPWidgetModule().show(on: topController) { res in
                    switch res {
                    case .success(let scheme):
                        if let bankScheme = scheme {
                            let args = call.arguments as! [String: Any]
                            let link = args["url"] as! String
                            _ = self.openLinkWithBank(link, bankScheme)
                            result(true)
                        } else {
                            result(false)
                        }

                    case .failure:
                        result(false)
                    }
                }

            } else {
                result(false)
            }

        case "openWithBank":
            if let args = call.arguments as? [String: Any] {
                let link = args["url"] as! String
                let scheme = args["scheme"] as! String
                result(self.openLinkWithBank(link, scheme))

            } else {
                result(false)
            }

        case "showBanksCustom":
            if let args = call.arguments as? [String: Any] {
                let textColor = args["text"] as! Int
                let backgroundColor = args["background"] as! Int

                if let topController = getTopViewController() {
                    SBPWidgetModule().show(on: topController, backgroundColor: backgroundColor, textColor: textColor) { res in
                        switch res {
                        case .success(let scheme):
                            if let bankScheme = scheme {
                                let args = call.arguments as! [String: Any]
                                let link = args["url"] as! String
                                _ = self.openLinkWithBank(link, bankScheme)
                                result(true)
                            } else {
                                result(false)
                            }

                        case .failure:
                            result(false)
                        }
                    }

                } else {
                    result(false)
                }
            } else {
                result(false)
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func getTopViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            return topController
        }

        return nil
    }

    private func openLinkWithBank(_ link: String, _ bankScheme: String) -> Bool {
        let url = URL(string: link.replacingOccurrences(of: "https://", with: "\(bankScheme)://").replacingOccurrences(of: "http://", with: "\(bankScheme)://"))!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return true
        } else {
            return false
        }
    }
}
