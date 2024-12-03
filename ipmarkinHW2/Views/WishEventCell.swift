import UIKit

final class WishEventCell: UICollectionViewCell {

    static let reuseIdentifier: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let dateRangeLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureDateRangeLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    private enum Constants {
        static let offset: CGFloat = 8
        static let cornerRadius: CGFloat = 12
        static let backgroundColor: UIColor = .white

        static let titleTop: CGFloat = 12
        static let titleLeading: CGFloat = 12
        static let titleFont: UIFont = UIFont.preferredFont(forTextStyle: .headline)

        static let descriptionTop: CGFloat = 20
        static let descriptionLeading: CGFloat = 12
        static let descriptionTrailing: CGFloat = -12
        static let descriptionFont: UIFont = UIFont.preferredFont(forTextStyle: .subheadline)

        static let labelTop: CGFloat = 20
        static let labelLeading: CGFloat = 12
        static let labelFont: UIFont = UIFont.preferredFont(forTextStyle: .footnote)
    }
    
    struct WishEventModel {
        let title: String
        let description: String
        let startDate: Date
        let endDate: Date
    }

    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        dateRangeLabel.text = "\(formatDate(event.startDate)) - \(formatDate(event.endDate))"
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }

    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = Constants.titleFont
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
        titleLabel.pinRight(to: wrapView, Constants.descriptionTrailing)
    }

    private func configureDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.pinTop(to: titleLabel, Constants.descriptionTop)
        descriptionLabel.pinLeft(to: wrapView, Constants.descriptionLeading)
        descriptionLabel.pinRight(to: wrapView, Constants.descriptionTrailing)
    }

    private func configureDateRangeLabel() {
        addSubview(dateRangeLabel)
        dateRangeLabel.font = Constants.labelFont
        dateRangeLabel.textColor = .darkGray
        dateRangeLabel.numberOfLines = 1
        dateRangeLabel.pinTop(to: descriptionLabel, Constants.labelTop)
        dateRangeLabel.pinLeft(to: wrapView, Constants.labelLeading)
        dateRangeLabel.pinRight(to: wrapView, Constants.descriptionTrailing)
    }

    func getEventDetails() -> WishEventModel {
        let title = titleLabel.text ?? ""
        let description = descriptionLabel.text ?? ""
        let startDate = Date()
        let endDate = Date()
        return WishEventModel(title: title, description: description, startDate: startDate, endDate: endDate)
    }
}

