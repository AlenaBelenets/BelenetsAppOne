//
//  RecordsViewController.swift
//  BelenetsAppOne
//
//  Created by Alena Belenets on 02.10.2023.
//

import UIKit

//    MARK: - RecordsViewController
class RecordsViewController: UIViewController {

    //    MARK: - Properties
    private var gameRecords = [Records]()

    private var recordTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        return tableView
    }()

    private lazy var recordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle, compatibleWith: .none)
        label.text = "\(Constants.recordsButtonTitle)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true

        return label
    }()

    //    MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        recordTableView.delegate = self
        recordTableView.dataSource = self

        view.backgroundColor = .cyan
        setupLabel()
        loadRecords()
        setupTableView()
    }

    //    MARK: - Private functions
    private func setupTableView() {
        self.view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        self.view.addSubview(recordTableView)

        recordTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            recordTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Numbers.threeHundred.rawValue),
            recordTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            recordTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            recordTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

    private func setupLabel() {
        self.view.addSubview(self.recordLabel)

        self.recordLabel.topAnchor.constraint(equalTo: self.view.topAnchor,
                                              constant:  Numbers.fifty.rawValue).isActive = true
        self.recordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                  constant:  Numbers.twenty.rawValue).isActive = true
        self.recordLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                   constant:  -Numbers.twenty.rawValue).isActive = true
        self.recordLabel.heightAnchor.constraint(equalToConstant: Numbers.fifty.rawValue).isActive = true
    }

    private func loadRecords() {

        guard let folderPath = FileManager.getPathOfDirectory(named: "Records") else {
            return
        }

        if let results = try? FileManager.default.contentsOfDirectory(at: folderPath, includingPropertiesForKeys: [.nameKey], options: .includesDirectoriesPostOrder) {
            for result in results {
                guard let data = try? Data(contentsOf: result) else {
                    return
                }

                let decoder = JSONDecoder()
                if let playerResult = try? decoder.decode(Records.self, from: data ) {
                    gameRecords.append(playerResult)
                }
            }
        }

    }


}

    //    MARK: - Extension: UITableViewDataSource, UITableViewDelegate
extension RecordsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameRecords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let records = gameRecords[indexPath.row]
        content.text = "Player:       \(records.userName)      -        \(records.score) points"
        cell.contentConfiguration = content

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Numbers.fifty.rawValue
    }
}



