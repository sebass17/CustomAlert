import UIKit

final class AlertViewController: UIViewController {
    
    var myLabel = UILabel()
    var stepper = UIStepper()
    var buttonCount = 1
    
    fileprivate var data = [String: Any?]()
    @IBOutlet fileprivate var alertDescription: UILabel!
    @IBOutlet fileprivate var alertTitle: UILabel!
    @IBOutlet fileprivate var alertImage: UIImageView!
    @IBOutlet fileprivate var container: UIView!
    @IBOutlet fileprivate var mainStackView: UIStackView!
    
    /*dismiss(animated: true, completion: nil)
     
     method used to close window
     */
    
    //MARK: - Actions and Selectors
    @IBAction func helloButton(sender:UIButton){
        if myLabel.text !=  sender.titleLabel?.text {
            myLabel.text = sender.titleLabel?.text
        } else {
            myLabel.text = "Hello Pizza"
        }
    }
    @objc func stepPressed(sender:UIStepper){
        let buttonCount = Int(sender.value)
        updateStackView(count: buttonCount)
    }
    
    @objc func addButton(sender:UIButton){
        dismiss(animated: true, completion: nil)
        //buttonCount += 1
        //updateStackView(count: buttonCount)
    }
    @objc func resetButton(sender:UIButton){
        buttonCount = 1
        updateStackView(count: buttonCount)
    }
    @objc func removeButton(sender:UIButton){
        if buttonCount > 1 {
            buttonCount -= 1
        }else{
            buttonCount = 1
        }
        updateStackView(count: buttonCount)
    }
    
    
    //MARK: View Making methods
    func makeButtonWithText(text:String) -> UIButton {
        //Initialize a button
        let myButton = UIButton(type: UIButtonType.system)
        //Set a frame for the button. Ignored in AutoLayout/ Stack Views
        myButton.frame = CGRect(x: 30, y: 30, width: 150, height: 150)
        //Set background and tint colors
        myButton.backgroundColor = UIColor.blue
        //State dependent properties title and title color
        myButton.setTitle(text, for: .normal)
        myButton.setTitleColor(UIColor.white, for: .normal)
        myButton.setTitle("Touched!!", for: .highlighted)
        myButton.setTitleColor(UIColor.yellow, for: .highlighted)
        //highlighted background image
        myButton.addTarget(self,action: #selector(helloButton),for: .touchUpInside)
        return myButton
    }
    
    func configureLabelWithText(text:String){
        //Set the attributes of the label
        myLabel.frame = CGRect(x: 30, y: 600, width: 150, height: 36)
        myLabel.textColor = UIColor.gray
        myLabel.font = UIFont(name: "Chalkduster", size: 18)
        myLabel.text = text
        myLabel.textAlignment = .right
    }
    
    func configureStepper(){
        //Set the attributes of the stepper
        stepper.minimumValue = 1.0
        stepper.maximumValue = 20.0
        stepper.stepValue = 1.0
        stepper.addTarget(self, action: #selector(stepPressed), for: .touchUpInside)
    }
    
    func stepperButtonsWithText(text:String,action: Selector ) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(hue: 0.5611, saturation: 1, brightness: 0.98, alpha: 1.0)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(text, for: .normal)
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        button.addTarget(self,action: action,for: .touchUpInside)
        return button
    }
    
    func makeStackViewStepper() -> UIStackView  {
        var viewArray = [UIView]()
        viewArray += [stepperButtonsWithText(text: "Ok", action: #selector(addButton))]
        viewArray += [stepperButtonsWithText(text: "Cancel", action: #selector(addButton))]
        let stackView = UIStackView(arrangedSubviews: viewArray)
        //properties for the stack view
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 5.0
        return stackView
    }
    
    func rainbowButtons(count:Int){
        for i in 1...count{
            let titleString = String(format:"Hello Button %i",i)
            let button = makeButtonWithText(text: titleString)
            mainStackView.addArrangedSubview(button)
        }
        colorStackView()
    }
    
    //MARK: - Instance Methods
    func colorStackView(){
        let subviewCount = mainStackView.arrangedSubviews.count
        let colorIncrement:CGFloat = 1.0 / CGFloat(subviewCount)
        var color:CGFloat = 0.0
        for aView in mainStackView.arrangedSubviews {
            aView.backgroundColor = UIColor(hue: color, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            color += colorIncrement
        }
        
    }
    
    func updateStackView(count:Int){
        //clear the stackView Array
        for aView in mainStackView.arrangedSubviews{
            mainStackView.removeArrangedSubview(aView)
            aView.removeFromSuperview()
        }
        //add the stack view back in
        //mainStackView.addArrangedSubview(stepper)
        mainStackView.addArrangedSubview(myLabel)
        rainbowButtons(count: count)
        mainStackView.addArrangedSubview(makeStackViewStepper())
        
    }
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //background color for the view
        //view.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        setImageView()
        setContainer()
        setData()
        layoutImageView()
        layoutContainer()
        /* //Iteration 1: Make a button
         view.addSubview(makeButtonWithText("Indie Button"))
         */
        /*
         //Iteration 2: Make a Button and a label
         view.addSubview(makeButtonWithText("Indie Button"))
         configureLabelWithText("Hello, Label")
         view.addSubview(myLabel)
         */
        /*
         //Iteration 3:Button and label in stack view
         configureLabelWithText("Hello, Label")
         mainStackView.addArrangedSubview(myLabel)
         mainStackView.addArrangedSubview(makeButtonWithText("Hello,Button"))
         mainStackView.addArrangedSubview(makeButtonWithText("Hello,Button 2"))
         mainStackView.addArrangedSubview(makeButtonWithText("Hello,Button 3"))
         */
        /*
         //Iteration 4:Rainbow Buttons
         mainStackView.spacing = 1.0
         configureLabelWithText("Hello, Label")
         mainStackView.addArrangedSubview(myLabel)
         rainbowButtons(count: 10)
         */
        //Iteration 5 & 6 dynamic buttons
        mainStackView.spacing = 1.0
        //configureLabelWithText(text: "Hello, Label")
        //configureStepper()
        mainStackView.addArrangedSubview(makeStackViewStepper())
    }
}

fileprivate extension AlertViewController {
    
    /*func setButton() {
     button.clipsToBounds = true
     button.layer.cornerRadius = 10
     }*/
    
    func setImageView() {
        alertImage.layer.borderColor = UIColor(hue: 0.0333, saturation: 0.7, brightness: 0.98, alpha: 1.0).cgColor
        alertImage.backgroundColor = UIColor.clear
        alertImage.isOpaque = false
        alertImage.layer.borderWidth = 2
    }
    
    func setContainer() {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor(hue: 0.0333, saturation: 0.7, brightness: 0.98, alpha: 1.0).cgColor
        container.backgroundColor = UIColor(hue: 0.0333, saturation: 0.7, brightness: 0.98, alpha: 1.0)
        container.layer.cornerRadius = 10
        container.layer.masksToBounds = false
        container.layer.insertSublayer(shape, at: 0)
    }
    
    func setData() {
        alertImage.image = data["image"] as? UIImage
        alertTitle.text = data["title"] as? String
        alertDescription.text = data["text"] as? String
    }
}

fileprivate extension AlertViewController {
    func layoutImageView() {
        alertImage.layer.cornerRadius = alertImage.frame.width/2
    }
    
    func layoutContainer() {
        let path = UIBezierPath(roundedRect: container.bounds, cornerRadius: 10.5)
        let layer = container.layer.sublayers!.first as! CAShapeLayer
        layer.path = path.cgPath
    }
}

extension AlertViewController {
    static func instance(title: String?, text: String?, image: UIImage?) -> AlertViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
        let controller = storyboard.instantiateInitialViewController() as! AlertViewController
        
        controller.data["title"] = title
        controller.data["text"] = text
        controller.data["image"] = image
        
        return controller
    }
}

