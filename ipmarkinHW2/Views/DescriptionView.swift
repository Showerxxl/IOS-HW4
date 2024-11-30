import UIKit

struct DescriptionView {
    static func configure(in view: UIView, relativeTo titleView: UIView) {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "The description of WishMaker"
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        descriptionLabel.textColor = .systemBrown
        view.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20)
        ])
    }
}
