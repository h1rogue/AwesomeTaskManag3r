import UIKit
class CustomBottomBar: UIView {

@IBOutlet private weak var circleButton: UIView!
@IBOutlet private weak var bottomBarView: UIView!
@IBOutlet private weak var contentView: UIView!


override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
}
   
override func layoutSubviews() {
    super.layoutSubviews()
    circleButton.layer.borderColor = UIColor.black.cgColor
    circleButton.layer.borderWidth = 2
}

required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
}

@objc func onAddButtonClicked() {
    print("add")
}

private func commonInit() {
    if let customBar = Bundle.main.loadNibNamed("CustomBottomBar", owner: self, options: nil)?[0] as? UIView {
        customBar.frame = bounds
        addSubview(customBar)
        circleButton.layer.cornerRadius = circleButton.frame.height/2
        circleButton.clipsToBounds = true
        circleButton.isUserInteractionEnabled = true
        print(self.circleButton.frame.size)
        print(self.contentView.frame.size)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onAddButtonClicked))
        circleButton.addGestureRecognizer(tapGesture)
    }
}
}
