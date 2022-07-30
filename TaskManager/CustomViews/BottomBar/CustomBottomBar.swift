import UIKit
protocol CustomBottomBarDelegate: AnyObject {
    func onAddButtonClick()
}

class CustomBottomBar: UIView {
    
    @IBOutlet private weak var circleButton: UIView!
    @IBOutlet private weak var bottomBarView: UIView!
    @IBOutlet private weak var contentView: UIView!
    
    weak var delegate: CustomBottomBarDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleButton.layer.borderColor = UIColor.black.cgColor
        circleButton.layer.borderWidth = 2
        bottomBarView.layer.borderWidth = 1
        bottomBarView.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    @objc func onAddButtonClicked() {
        delegate?.onAddButtonClick()
    }
    
    private func commonInit() {
        if let customBar = Bundle.main.loadNibNamed("CustomBottomBar", owner: self, options: nil)?[0] as? UIView {
            customBar.frame = bounds
            backgroundColor = .clear
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
