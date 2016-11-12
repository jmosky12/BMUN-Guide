//
//  QuestionsViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 12/6/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit
//import Parse

protocol QuestionsViewControllerDelegate {
    func textViewFill(_ text: String)
    func sendOverText() -> String
}

class QuestionsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, QuestionsViewControllerDelegate {
    
    @IBOutlet weak var detailHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    init() {
        super.init(nibName: "QuestionsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets characteristics for top bar text
        let textColor = UIColor.white
        let textFont = UIFont(name: "Avenir", size: 35.0)
        let titleTextAttributes: [String:NSObject] = [
            NSFontAttributeName: textFont!,
            NSForegroundColorAttributeName: textColor,
        ]
        self.navigationController!.navigationBar.titleTextAttributes = titleTextAttributes

        edgesForExtendedLayout = UIRectEdge()
        let sendButton = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(QuestionsViewController.didPressSend))
        navigationItem.rightBarButtonItem = sendButton
        navigationController?.navigationBar.tintColor = UIColor.white
        
        detailTextView.layer.cornerRadius = 5.0
        detailTextView.isEditable = false
        
        topicTextField.delegate = self
        emailTextField.delegate = self
        
        // Adds gesture recognizer that will open TextViewController.swift when the text view is tapped
        let textViewTapped = UITapGestureRecognizer(target: self, action: #selector(QuestionsViewController.textTapped))
        detailTextView.addGestureRecognizer(textViewTapped)
        
    }
    
    // Resizes the text view's height if the screen height is less than 480p
    override func viewDidLayoutSubviews() {
        var sysInfo = utsname()
        uname(&sysInfo)
        let machine = Mirror(reflecting: sysInfo.machine)
        let identifier = machine.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        let shouldModify = platformType(identifier as NSString)
        
        if shouldModify {
            self.detailHeightConstraint.constant = 50
        }
    }
    
    // Checks if the type of device being used is one with a screen height less than 480p
    func platformType(_ platform : NSString) -> Bool {
        if platform.hasPrefix("iPhone4") {
            return true
        } else if platform.hasPrefix("iPad") {
            return true
        } else if UIScreen.main.bounds.height <= 480.0 {
            return true
        }
        return false
    }
    
    // These two functions below prevent landscape mode
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait]
    }

    // Makes sure email entered in emailTextField follows standard email convention
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // Releases keyboard if return is pressed while typing in a text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Linked to the gesture recognizer for the text view; opens up TextViewController.swift
    func textTapped() {
        let vc = TextViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Calls the BmunCloudCode main.js file that formats the info in the text view and text fields into an email and uses Parse & Mailgun to send it to feeback@bmun.org
    func didPressSend() {
        /*if topicTextField.text != "" && emailTextField.text != "" && detailTextView.text != "" {
            
            if isValidEmail(emailTextField.text!) {
        
                let params = [
                    "topic": topicTextField.text!,
                    "email": emailTextField.text!,
                    "body": detailTextView.text
                ] as [String : Any]
        
                PFCloud.callFunction(inBackground: "sendEmail", withParameters: params) { (res: Any?, err: Error?) -> Void in
                    print("Res: \(res), err: \(err)")
                }
            
                let finishedSending = UIAlertController(title: "Email Sent", message: "Your email has successfully been sent to our staff.", preferredStyle: .alert)
                finishedSending.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(finishedSending, animated: true, completion: nil)
                emailTextField.text = ""
                topicTextField.text = ""
                detailTextView.text = ""
            } else {
                let alert = UIAlertController(title: "Invalid Email", message: "Please Re-enter", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }*/
        
    }
    
    //MARK: Delegate
    
    func textViewFill(_ text: String) {
        detailTextView.text = text
    }
    
    func sendOverText() -> String {
        return detailTextView.text
    }


}
