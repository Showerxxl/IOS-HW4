import UIKit

protocol WishEventCreationDelegate: AnyObject {
    func didCreateEvent(_ event: WishEventCell.WishEventModel)
}

class WishEventCreationView: UIViewController {

    weak var delegate: WishEventCreationDelegate?

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter event title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter event description"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let startDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private let endDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let startLabel: UILabel = {
           let label = UILabel()
       label.text = "Start"
       label.font = UIFont.systemFont(ofSize: 17)
       label.textColor = .black
       label.textAlignment = .center
       label.layer.cornerRadius = 5
       label.layer.masksToBounds = true
       label.backgroundColor =  UIColor.systemGray5
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()

   private let endLabel: UILabel = {
       let label = UILabel()
       label.text = "End"
       label.font = UIFont.systemFont(ofSize: 17)
       label.textColor = .black
       label.textAlignment = .center
       label.layer.cornerRadius = 5
       label.layer.masksToBounds = true
       label.backgroundColor =  UIColor.systemGray5
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve

        configureUI()
    }

    private func configureUI() {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)

        container.addSubview(titleTextField)
        container.addSubview(descriptionTextField)
        container.addSubview(startDatePicker)
        container.addSubview(endDatePicker)
        container.addSubview(createButton)
        container.addSubview(startLabel)
        container.addSubview(endLabel)

    
        container.pin(to: view)
        container.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        titleTextField.pinTop(to: container, 16)
        titleTextField.pinLeft(to: container, 16)
        titleTextField.pinRight(to: container, 16)


        descriptionTextField.pinTop(to: titleTextField, 50)
        descriptionTextField.pinLeft(to: container, 16)
        descriptionTextField.pinRight(to: container, 16)
        
        
        startLabel.pinTop(to: descriptionTextField, 80)
        startLabel.pinLeft(to: container, 16)
        startLabel.pinHeight(to: startDatePicker)
        
        endLabel.pinTop(to: startLabel, 80)
        endLabel.pinLeft(to: container, 16)
        endLabel.setHeight(35)
        endLabel.pinWidth(to: startLabel)
        endLabel.pinHeight(to: endDatePicker)


        startDatePicker.pinTop(to: descriptionTextField, 80)
        startDatePicker.pinLeft(to: startLabel, 60)


        endDatePicker.pinTop(to: startDatePicker, 80)
        endDatePicker.pinLeft(to: endLabel, 60)



        createButton.pinLeft(to: container, 16)
        createButton.pinRight(to: container, 16)
        createButton.pinTop(to: endLabel, 150)

 
        createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
    }

    @objc private func didTapCreateButton() {
        let title = titleTextField.text?.isEmpty == true ? "No title" : titleTextField.text!
        let description = descriptionTextField.text?.isEmpty == true ? "No description" : descriptionTextField.text!

        let event = WishEventCell.WishEventModel(
            title: title,
            description: description,
            startDate: startDatePicker.date,
            endDate: endDatePicker.date
        )
        delegate?.didCreateEvent(event)
        dismiss(animated: true)
    }
}
