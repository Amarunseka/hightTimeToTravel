//
//  StartScreenViewController.swift
//  hightTimeToTravel
//
//  Created by Миша on 30.05.2022.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    // MARK: - Properties
    private let networkService = NetworkService()
    private var tripModel: [TripModel] = []
    private var isLikeArray: [Bool] = []
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        fetchDataAboutTrips()
    }
    
    override func viewDidLayoutSubviews() {
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Methods
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.4677155614, green: 0.2062640488, blue: 0.5002050996, alpha: 1)
        view.addSubviews([tableView])
    }
    
    private func setupTableView(){
        tableView.register(StartScreenTableViewCell.self,
                           forCellReuseIdentifier: String(describing: StartScreenTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    }
    
    private func tapOnLike(index: Int, isLike: Bool){
        isLikeArray[index] = isLike
        tableView.reloadData()
    }
    
    private func fetchDataAboutTrips() {
        setupActivityIndicator()
        
        guard let url = URL(string: "https://travel.wildberries.ru/statistics/v1/cheap") else { return }
        
        self.networkService.request(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                
                do {
                    let trips = try JSONDecoder().decode(NetModel.self, from: data)
                    self?.tripModel = trips.data
                    for _ in 0..<trips.data.count {
                        self?.isLikeArray.append(false)
                    }
                    self?.tableView.reloadData()
                } catch let error {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - UITableViewDelegate
extension StartScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsTripViewController(cellsNamesArray: tripModel[indexPath.row], isLike: isLikeArray[indexPath.row])
        
        vc.outputIsLike = { [weak self] result in
            self?.tapOnLike(index: indexPath.row, isLike: result)
            }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension StartScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tripModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StartScreenTableViewCell.self),
                                                       for: indexPath) as? StartScreenTableViewCell else {
            return UITableViewCell()}
        
        cell.configureCell(data: tripModel[indexPath.row], isLike: isLikeArray[indexPath.row])
        
        cell.outputIsLike = { [weak self] result in
            self?.tapOnLike(index: indexPath.row, isLike: result)
            }

        return cell
    }
}


// MARK: - Constraints
extension StartScreenViewController {
    private func setConstraints() {
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
