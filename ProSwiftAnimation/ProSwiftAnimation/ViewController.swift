

import UIKit

class ViewController: UIViewController {

    let box: UIView = {
        let box = UIView()
        box.translatesAutoresizingMaskIntoConstraints = false
        box.backgroundColor = .darkGray
        box.layer.cornerRadius = 8
        return box
    }()
    
    lazy var imageVIew: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bg"))
        imageView.frame = view.frame //just going to be bg of screen that why
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var boxHeight: NSLayoutConstraint!
    var boxWidth: NSLayoutConstraint!
    var boxTop: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageVIew)
        view.addSubview(box)
        
        boxHeight = box.heightAnchor.constraint(equalToConstant: 125)
        boxWidth = box.widthAnchor.constraint(equalToConstant: 125)
        boxTop = box.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        box.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        boxHeight.isActive = true
        boxWidth.isActive = true
        boxTop.isActive = true
        
        box.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animateBox)))
    }

    @objc fileprivate func animateBox() {
        print("trying to animate box")
        boxHeight.constant = boxHeight.constant == 125 ? 200 : 125
        boxWidth.constant = boxWidth.constant == 125 ? 200 : 125
        
        boxTop.isActive = false
        boxTop = boxHeight.constant == 125 ? box.topAnchor.constraint(equalTo: view.centerYAnchor) : box.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        boxTop.isActive = true
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.view.layoutIfNeeded() //after view has been loaded, if any changes are remaining, immediately carried out like above boxheight constraint
        }
    }

}

