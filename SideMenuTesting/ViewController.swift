//
//  ViewController.swift
//  SideMenuTesting
//
//  Created by Sena Kurtak on 11.05.2023.
//


import UIKit

class ViewController: UIViewController {
    
    var isSlideInMenuPresented = false
    
    lazy var slideInMenuPadding : CGFloat = self.view.frame.width * 0.30
    
    lazy var menuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading")?.withRenderingMode(.alwaysOriginal),
                                                 style: .done,
                                                 target: self, action: #selector(menuBarButtomItemTapped))
    
    @objc
    func menuBarButtomItemTapped(){
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.containerView.frame.origin.x = self.isSlideInMenuPresented ? 0 : self.containerView.frame.width - self.slideInMenuPadding
        } completion: { (finished) in
            print("Animation finished")
            self.isSlideInMenuPresented.toggle()
        }
    }
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Side Menu"
        navigationItem.setLeftBarButton(menuBarButtonItem, animated: false)
        
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        containerView.edgeTo(view)
    }
}

public extension UIView{
    
    func edgeTo(_ view: UIView){
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    func pinMenuTo(_ view: UIView, with constant: CGFloat){
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        // !!! değişiklikleri yapacağın kısım
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}
