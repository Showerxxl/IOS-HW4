import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    
    var addWish: ((String) -> Void)?
    
    private enum Constants {
        static let textViewCornerRadius: CGFloat = 8
        static let buttonHeight: CGFloat = 40
        static let buttonTitle: String = "Add Wish"
        static let padding: CGFloat = 16
        static let fontSize: CGFloat = 16
        static let heightConstraint: CGFloat = 100
    }
    
    private let wishTextView: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = Constants.textViewCornerRadius
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.font = UIFont.systemFont(ofSize: Constants.fontSize)
        return textView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.buttonTitle, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.textViewCornerRadius
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.fontSize)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureActions()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        contentView.addSubview(wishTextView)
        contentView.addSubview(addButton)
        
        wishTextView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wishTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            wishTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            wishTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            wishTextView.heightAnchor.constraint(equalToConstant: Constants.heightConstraint),
            
            addButton.topAnchor.constraint(equalTo: wishTextView.bottomAnchor, constant: Constants.padding),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            addButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding)
        ])
    }
    
    private func configureActions() {
        addButton.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addWishButtonTapped() {
        guard let wish = wishTextView.text, !wish.isEmpty else { return }
        addWish?(wish)
        wishTextView.text = "" // Очищаем текстовое поле после добавления
    }
}

