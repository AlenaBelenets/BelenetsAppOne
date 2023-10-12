//
//  GameViewController.swift
//  BelenetsAppOne
//
//  Created by Alena Belenets on 02.10.2023.
//

import UIKit

//    MARK: - GameViewController
class GameViewController: UIViewController {

    // MARK: - Private properties
    private let defaults = UserDefaults()
    private var duration: Int?
    private var airplane: String?
    private var myView: UIView!
    private var counter = 0
    private var isPlaying = true
    private var collisionTimer = Timer()

    private var userName: String?

    private lazy var startCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Title 1", size: Numbers.twentyFive.rawValue)
        label.text = "Score: \(counter)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true

        return label
    }()


    private lazy var enemy1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "enemy"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill

        return imageView

    }()


    private lazy var enemy2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "enemy"))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView

    }()

    private var enemy3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "enemy"))
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView

    }()

    private var player = UIImageView()
    private lazy var dateFormatter = DateFormatter()


    private lazy var leftButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = .white
        button.setTitle("<-", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Numbers.fifty.rawValue)
        button.addTarget(self, action: #selector(moveAirplaneWithPressLeftButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.setTitle("->", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Numbers.fifty.rawValue)
        button.addTarget(self, action: #selector(moveAirplaneWithPressRightButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var bulletView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bullet"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var rightView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sky"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var hiddenRightView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sky"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var leftView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sky2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var hiddenLeftView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sky2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getData()

        createAirplane()
        setupLeftButton()
        setupRightButton()

        setupRightImage()
        setupLeftImage()
        setupEnemies()
        animateEnemies(UIImageView(image: UIImage(named: "enemy")))
        setupLabel()
        animateLeftImage(UIImageView(image: UIImage(named: "sky2")))
        animateRightImage(UIImageView(image: UIImage(named: "sky")))

    }
    // MARK: - ViewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        saveRecords()
    }
    // MARK: - getData
    func getData() {
        duration = defaults.integer(forKey: Constants.keyDuration)
        airplane = defaults.string(forKey: Constants.keyAirplane)
        userName = defaults.string(forKey: Constants.keyName)
    }

    // MARK: - Setup mountains
    private func animateLeftImage(_ image: UIImageView) {
        UIView.animate(withDuration: TimeInterval(duration ?? Int(Numbers.one.rawValue)), delay: 0, options: [.repeat, .curveLinear], animations: {
            self.leftView.transform = CGAffineTransform(translationX: 0, y: Numbers.eightHundred.rawValue)
            self.hiddenLeftView.transform = CGAffineTransform(translationX: 0, y: Numbers.sevenHundred.rawValue)
        }) { [self] (success: Bool) in
            self.leftView.transform = CGAffineTransform.identity
            self.hiddenLeftView.transform = CGAffineTransform.identity
            animateLeftImage(self.leftView)
        }
    }

    private func animateRightImage(_ image: UIImageView) {
        UIView.animate(withDuration: TimeInterval(duration ?? Int(Numbers.one.rawValue)), delay: 0, options: [.repeat, .curveLinear], animations: {
            self.rightView.transform = CGAffineTransform(translationX: 0, y: Numbers.sevenHundred.rawValue)
            self.hiddenRightView.transform = CGAffineTransform(translationX: 0, y: Numbers.sixHundred.rawValue)
        }) { [self] (success: Bool) in
            self.rightView.transform = CGAffineTransform.identity
            self.hiddenRightView.transform = CGAffineTransform.identity
            animateRightImage(self.rightView)
        }
    }
    // MARK: - animate enemies
    private func animateEnemies(_ image: UIImageView) {
        UIView.animate(withDuration: TimeInterval(duration ?? Int(Numbers.one.rawValue)), delay: 0, options: [.repeat, .curveLinear], animations: { [unowned self] in
            self.enemy1.transform = CGAffineTransform(translationX: 0, y: Numbers.sevenHundred.rawValue)
            self.enemy2.transform = CGAffineTransform(translationX: 0, y: Numbers.sevenHundred.rawValue)
            self.enemy3.transform = CGAffineTransform(translationX: 0, y: Numbers.sevenHundred.rawValue)
        }) { [unowned self] (success: Bool) in
            self.enemy1.transform = CGAffineTransform.identity
            self.enemy2.transform = CGAffineTransform.identity
            self.enemy3.transform = CGAffineTransform.identity


            animateEnemies(self.enemy1)
        }
    }
    // MARK: - Setup mountains
    private func setupRightImage() {
        self.view.addSubview(self.rightView)
        self.view.addSubview(self.hiddenRightView)

        self.rightView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.rightView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                constant:  Numbers.threeHundred.rawValue).isActive = true
        self.rightView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.rightView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.hiddenRightView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                      constant:  Numbers.threeHundred.rawValue).isActive = true
        self.hiddenRightView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.hiddenRightView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Numbers.sevenHundredAndFifty.rawValue).isActive = true

    }

    private func setupLeftImage() {
        self.view.addSubview(self.leftView)
        self.view.addSubview(self.hiddenLeftView)

        self.leftView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.leftView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.leftView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Numbers.threeHundred.rawValue).isActive = true
        self.leftView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        self.hiddenLeftView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.hiddenLeftView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Numbers.threeHundred.rawValue).isActive = true
        self.hiddenLeftView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Numbers.sevenHundredAndFifty.rawValue).isActive = true


    }

    // MARK: - Setup enemies
    private func setupEnemies() {

        view.addSubview(enemy1)
        view.addSubview(enemy2)
        view.addSubview(enemy3)

        self.enemy1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Numbers.fifty.rawValue).isActive = true
        self.enemy1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Numbers.fifty.rawValue).isActive = true

        self.enemy2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Numbers.ninety.rawValue).isActive = true
        self.enemy2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Numbers.oneHundred.rawValue).isActive = true

        self.enemy3.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Numbers.oneHundredAndFifty.rawValue).isActive = true
        self.enemy3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Numbers.oneHundredAndTwenty.rawValue).isActive = true


    }
    // MARK: - Setup label
    private func setupLabel() {
        view.addSubview(startCountLabel)

        self.startCountLabel.leadingAnchor.constraint(equalTo:self.startCountLabel.leadingAnchor, constant: -Numbers.ten.rawValue).isActive = true
        self.startCountLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Numbers.fifty.rawValue).isActive = true

    }

    // MARK: - Create airplane
    private func createAirplane() {
        player = UIImageView(image: UIImage(named: airplane ?? Constants.airplaneTwo))
        player.frame = CGRect(x: 0, y: 0, width: Numbers.seventy.rawValue, height: Numbers.oneHundred.rawValue)
        player.frame.origin.y = view.bounds.height - player.frame.size.height - Numbers.oneHundred.rawValue
        player.center.x = CGFloat(self.view.bounds.midX)
        player.layer.masksToBounds = true
        view.addSubview(player)

    }
    // MARK: - Setup buttons
    private func setupLeftButton() {
        self.view.addSubview(self.leftButton)

        self.leftButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                 constant:  Numbers.eighty.rawValue).isActive = true
        self.leftButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Numbers.forty.rawValue).isActive = true
    }

    private func setupRightButton() {
        self.view.addSubview(self.rightButton)
        self.rightButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                   constant:  -Numbers.eighty.rawValue).isActive = true
        self.rightButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Numbers.forty.rawValue).isActive = true
    }

    //MARK: - moveAirplane
    @objc private func moveAirplaneWithPressLeftButton() {
        var playerFrame = player.frame
        if playerFrame.origin.x < rightView.frame.minX - Numbers.fifty.rawValue {
            playerFrame.origin.x -= Numbers.ten.rawValue
        }

        player.frame = playerFrame

        collisionHandler()

    }

    @objc private func moveAirplaneWithPressRightButton() {
        var playerFrame = player.frame
        if playerFrame.origin.x > leftView.frame.minX - Numbers.fifty.rawValue {
            playerFrame.origin.x += Numbers.ten.rawValue
        }

        player.frame = playerFrame

        counter += 1
        startCountLabel.text = "Score \(counter)"

        collisionHandler()


    }
    //    MARK: - collisionHandler
    private func collisionHandler() {

        collisionTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { _ in

            if self.player.frame.intersects(self.enemy1.frame) || self.player.frame.intersects(self.enemy2.frame) || self.player.frame.intersects(self.enemy3.frame) {
                self.isPlaying = false
                self.gameOver()
                self.collisionTimer.invalidate()
                self.showGameOverAlert()

            }
        })
    }


    //    MARK: - game over alert
    private func showGameOverAlert() {
        let alert = UIAlertController(title: "Game over", message: ":(", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try again", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }



    // MARK: - save records
    private func saveRecords() {

        var folderPath = FileManager.getDocumentsDirectory()
        folderPath.appendPathComponent("Records")

        try? FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: false, attributes: nil)

        let fileName = getCurrentDate("yyyy MMM dd HH:mm:ss")

        if counter > 0 {
            let results = Records(score: counter, userName: userName ?? Constants.defaultUserName )
            let data = try? JSONEncoder().encode(results)
            let dataPath = folderPath.appendingPathComponent("\(fileName).json")
            FileManager.default.createFile(atPath: dataPath.path, contents: data, attributes: nil)

            print(results.userName)
        }

    }

    private func getCurrentDate(_ dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        let dataString = dateFormatter.string(from: Date())
        return dataString
    }

    //    MARK: - game over
    private func gameOver() {

        self.enemy1.removeFromSuperview()
        self.enemy2.removeFromSuperview()
        self.enemy3.removeFromSuperview()

        UIView.animate(withDuration: TimeInterval(duration ?? Int(Numbers.one.rawValue))) {
            self.player.image = UIImage(named: "boom")
            self.player.frame = CGRect(x: 0, y: 0, width: Numbers.twenty.rawValue, height: Numbers.oneHundredAndEight.rawValue)
            self.player.frame.origin.y = self.view.bounds.height - self.player.frame.size.height - Numbers.fifty.rawValue
            self.player.center.x = CGFloat(self.view.bounds.midX)
            self.player.contentMode = .scaleAspectFit
        }
    }
}
