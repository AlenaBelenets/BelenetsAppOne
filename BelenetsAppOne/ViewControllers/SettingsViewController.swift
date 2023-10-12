//
//  SettingsViewController.swift
//  BelenetsAppOne
//
//  Created by Alena Belenets on 02.10.2023.
//

import UIKit

//    MARK: - SettingsViewController
class SettingsViewController: UIViewController {

    //    MARK: - Private Properties
    private let defaults = UserDefaults.standard
    private var index = 0
    private var selectedImage = Constants.airplaneThree
    private var userName = ""
    private var airplanes = [UIImage(named: Constants.airplaneThree), UIImage(named: Constants.airplaneTwo), UIImage(named: Constants.airplaneOne)]
    private var carName = [Constants.airplaneOne, Constants.airplaneTwo, Constants.airplaneThree]
    private var levelDuration: Double = Numbers.one.rawValue
    private var levelName = Constants.easy


    private lazy var nameTextField: UITextField = {
        let textField = UITextField()

        textField.placeholder = " Add your name"
        textField.layer.borderWidth = Numbers.two.rawValue
        textField.backgroundColor = .white
        textField.layer.cornerRadius = Numbers.twelve.rawValue
        textField.layer.borderColor = CGColor(red: Numbers.forty.rawValue, green: Numbers.thirty.rawValue, blue: Numbers.twentyFive.rawValue, alpha: Numbers.one.rawValue)
        textField.addTarget(self, action: #selector(addedPlayerName), for: .touchUpInside)


        return textField
    }()

    private lazy var easyDurationLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "Title 1", size: Numbers.twentyFive.rawValue)
        label.text = "EASY"
        label.backgroundColor = .white
        label.textAlignment = .center
        label.clipsToBounds = true

