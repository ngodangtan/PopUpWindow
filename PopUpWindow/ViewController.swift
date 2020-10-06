//
//  ViewController.swift
//  PopUpWindow
//
//  Created by Ngo Dang tan on 10/5/20.
//

import UIKit

class ViewController: UIViewController {
    
    var success = true
    
    lazy var popUpWindow: PopUpWindow = {
       let view = PopUpWindow()
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
        
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    
    // MARK: - Properties
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.setTitle("Show Pop Up Window", for: .normal)
        button.setTitleColor(UIColor.mainBlue(), for: .normal)
        button.addTarget(self, action: #selector(handleShowPopUp), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.mainBlue()
        view.addSubview(button)
        button.centerX(inView: view)
        button.centerY(inView: view)
        button.setDimensions(height: 50, width: view.frame.width - 32)
        
        view.addSubview(visualEffectView)
        visualEffectView.anchor(top: view.topAnchor,left: view.leftAnchor,bottom:view.bottomAnchor,right: view.rightAnchor)
        visualEffectView.alpha = 0
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    // MARK: - Selectors
    @objc func handleShowPopUp(){
        view.addSubview(popUpWindow)
        popUpWindow.centerX(inView: view)
        popUpWindow.centerY(inView: view,constant: -40)
        popUpWindow.setDimensions(height: view.frame.width - 64, width: view.frame.width - 64)
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        
        popUpWindow.showSuccessMessage = success
        success = !success
  
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
        }
    }
    
    
}

extension ViewController: PopUpDelegate{
    func handleDismissal() {
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } completion: { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove popup window")
        }

    }
    
    
}
