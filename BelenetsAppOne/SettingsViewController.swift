//
//  SettingsViewController.swift
//  BelenetsAppOne
//
//  Created by Alena Belenets on 02.10.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    private let defaults = UserDefaults.standard
    private var index = 0
    private var selectedImage = Constants.airplaneThree
    private var userName = ""
    private var airplanes = [UIImage(named: Constants.airplaneThree), UIImage(named: Constants.airplaneTwo), UIImage(named: Constants.airplaneOne)]
    private var carName = [Constants.airplaneOne, Constants.airplaneTwo, Constants.airplaneThree]
    private var level: Double = 1
    private var levelName = Constants.easy


    lazy var nameTextField: UITextField = {
        let textField = UITextField()

        textField.placeholder = " Add your name"
        textField.layer.borderWidth = 2
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        textField.layer.borderColor = CGColor(red: 40, green: 32, blue: 23, alpha: 1)
        textField.addTarget(self, action: #selector(addedPlayerName), for: .touchUpInside)


        return textField
    }()

    lazy var easyDurationLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "Title 1", size: 25)
        label.text = "EASY"
        label.backgroundColor = .white
        label.textAlignment = .center
        label.clipsToBounds = true

        return label
    }()

    lazy var mediumDurationLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "Title 1", size: 25)
        label.text = "MEDIUM"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.clipsToBounds = true

        return label
    }()
    lazy var hardDurationLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "Title 1", size: 25)
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

    lazy var airplaneOne: UIImageView = {
           let imageView = UIImageView(image: UIImage(named: "airplane1"))

           return imageView

       }()

    lazy var airplaneTwo: UIImageView = {
           let imageView = UIImageView(image: UIImage(named: "airplane2"))
           return imageView

       }()

    lazy var airplaneThree: UIImageView = {
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


    @objc func addedPlayerName() {
        UserDefaults.standard.set(nameTextField.text, forKey: "userName")
    }

    func setupTextField() {

        nameTextField.frame = CGRect(x: 300, y:200, width: 150, height: 50)
        nameTextField.center.x = CGFloat(self.view.bounds.midX)
        self.view.addSubview(nameTextField)

    }

    func setupLabels() {

        easyDurationLabel.frame = CGRect(x: 20, y:600, width: 100, height: 50)
        self.view.addSubview(easyDurationLabel)

        mediumDurationLabel.frame = CGRect(x: 150, y:600, width: 100, height: 50)
        self.view.addSubview(mediumDurationLabel)

        hardDurationLabel.frame = CGRect(x: 270, y:600, width: 100, height: 50)
        self.view.addSubview(hardDurationLabel)

    }

    func setupDoneButton() {
        doneButton.frame = CGRect(x: 150, y:700, width: 100, height: 50)
        self.view.addSubview(doneButton)
    }

    @objc func doneButtonWasPressed() {

        defaults.setValue(carName[index], forKey: Constants.keyAirplane)
        defaults.setValue(level, forKey: "gameLavel")
        doneButton.backgroundColor = UIColor.green
    }

    private func setupAirplanes() {
        airplaneOne.frame = CGRect(x: 300, y: 400, width: 70, height: 80)

        self.view.addSubview(airplaneOne)

        airplaneTwo.frame = CGRect(x: 150, y: 380, width: 120, height: 140)
        self.view.addSubview(airplaneTwo)

        airplaneThree.frame = CGRect(x: 50, y: 400, width: 70, height: 90)



        self.view.addSubview(airplaneThree)
    }

//    private func setupSwipeGestureRecognizer() {
//        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_ :)))
//        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_ :)))
//        swipeGestureLeft.direction = .left
//        swipeGestureRight.direction = .right
//        view.addGestureRecognizer(swipeGestureLeft)
//        view.addGestureRecognizer(swipeGestureRight)
//    }
//
//    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
//        if sender.state == .ended {
//            switch sender.direction {
//            case .left:
//                index += 1
//                checkIndex()
//                carImageView.transform = CGAffineTransform(translationX: 300, y: 0)
//                carImageView.transform = carImageView.transform.rotated(by: .pi)
//                applyAnimation()
//                soundManager.playSound(fileName: Constants.swipeSound)
//            case .right:
//                index -= 1
//                checkIndex()
//                carImageView.transform = CGAffineTransform(translationX: -300, y: 0)
//                carImageView.transform = carImageView.transform.rotated(by: .pi)
//                applyAnimation()
//                soundManager.playSound(fileName: Constants.swipeSound)
//            default:
//                break
//            }
//        }
//    }

//    private func checkIndex() {
//        if index >= cars.count {
//            index = 0
//        } else if index <= -1 {
//            index = cars.count - 1
//        }
//        carImageView.image = cars[index]
//    }

//    private func applyAnimation() {
//        UIView.animate(withDuration: 1.0) {
//            self.carImageView.transform = CGAffineTransform(rotationAngle: .pi * 2.0)
//        } completion: { _ in
//            UIView.animate(withDuration: 0.3) {
//                self.carImageView.transform = CGAffineTransform.identity.scaledBy(x: 1.3, y: 1.3)
//            }
//        }
//    }

    // MARK: - obstacle selection methods
    // MARK: -
    private func setupObstacleGesterRecognize() {
        let airplaneTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fitrstimageTapped(tapGestureRecognizer:)))
        let aiplaneTwoTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(secondimageTapped(tapGestureRecognizer:)))
        let airplaneThreeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(thirdimageTapped(tapGestureRecognizer:)))

        airplaneOne.isUserInteractionEnabled = true
        airplaneTwo.isUserInteractionEnabled = true
        airplaneThree.isUserInteractionEnabled = true

        airplaneOne.addGestureRecognizer(airplaneTapGestureRecognizer)
        airplaneTwo.addGestureRecognizer(aiplaneTwoTapGestureRecognizer)
        airplaneThree.addGestureRecognizer(airplaneThreeTapGestureRecognizer)
    }

    @objc func fitrstimageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        selectedImage = Constants.airplaneOne

        airplaneOne.layer.cornerRadius = 25
        airplaneOne.clipsToBounds = true
        airplaneOne.layer.borderColor = UIColor.darkGray.cgColor
        airplaneOne.layer.borderWidth = 1.5

        resetImageViewSettings(imageView: airplaneTwo)
        resetImageViewSettings(imageView: airplaneThree)
    }

    @objc func secondimageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        selectedImage = Constants.airplaneTwo

        airplaneTwo.layer.cornerRadius = 25
        airplaneTwo.clipsToBounds = true
        airplaneTwo.layer.borderColor = UIColor.darkGray.cgColor
        airplaneTwo.layer.borderWidth = 1.5

        resetImageViewSettings(imageView: airplaneOne)
        resetImageViewSettings(imageView: airplaneThree)
    }

    @objc func thirdimageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        selectedImage = Constants.airplaneThree

        airplaneThree.layer.cornerRadius = 25
        airplaneThree.clipsToBounds = true
        airplaneThree.layer.borderColor = UIColor.darkGray.cgColor
        airplaneThree.layer.borderWidth = 1.5

        resetImageViewSettings(imageView: airplaneOne)
        resetImageViewSettings(imageView: airplaneTwo)
    }

    private func resetImageViewSettings(imageView: UIImageView) {
        imageView.layer.borderWidth = 0
        doneButton.backgroundColor = UIColor(named: "green")
    }

    // MARK: - level selection methods
    // MARK: -
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
        level = 1
        levelName = Constants.easy

        defaults.set(level, forKey: Constants.keyDuration)

        easyDurationLabel.backgroundColor = .darkGray
        easyDurationLabel.textColor = .white

        resetLabelBackground(label: mediumDurationLabel)
        resetLabelBackground(label: hardDurationLabel)
    }

    @objc private func mediumLabelTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        level = 5
        levelName = Constants.medium

        defaults.set(level, forKey: Constants.keyDuration)

        mediumDurationLabel.backgroundColor = .darkGray
        mediumDurationLabel.textColor = .white

        resetLabelBackground(label: easyDurationLabel)
        resetLabelBackground(label: hardDurationLabel)
    }

    @objc private func hardLabelTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        level = 10
        levelName = Constants.hard

        defaults.set(level, forKey: Constants.keyDuration)
        
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

// MARK: - UITextFieldDelegate methods
// MARK: -
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


