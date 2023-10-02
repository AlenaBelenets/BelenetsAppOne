//
//  ViewController.swift
//  BelenetsAppOne
//
//  Created by Alena Belenets on 02.10.2023.
//

import UIKit

enum Numbers: Double {
    case twelve = 12.0
    case twenty = 20.0
    case twentyFour = 24.0
    case fifty = 50.0
    case threeHundred = 300.0
    case fourHundred = 400.0
}


class WelcomeViewController: UIViewController {

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.layer.cornerRadius = Numbers.twelve.rawValue
        button.setTitle("START GAME", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Numbers.twentyFour.rawValue)
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.layer.cornerRadius = Numbers.twelve.rawValue
        button.setTitle("SETTINGS", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Numbers.twentyFour.rawValue)
        button.addTarget(self, action: #selector(settingsButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var recordsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = Numbers.twelve.rawValue
        button.setTitle("RECORDS", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Numbers.twentyFour.rawValue)
        button.addTarget(self, action: #selector(recordsButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        setupStartButton()
        setupSettingsButton()
        setupRecordsButton()

    }


    private func setupStartButton() {
       self.view.addSubview(self.startButton)

       self.startButton.topAnchor.constraint(equalTo: self.view.topAnchor,
                                             constant:  Numbers.threeHundred.rawValue).isActive = true
       self.startButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                 constant:  Numbers.twenty.rawValue).isActive = true
       self.startButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                constant:  -Numbers.twenty.rawValue).isActive = true
       self.startButton.heightAnchor.constraint(equalToConstant: Numbers.fifty.rawValue).isActive = true
    }

    private func setupSettingsButton() {
       self.view.addSubview(self.settingsButton)

       self.settingsButton.topAnchor.constraint(equalTo: self.view.topAnchor,
                                             constant:  Numbers.fourHundred.rawValue).isActive = true
       self.settingsButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                 constant:  Numbers.twenty.rawValue).isActive = true
       self.settingsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                constant:  -Numbers.twenty.rawValue).isActive = true
       self.settingsButton.heightAnchor.constraint(equalToConstant: Numbers.fifty.rawValue).isActive = true
    }

    private func setupRecordsButton() {
       self.view.addSubview(self.recordsButton)

       self.recordsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                             constant:  -Numbers.threeHundred.rawValue).isActive = true
       self.recordsButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                 constant:  Numbers.twenty.rawValue).isActive = true
       self.recordsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                constant:  -Numbers.twenty.rawValue).isActive = true
       self.recordsButton.heightAnchor.constraint(equalToConstant: Numbers.fifty.rawValue).isActive = true
    }

    @objc func startButtonAction() {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .fullScreen
        self.present(gameVC, animated: true)

    }

    @objc func settingsButtonAction() {
        let settingsVC = SettingsViewController()
//        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true)

    }

    @objc func recordsButtonAction() {
        let recordsVC = RecordsViewController()
//        recordsVC.modalPresentationStyle = .fullScreen
        self.present(recordsVC, animated: true)

    }
}