        return label
    }()

    private lazy var mediumDurationLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "Title 1", size: Numbers.twentyFive.rawValue)
        label.text = "MEDIUM"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.clipsToBounds = true

        return label
    }()
    private lazy var hardDurationLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "Title 1", size: Numbers.twentyFive.rawValue)
        label.text = "HARD"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.clipsToBounds = true

        return label
    }()

    private lazy var doneButton: UIButton = {
        let button = UIButton()

        button.setTitle("DONE", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Numbers.twenty.rawValue)
        button.addTarget(self, action: #selector(doneButtonWasPressed), for: .touchUpInside)

        return button
    }()

    private lazy var airplaneOne: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "airplane1"))

        return imageView

    }()

    private lazy var airplaneTwo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "airplane2"))
        return imageView

    }()

    private lazy var airplaneThree: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "airplane3"))
        return imageView

    }()

    //    MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow

        setupTextField()
        setupAirplanes()
        setupLabels()
        setupDoneButton()

        setupObstacleGesterRecognize()
        setupLabelGesterRecognize()

    }

    //    MARK: - Private functions

    private func setupTextField() {

        nameTextField.frame = CGRect(x: Numbers.threeHundred.rawValue, y: Numbers.twoHundred.rawValue, width: Numbers.oneHundredAndFifty.rawValue, height: Numbers.fifty.rawValue)
        nameTextField.center.x = CGFloat(self.view.bounds.midX)
        self.view.addSubview(nameTextField)

    }

    private func setupLabels() {

        easyDurationLabel.frame = CGRect(x: Numbers.twenty.rawValue, y:Numbers.sixHundred.rawValue, width: Numbers.oneHundred.rawValue, height: Numbers.fifty.rawValue)
        self.view.addSubview(easyDurationLabel)

        mediumDurationLabel.frame = CGRect(x: Numbers.oneHundredAndFifty.rawValue, y:Numbers.sixHundred.rawValue, width: Numbers.oneHundred.rawValue, height: Numbers.fifty.rawValue)
        self.view.addSubview(mediumDurationLabel)

        hardDurationLabel.frame = CGRect(x: Numbers.twoHundredAndSeventy.rawValue, y:Numbers.sixHundred.rawValue, width: Numbers.oneHundred.rawValue, height: Numbers.fifty.rawValue)
        self.view.addSubview(hardDurationLabel)

    }

    @objc private func addedPlayerName() {
        UserDefaults.standard.set(nameTextField.text, forKey: "userName")
    }

    private func setupDoneButton() {
        doneButton.frame = CGRect(x: Numbers.oneHundredAndFifty.rawValue, y:Numbers.sevenHundred.rawValue, width: Numbers.oneHundred.rawValue, height: Numbers.fifty.rawValue)
        self.view.addSubview(doneButton)
    }

     @objc private func doneButtonWasPressed() {

        defaults.setValue(selectedImage, forKey: Constants.keyAirplane)
        defaults.setValue(levelDuration, forKey: Constants.keyDuration)
        UserDefaults.standard.set(nameTextField.text, forKey: "userName")
        doneButton.backgroundColor = UIColor.green

    }

    private func setupAirplanes() {
        airplaneOne.frame = CGRect(x: Numbers.threeHundred.rawValue, y: Numbers.fourHundred.rawValue, width: Numbers.seventy.rawValue, height: Numbers.eighty.rawValue)

        self.view.addSubview(airplaneOne)

        airplaneTwo.frame = CGRect(x: Numbers.oneHundredAndFifty.rawValue, y: Numbers.threeHundredAndEight.rawValue, width: Numbers.oneHundredAndTwenty.rawValue, height: Numbers.oneHundredAndForty.rawValue)
        self.view.addSubview(airplaneTwo)

        airplaneThree.frame = CGRect(x: Numbers.fifty.rawValue, y: Numbers.fourHundred.rawValue, width: Numbers.seventy.rawValue, height: Numbers.ninety.rawValue)

        self.view.addSubview(airplaneThree)
    }

    private func setupObstacleGesterRecognize() {
        let airplaneTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(firstImageTapped(tapGestureRecognizer:)))
        let aiplaneTwoTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(secondImageTapped(tapGestureRecognizer:)))
        let airplaneThreeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(thirdImageTapped(tapGestureRecognizer:)))

        airplaneOne.isUserInteractionEnabled = true
        airplaneTwo.isUserInteractionEnabled = true
        airplaneThree.isUserInteractionEnabled = true

        airplaneOne.addGestureRecognizer(airplaneTapGestureRecognizer)
        airplaneTwo.addGestureRecognizer(aiplaneTwoTapGestureRecognizer)
        airplaneThree.addGestureRecognizer(airplaneThreeTapGestureRecognizer)
    }

    @objc private func firstImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        selectedImage = Constants.airplaneOne
        defaults.set(selectedImage, forKey: Constants.keyAirplane)

        airplaneOne.layer.cornerRadius = Numbers.twentyFive.rawValue
        airplaneOne.clipsToBounds = true
        airplaneOne.layer.borderColor = UIColor.darkGray.cgColor
        airplaneOne.layer.borderWidth = Numbers.onePointFive.rawValue

        resetImageViewSettings(imageView: airplaneTwo)
        resetImageViewSettings(imageView: airplaneThree)
    }

    @objc private func secondImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        selectedImage = Constants.airplaneTwo
        defaults.set(selectedImage, forKey: Constants.keyAirplane)

        airplaneTwo.layer.cornerRadius = Numbers.twentyFive.rawValue
        airplaneTwo.clipsToBounds = true
        airplaneTwo.layer.borderColor = UIColor.darkGray.cgColor
        airplaneTwo.layer.borderWidth = Numbers.onePointFive.rawValue

        resetImageViewSettings(imageView: airplaneOne)
        resetImageViewSettings(imageView: airplaneThree)
    }

    @objc func thirdImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        selectedImage = Constants.airplaneThree

        defaults.set(selectedImage, forKey: Constants.keyAirplane)

        airplaneThree.layer.cornerRadius = Numbers.twentyFive.rawValue
        airplaneThree.clipsToBounds = true
        airplaneThree.layer.borderColor = UIColor.darkGray.cgColor
        airplaneThree.layer.borderWidth = Numbers.onePointFive.rawValue

        resetImageViewSettings(imageView: airplaneOne)
        resetImageViewSettings(imageView: airplaneTwo)
    }

    private func resetImageViewSettings(imageView: UIImageView) {
        imageView.layer.borderWidth = 0
        doneButton.backgroundColor = UIColor(named: "green")
    }

    private func setupLabelGesterRecognize() {
        let easyLabelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(easyLabelTapped(tapGestureRecognizer:)))
        let mediumLabelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mediumLabelTapped(tapGestureRecognizer:)))
        let hardLabelTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hardLabelTapped(tapGestureRecognizer:)))

        easyDurationLabel.isUserInteractionEnabled = true
        mediumDurationLabel.isUserInteractionEnabled = true
        hardDurationLabel.isUserInteractionEnabled = true

        easyDurationLabel.addGestureRecognizer(easyLabelTapGestureRecognizer)
        mediumDurationLabel.addGestureRecognizer(mediumLabelGestureRecognizer)
        hardDurationLabel.addGestureRecognizer(hardLabelTapGestureRecognizer)
    }

    @objc private func easyLabelTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        levelDuration = Numbers.seven.rawValue
        levelName = Constants.easy

        easyDurationLabel.backgroundColor = .darkGray
        easyDurationLabel.textColor = .white

        resetLabelBackground(label: mediumDurationLabel)
        resetLabelBackground(label: hardDurationLabel)
    }

    @objc private func mediumLabelTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        levelDuration = Numbers.five.rawValue
        levelName = Constants.medium

        mediumDurationLabel.backgroundColor = .darkGray
        mediumDurationLabel.textColor = .white

        resetLabelBackground(label: easyDurationLabel)
        resetLabelBackground(label: hardDurationLabel)
    }

    @objc private func hardLabelTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        levelDuration = Numbers.two.rawValue
        levelName = Constants.hard

        defaults.set(levelDuration, forKey: Constants.keyDuration)

        hardDurationLabel.backgroundColor = .darkGray
        hardDurationLabel.textColor = .white

        resetLabelBackground(label: easyDurationLabel)
        resetLabelBackground(label: mediumDurationLabel)
    }

    private func resetLabelBackground(label: UILabel) {
        label.backgroundColor = .white
        label.textColor = .black
        doneButton.backgroundColor = UIColor.green
    }
}

// MARK: - Extension UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let name = textField.text {
            if name.isEmpty {
                self.userName = Constants.defaultUserName
            } else {
                userName = name
            }
            defaults.setValue(userName, forKey: Constants.keyName)
            textField.resignFirstResponder()
        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


