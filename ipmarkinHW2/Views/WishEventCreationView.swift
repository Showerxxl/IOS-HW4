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
   private enum Constants {
       static let leftconstr: CGFloat = 16
       static let rightconstr: CGFloat = 16
       static let topconstr: CGFloat = 80
       static let pickerleft: CGFloat = 60
       static let endlabelheight: CGFloat = 35
       static let createbuttontop: CGFloat = 150
       static let descriptiontop: CGFloat = 50
   }

    
    

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
        titleTextField.pinLeft(to: container, Constants.leftconstr)
        titleTextField.pinRight(to: container, Constants.rightconstr)


        descriptionTextField.pinTop(to: titleTextField, Constants.descriptiontop)
        descriptionTextField.pinLeft(to: container, Constants.leftconstr)
        descriptionTextField.pinRight(to: container, Constants.rightconstr)
        
        
        startLabel.pinTop(to: descriptionTextField, Constants.topconstr)
        startLabel.pinLeft(to: container, Constants.leftconstr)
        startLabel.pinHeight(to: startDatePicker)
        
        endLabel.pinTop(to: startLabel, Constants.topconstr)
        endLabel.pinLeft(to: container, Constants.leftconstr)
        endLabel.setHeight(Constants.endlabelheight)
        endLabel.pinWidth(to: startLabel)
        endLabel.pinHeight(to: endDatePicker)


        startDatePicker.pinTop(to: descriptionTextField, Constants.topconstr)
        startDatePicker.pinLeft(to: startLabel, Constants.pickerleft)


        endDatePicker.pinTop(to: startDatePicker, Constants.topconstr)
        endDatePicker.pinLeft(to: endLabel, Constants.pickerleft)



        createButton.pinLeft(to: container, Constants.leftconstr)
        createButton.pinRight(to: container, Constants.rightconstr)
        createButton.pinTop(to: endLabel, Constants.createbuttontop)

 
        createButton.addTarget(self, action: #selector(didTapCreateButton), for: .touchUpInside)
    }

    @objc private func didTapCreateButton() {
        let title = titleTextField.text?.isEmpty == true ? "No title" : titleTextField.text!
        let description = descriptionTextField.text?.isEmpty == true ? "No description" : descriptionTextField.text!
        var startdate = startDatePicker.date
        var enddate = endDatePicker.date
        if startdate > enddate {
            enddate = startdate
        }
                
        let event = WishEventCell.WishEventModel(
            title: title,
            description: description,
            startDate: startdate,
            endDate: enddate
        )
        delegate?.didCreateEvent(event)
        dismiss(animated: true)
    }
}
