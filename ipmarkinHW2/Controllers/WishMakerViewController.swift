import UIKit

final class WishMakerViewController: UIViewController {
    private let addWishButton: UIButton = UIButton(type: .system)
    private let scheduleWishesButton: UIButton = UIButton(type: .system)
    private let actionStack = UIStackView()
    private var currentColor: UIColor = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .black
        configureTitle()
        configureDescription()
        configureSliders()
        configureActionStack()
        setupConstraints()
        
    }
    private func configureActionStack() {
        actionStack.axis = .vertical
        view.addSubview(actionStack)
        actionStack.spacing = Constants.spacing
        for button in [addWishButton, scheduleWishesButton] {
            actionStack.addArrangedSubview(button)
        }
        configureScheduleMissions()
        configureAddWishButton()
        actionStack.pinBottom(to: view, Constants.stackBottom)
        actionStack.pinHorizontal(to: view, Constants.stackLeading)
    }

    private func configureTitle() {
        TitleView.configure(in: view)
    }
    
    private func configureDescription() {
        DescriptionView.configure(in: view, relativeTo: TitleView.titleLabel)
    }
    private func setupConstraints() {
        let stack = view.subviews.first { $0 is UIStackView } as! UIStackView
        stack.pinBottom(to: addWishButton.topAnchor, Constants.dist)
    }

    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true

        let sliderRed = SliderView.CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = SliderView.CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = SliderView.CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)

        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }

        stack.pinLeft(to: view, Constants.stackSide)
        stack.pinRight(to: view, Constants.stackSide)
  
        
        var red: CGFloat = Constants.baseValue
        var green: CGFloat = Constants.baseValue
        var blue: CGFloat = Constants.baseValue
        
        sliderRed.valueChanged = { [weak self] value in
            red = CGFloat(value)
            self?.updateUI(red: red, green: green, blue: blue)
        }
        sliderGreen.valueChanged = { [weak self] value in
            green = CGFloat(value)
            self?.updateUI(red: red, green: green, blue: blue)
        }
        sliderBlue.valueChanged = { [weak self] value in
            blue = CGFloat(value)
            self?.updateUI(red: red, green: green, blue: blue)
        }
    }
    
    private func updateUI(red: CGFloat, green: CGFloat, blue: CGFloat) {
        let color = UIColor(red: red, green: green, blue: blue, alpha: Constants.transparency)
        
        view.backgroundColor = color
        currentColor = color

        addWishButton.setTitleColor(color, for: .normal)
        scheduleWishesButton.setTitleColor(color, for: .normal)
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: scheduleWishesButton.topAnchor, Constants.dist)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle("Add Wish", for: .normal)
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func configureScheduleMissions() {
        view.addSubview(scheduleWishesButton)
        scheduleWishesButton.setHeight(Constants.buttonHeight)
        scheduleWishesButton.pinBottom(to: view, Constants.buttonBottom)
        scheduleWishesButton.pinHorizontal(to: view, Constants.buttonSide)
        scheduleWishesButton.backgroundColor = .white
        scheduleWishesButton.setTitleColor(.systemPink, for: .normal)
        scheduleWishesButton.setTitle("Scchedule wish granting", for: .normal)
        scheduleWishesButton.layer.cornerRadius = Constants.buttonRadius
        scheduleWishesButton.addTarget(self, action: #selector(scheduleWishButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    @objc
    private func scheduleWishButtonPressed() {
        let vc = WishCalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

