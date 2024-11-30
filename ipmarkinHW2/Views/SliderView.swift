import UIKit

struct SliderView {
    static func createStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        return stack
    }

    static func createSlider(title: String, min: Double, max: Double, valueChanged: @escaping (CGFloat) -> Void) -> CustomSlider {
        let slider = CustomSlider(title: title, min: min, max: max)
        slider.valueChanged = { value in valueChanged(CGFloat(value)) }
        return slider
    }
    final class CustomSlider: UIView {
        var valueChanged: ((Double) -> Void)?

        private let slider = UISlider()
        private let titleView = UILabel()

        init(title: String, min: Double, max: Double) {
            super.init(frame: .zero)
            titleView.text = title
            slider.minimumValue = Float(min)
            slider.maximumValue = Float(max)
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            configureUI()
        }

        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        private func configureUI() {
            backgroundColor = .white
            translatesAutoresizingMaskIntoConstraints = false
            
            for view in [slider, titleView] {
                addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
            }
            
            NSLayoutConstraint.activate([
                titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
                slider.leadingAnchor.constraint(equalTo: leadingAnchor),
                slider.trailingAnchor.constraint(equalTo: trailingAnchor),
                slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ])
        }
        @objc private func sliderValueChanged() {
            valueChanged?(Double(slider.value))
        }
    }
}
