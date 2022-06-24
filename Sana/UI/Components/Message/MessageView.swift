//
//  MessageView.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 27.04.2022.
//

import UIKit
import SwiftMessages
extension UIViewController {
    func showMessage(message: String) {
        var config = SwiftMessages.Config()
        config.dimMode = .none
        config.presentationStyle = .top
        config.presentationContext = .automatic
        
        SwiftMessages.show(config: config, view: MessageView(message: message))
    }
}

class MessageView: UIView {
    private let message: String
    
    private lazy var content = UIView()
    private lazy var label = UILabel()
    
    init(message: String) {
        self.message = message
        super.init(frame: .zero)
        
        content.backgroundColor = UIColor(cgColor: .accentBlue)
        content.layer.cornerRadius = 16
        
        label.text = message
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        
        content.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        addSubview(content)
        content.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(56)
        }
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
}
