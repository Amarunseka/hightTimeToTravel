//
//  DetailsTripViewController.swift
//  hightTimeToTravel
//
//  Created by Миша on 31.05.2022.
//

import Foundation
import UIKit

class DetailsTripViewController: UIViewController {
    
    // MARK: - Properties
    var outputIsLike: ((Bool)->())?
    private var tripModel: TripModel
    private var isLike: Bool
    private let headersNamesArray = ["Город отправления",
                             "Куда путешествуем",
                             "Начало путешествия",
                             "Конец путешествия",
                             "Стоимость",
    ]
    private let likeImageView = UIImageView.likeImage()

    private let iLIkeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Мне нравится!"
        label.font = UIFont.proximaNovaBlack22()
        label.textColor = #colorLiteral(red: 0.4235294118, green: 0.06666666667, blue: 0.7882352941, alpha: 1)
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life cycle
    init(cellsNamesArray: TripModel, isLike: Bool) {
        self.tripModel = cellsNamesArray
        self.isLike = isLike
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupLikeImageView()
        setupLikeGesture()
    }
    
    override func viewDidLayoutSubviews() {
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Methods
    private func setupView() {
        view.backgroundColor = .white
        view.addSubviews([tableView,
                          iLIkeLabel,
                          likeImageView])
    }

    private func setupTableView(){
        tableView.bounces = false
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = 20
    }
    
    private func setupLikeImageView(){
        if isLike {
            likeImageView.image = .likeImage()
        } else {
            likeImageView.image = .unLikeImage()
        }
    }
    
    private func setupLikeGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapLikeGesture))
        likeImageView.isUserInteractionEnabled = true
        likeImageView.addGestureRecognizer(gesture)
    }
    
    @objc
    private func tapLikeGesture(){
        guard let outputIsLike = outputIsLike else {return}
        if !isLike {
            likeImageView.image = .likeImage()
        } else {
            likeImageView.image = .unLikeImage()
        }
        isLike.toggle()
        outputIsLike(isLike)
    }
}

// MARK: - UITableViewDataSource
extension DetailsTripViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        headersNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.backgroundColor = #colorLiteral(red: 0.4235294118, green: 0.06666666667, blue: 0.7882352941, alpha: 1)
        cell.selectionStyle = .none
        
        var configuration = cell.defaultContentConfiguration()
        configuration.textProperties.color = .white
        configuration.textProperties.font = UIFont.proximaNovaRegular26() ?? UIFont.systemFont(ofSize: 22)

        
        switch indexPath.section {
        case 0:
            configuration.text = tripModel.startCity
        case 1:
            configuration.text = tripModel.endCity
        case 2:
            configuration.text = DateTransformer.transformDate(tripModel.startDate)
        case 3:
            configuration.text = DateTransformer.transformDate(tripModel.endDate)
        case 4:
            configuration.text = "\(tripModel.price) рублей"
        default:
            configuration.text = ""
        }
        
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        headersNamesArray[section]
    }
}

// MARK: - Constraints
extension DetailsTripViewController {
    private func setConstraints() {
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            iLIkeLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            iLIkeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),

            likeImageView.topAnchor.constraint(equalTo: iLIkeLabel.bottomAnchor, constant: 5),
            likeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            likeImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 6),
            likeImageView.widthAnchor.constraint(equalTo: likeImageView.heightAnchor, constant: 0),
            likeImageView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

