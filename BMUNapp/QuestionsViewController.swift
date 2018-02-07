//
//  QuestionsViewController.swift
//  BMUNapp
//
//  Created by Jake Moskowitz on 12/6/15.
//  Copyright © 2015 Jake Moskowitz. All rights reserved.
//

import UIKit
import MessageUI

protocol QuestionsViewControllerDelegate: MFMailComposeViewControllerDelegate {
    func textViewFill(_ text: String)
    func sendOverText() -> String
}

class QuestionsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, QuestionsViewControllerDelegate {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    init() {
        super.init(nibName: "QuestionsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = UIRectEdge()
        let sendButton = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(QuestionsViewController.didPressSend))
        navigationItem.rightBarButtonItem = sendButton
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        self.detailTextView.layer.cornerRadius = 5.0
        self.detailTextView.isEditable = false
        self.topicTextField.delegate = self
        self.descriptionLabel.sizeToFit()
        
        // Adds gesture recognizer that will open TextViewController.swift when the text view is tapped
        let textViewTapped = UITapGestureRecognizer(target: self, action: #selector(QuestionsViewController.textTapped))
        self.detailTextView.addGestureRecognizer(textViewTapped)
        
        self.backgroundImageView.image = UIImage(named: "questionBackground")
        self.backgroundImageView.contentMode = .scaleAspectFill
        self.backgroundImageView.alpha = 0.7
        
    }
    
    // These two functions below prevent landscape mode
    override var shouldAutorotate : Bool {
        return false
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.detailTextView.resignFirstResponder()
    }
    
    // Releases keyboard if return is pressed while typing in a text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Linked to the gesture recognizer for the text view; opens up TextViewController.swift
    @objc func textTapped() {
        let vc = TextViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Calls the BmunCloudCode main.js file that formats the info in the text view and text fields into an email and uses Parse & Mailgun to send it to feeback@bmun.org
    @objc func didPressSend() {
        let incomplete = UIAlertController(title: "Missing Information", message: "Please fill out all fields.", preferredStyle: .alert)
        incomplete.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        let error = UIAlertController(title: "Error", message: "Your email can't be sent. Please try again.", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        if topicTextField.text != "" && detailTextView.text != "" {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.present(error, animated: true, completion: nil)
            }
            topicTextField.text = ""
            detailTextView.text = ""
        } else {
            self.present(incomplete, animated: true, completion: nil)
        }
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["info@bmun.org"])
        mailComposerVC.setSubject(topicTextField.text!)
        mailComposerVC.setMessageBody(detailTextView.text, isHTML: false)
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        print(result)
        if result == MFMailComposeResult.sent {
            let finishedSending = UIAlertController(title: "Email Sent", message: "Your email has successfully been sent to our staff.", preferredStyle: .alert)
            finishedSending.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(finishedSending, animated: true, completion: nil)
        } else if result == MFMailComposeResult.failed {
            let failedSending = UIAlertController(title: "Error", message: "Your email failed to send. Please try again.", preferredStyle: .alert)
            failedSending.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(failedSending, animated: true, completion: nil)
        }
        topicTextField.text = ""
        detailTextView.text = ""
    }
    
    //MARK: Delegate
    
    func textViewFill(_ text: String) {
        self.detailTextView.text = text
    }
    
    func sendOverText() -> String {
        return self.detailTextView.text
    }


}
