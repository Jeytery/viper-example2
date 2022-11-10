//
//  JokeDetailView.swift
//  viper
//
//  Created by Jeytery on 10.11.2022.
//

import Foundation
import UIKit

protocol JokeDetailViewInput: AnyObject {
    func setJoke(_ joke: Joke)
}

protocol JokeDetailViewUIEventOutput: AnyObject {
    func didTapOkButton(with newName: String)
}

class JokeDetailView: UIViewController, ViperView {
    typealias ViewUIEventOutput = JokeDetailViewUIEventOutput
    weak var uiEventOutput: ViewUIEventOutput?
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        addStackView()
        addStackViewContent()
        view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let stackView = UIStackView()
    private let nameLabel = UILabel()
    private let bodyLabel = UILabel()
    private let newNameTextField = UITextField()
}

private extension JokeDetailView {
    func addStackView() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.distribution = .fill
    }
    
    func addStackViewContent() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(newNameTextField)
        
        bodyLabel.numberOfLines = 0
        newNameTextField.placeholder = "Enter joke's new name"
        
        let button = UIButton(type: .roundedRect)
        button.setTitle("Ok", for: .normal)
        button.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }
    
    @objc func didTapOkButton() {
        uiEventOutput?.didTapOkButton(with: newNameTextField.text ?? "empty name")
    }
}

extension JokeDetailView: JokeDetailViewInput {
    func setJoke(_ joke: Joke) {
        nameLabel.text = joke.name
        bodyLabel.text = joke.body
    }
}
