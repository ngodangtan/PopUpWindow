//
//  PopUpWindow.swift
//  PopUpWindow
//
//  Created by Ngo Dang tan on 10/5/20.
//

import UIKit
protocol PopUpDelegate {
    func handleDismissal()
}
class PopUpWindow: UIView {
    
    // MARK: - Properties
    var delegate: PopUpDelegate?
    
    var showSuccessMessage: Bool? {
        didSet{
            guard let success = showSuccessMessage else {return}
            if success {
                checkLabel.text = "✓"
                notificationLabel.text = "Success"
                checkLabel.textColor = UIColor(red: 147/255, green: 227/255, blue: 105/255, alpha: 1)
            }else{
                checkLabel.text = "X"
                notificationLabel.text = "Error"
                checkLabel.textColor = .red
            }
        }
    }
    
    let checkLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 96)

       
        return label
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 24)
     
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.mainBlue()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(checkLabel)
        checkLabel.centerY(inView: self, constant: -28)
        checkLabel.centerX(inView: self)
        
        addSubview(notificationLabel)
        notificationLabel.centerX(inView: self)
        notificationLabel.anchor(top: checkLabel.bottomAnchor)
        
        addSubview(button)
        button.anchor(left:leftAnchor,bottom: bottomAnchor,right: rightAnchor,paddingLeft: 12,paddingBottom: 12,paddingRight: 12)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Selectors
    @objc func handleDismissal(){
        delegate?.handleDismissal()
    }
    
}
