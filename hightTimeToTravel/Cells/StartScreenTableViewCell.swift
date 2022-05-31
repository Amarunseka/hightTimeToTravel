//
//  StartScreenTableViewCell.swift
//  hightTimeToTravel
//
//  Created by Миша on 30.05.2022.
//

import UIKit

class StartScreenTableViewCell: UITableViewCell {

    // MARK: - Properties
    var outputIsLike: ((Bool)->())?
    private var isLike = false
    private let routTitleLabel = UILabel.specialTitleLabel(text: "МАРШРУТ")
    private let routCitiesLabel = UILabel.specialLabel(color: #colorLiteral(red: 0.2439181507, green: 0.1735580564, blue: 0.4246887565, alpha: 1))
    private let dateTitleLabel = UILabel.specialTitleLabel(text: "СРОК ПУТЕШЕСТВИЯ")
    private let dateTripLabel = UILabel.specialLabel(color: #colorLiteral(red: 0.2439181507, green: 0.1735580564, blue: 0.4246887565, alpha: 1))
    private let priceTitleLabel = UILabel.specialTitleLabel(text: "ЦЕНА")
    private let priceLabel = UILabel.specialLabel(color: #colorLiteral(red: 0.2980392157, green: 0.6862745098, blue: 0.3137254902, alpha: 1))
    private let likeImageView = UIImageView.likeImage()
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .systemGray3
        return view
    }()

    // MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLikeGesture()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupView(){
        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubviews([
            backgroundCell,
            routTitleLabel,
            routCitiesLabel,
            dateTitleLabel,
            dateTripLabel,
            priceTitleLabel,
            priceLabel,
            likeImageView
        ])
    }
 
    func configureCell(data: TripModel, isLike: Bool) {
        routCitiesLabel.text = "\(data.startCity) - \(data.endCity)"
        dateTripLabel.text = "с \(DateTransformer.transformDate(data.startDate)) - по \(DateTransformer.transformDate(data.endDate))"
        priceLabel.text = "\(data.price) рублей."

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

// MARK: - Constraints
extension StartScreenTableViewCell {
    private func setConstraints() {
        
        let constraints = [
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            routTitleLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 10),
            routTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),

            routCitiesLabel.topAnchor.constraint(equalTo: routTitleLabel.bottomAnchor),
            routCitiesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            routCitiesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            dateTitleLabel.topAnchor.constraint(equalTo: routCitiesLabel.bottomAnchor, constant: 10),
            dateTitleLabel.leadingAnchor.constraint(equalTo: routTitleLabel.leadingAnchor),

            dateTripLabel.topAnchor.constraint(equalTo: dateTitleLabel.bottomAnchor),
            dateTripLabel.leadingAnchor.constraint(equalTo: routCitiesLabel.leadingAnchor),
            dateTripLabel.trailingAnchor.constraint(equalTo: routCitiesLabel.trailingAnchor),

            priceTitleLabel.topAnchor.constraint(equalTo: dateTripLabel.bottomAnchor, constant: 10),
            priceTitleLabel.leadingAnchor.constraint(equalTo: routTitleLabel.leadingAnchor),

            priceLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: routCitiesLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: routCitiesLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -5),

            likeImageView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            likeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            likeImageView.heightAnchor.constraint(equalToConstant: 30),
            likeImageView.widthAnchor.constraint(equalTo: likeImageView.heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
