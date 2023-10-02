//
//  GameViewController.swift
//  BelenetsAppOne
//
//  Created by Alena Belenets on 02.10.2023.
//

import UIKit



class GameViewController: UIViewController {

    var hover:CABasicAnimation!

    var myView: UIView!
    private var counter = 0
    private var animationTimer: Timer?
    private var updateTimer: Timer?
    private var isPlaying = true
    private var collisionTimer = Timer()
    lazy var startCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Title 1", size: 25)
        label.text = "Score: \(counter)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true

        return label
    }()

    private var userName = UserDefaults.standard.value(forKey: "userName") as? String

     lazy var enemy1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "enemy"))
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView

    }()


    lazy var enemy2: UIImageView = {
           let imageView = UIImageView(image: UIImage(named: "enemy"))
           imageView.clipsToBounds = true
           imageView.translatesAutoresizingMaskIntoConstraints = false

           return imageView

       }()
    private var enemy3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "enemy"))
        imageView.clipsToBounds = true
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

    private lazy var telescopicSight: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.setTitle("*", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Numbers.fifty.rawValue)
        button.addTarget(self, action: #selector(telescopicSignPressedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()


    lazy var bulletView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bullet"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var rightView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sky"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var hiddenRightView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sky"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var leftView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sky2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var hiddenLeftView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sky2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.clipsToBounds = true
        return imageView
    }()
// MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        createAirplane()
        setupLeftButton()
        setupRightButton()
        setupTelescopicSight()

        setupRightImage()
        setupLeftImage()
        setupEnemies()
        animateEnemies(UIImageView(image: UIImage(named: "enemy")))
        setupLabel()
//
        animateLeftImage(UIImageView(image: UIImage(named: "sky2")))
        animateRightImage(UIImageView(image: UIImage(named: "sky")))

    }

// MARK: Setup mountains
    func animateLeftImage(_ image: UIImageView) {
        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.leftView.transform = CGAffineTransform(translationX: 0, y: 800)
            self.hiddenLeftView.transform = CGAffineTransform(translationX: 0, y: 700)
        }) { [self] (success: Bool) in
            self.leftView.transform = CGAffineTransform.identity
            self.hiddenLeftView.transform = CGAffineTransform.identity
            animateLeftImage(self.leftView)
           }
    }

    func animateRightImage(_ image: UIImageView) {
        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.rightView.transform = CGAffineTransform(translationX: 0, y: 700)
            self.hiddenRightView.transform = CGAffineTransform(translationX: 0, y: 600)
        }) { [self] (success: Bool) in
            self.rightView.transform = CGAffineTransform.identity
            self.hiddenRightView.transform = CGAffineTransform.identity
            animateRightImage(self.rightView)
           }
    }

    func animateEnemies(_ image: UIImageView) {

        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.enemy1.transform = CGAffineTransform(translationX: 0, y: 700)
            self.enemy2.transform = CGAffineTransform(translationX: 0, y: 700)
            self.enemy3.transform = CGAffineTransform(translationX: 0, y: 700)
        }) { [self] (success: Bool) in
            self.enemy1.transform = CGAffineTransform.identity
            self.enemy2.transform = CGAffineTransform.identity
            self.enemy3.transform = CGAffineTransform.identity
            animateEnemies(self.enemy1)
           }

    }

    
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
        self.hiddenRightView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -750.0).isActive = true

     }

    private func setupLeftImage() {
        self.view.addSubview(self.leftView)
        self.view.addSubview(self.hiddenLeftView)

        self.leftView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.leftView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.leftView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Numbers.threeHundred.rawValue).isActive = true
        self.leftView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//
        self.hiddenLeftView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.hiddenLeftView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Numbers.threeHundred.rawValue).isActive = true
        self.hiddenLeftView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -750.0).isActive = true


     }

    private func setupEnemies() {

        view.addSubview(enemy1)
        view.addSubview(enemy2)
        view.addSubview(enemy3)

        self.enemy1.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        self.enemy1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true


        self.enemy2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90).isActive = true
        self.enemy2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Numbers.fifty.rawValue).isActive = true

        self.enemy3.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        self.enemy3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 120).isActive = true


    }

    private func setupLabel() {
        view.addSubview(startCountLabel)

        self.startCountLabel.leadingAnchor.constraint(equalTo:self.startCountLabel.leadingAnchor, constant: -10).isActive = true
         self.startCountLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true

    }

