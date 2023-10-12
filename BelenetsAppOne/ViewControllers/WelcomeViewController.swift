//
//  ViewController.swift
//  BelenetsAppOne
//
//  Created by Alena Belenets on 02.10.2023.
//

import UIKit

    // MARK: - WelcomeViewController
class WelcomeViewController: UIViewController {

    // MARK: - Properties
    let defaults = UserDefaults()

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
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        setupStartButton()
        setupSettingsButton()
        setupRecordsButton()

    }
    // MARK: - Private functions
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
    // MARK: - @objc func
    @objc func startButtonAction() {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .fullScreen
        self.present(gameVC, animated: true)

    }

    @objc func settingsButtonAction() {
        let settingsVC = SettingsViewController()
        self.present(settingsVC, animated: true)

    }

    @objc func recordsButtonAction() {
        let recordsVC = RecordsViewController()
        self.present(recordsVC, animated: true)

    }
}