// MARK: - Create airplane
    private func createAirplane() {
        player = UIImageView(image: UIImage(named: "airplane1"))
        player.frame = CGRect(x: 0, y: 0, width: 90, height: 110)
        player.frame.origin.y = view.bounds.height - player.frame.size.height - 100
        player.center.x = CGFloat(self.view.bounds.midX)
        view.addSubview(player)

    }
// MARK: - Setup buttons
    private func setupLeftButton() {
       self.view.addSubview(self.leftButton)

       self.leftButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                constant:  80).isActive = true
        self.leftButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
    }

    private func setupRightButton() {
       self.view.addSubview(self.rightButton)
       self.rightButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                constant:  -80).isActive = true
        self.rightButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
    }

    private func setupTelescopicSight() {
        self.view.addSubview(self.telescopicSight)

        self.telescopicSight.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                 constant:  -180).isActive = true
         self.telescopicSight.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
    }

    @objc func moveAirplaneWithPressLeftButton() {
        var playerFrame = player.frame
        if playerFrame.origin.x < rightView.frame.minX - 50 {
            playerFrame.origin.x -= 10
        }
        player.frame = playerFrame
//        UIView.animate(withDuration: 5.0, delay: 0, options: [.allowAnimatedContent, .curveLinear], animations: {
//            self.player.transform = CGAffineTransform(translationX: -20, y: 0)
//        })
//
        print("func 1 is work")
    }

    @objc func moveAirplaneWithPressRightButton() {
        var playerFrame = player.frame
        if playerFrame.origin.x > leftView.frame.minX - 50 {
            playerFrame.origin.x += 10
        }
        player.frame = playerFrame

        print("func 2 is work")
    }

    @objc func telescopicSignPressedButton() {
        view.addSubview(bulletView)

        self.player.addSubview(bulletView)


        UIView.animate(withDuration: 5, delay: 0.0, options: [.repeat, .allowUserInteraction, .allowAnimatedContent], animations:  {
            self.bulletView.transform = CGAffineTransform(translationX: 0, y: -650)
        })

    }




    private func collisionHandler() {
        collisionTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false, block: { _ in
            if self.player.frame.intersects(self.enemy1.frame) || self.player.frame.intersects(self.enemy2.frame)
                || self.player.frame.intersects(self.enemy2.frame) || self.player.frame.intersects(self.enemy3.frame) || self.player.frame.intersects(self.enemy1.frame) {
                self.isPlaying = false
                self.gameOver()
                self.collisionTimer.invalidate()
//                self.showGameOverAlert()
            }
        })
    }



// MARK: - save records methods
// MARK: -
private func saveRecords() {
    var folderPath = FileManager.getDocumentsDirectory()
    folderPath.appendPathComponent("Records")

    try? FileManager.default.createDirectory(at: folderPath, withIntermediateDirectories: false, attributes: nil)

    let fileName = getCurrentDate("yyyy MMM dd HH:mm:ss")

    let car = UserDefaults.standard.value(forKey: "userCar") as? String
    let date = getCurrentDate("dd.MM.yyyy")

//    if let level = levelLabel.text {
//        let results = Records(level: level, points: points, gameDate: date, userName: userName ?? Constants.defaultUserName, userCar: car ?? Constants.yellowCar)
//        let data = try? JSONEncoder().encode(results)
//        let dataPath = folderPath.appendingPathComponent("\(fileName).json")
//        FileManager.default.createFile(atPath: dataPath.path, contents: data, attributes: nil)
////    }
}

private func getCurrentDate(_ dateFormat: String) -> String {
    dateFormatter.dateFormat = dateFormat
    let dataString = dateFormatter.string(from: Date())
    return dataString
}


    private func gameOver() {

        self.enemy1.removeFromSuperview()
        self.enemy2.removeFromSuperview()
        self.enemy3.removeFromSuperview()

      UIView.animate(withDuration: 1) {
            self.player.image = UIImage(named: "boom")
            self.player.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            self.player.frame.origin.y = self.view.bounds.height - self.player.frame.size.height - 60
            self.player.center.x = CGFloat(self.view.bounds.midX)
            self.player.contentMode = .scaleAspectFit
        }
    }
}
