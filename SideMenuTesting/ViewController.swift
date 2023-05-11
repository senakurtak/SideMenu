//
//  ViewController.swift
//  SideMenuTesting
//
//  Created by Sena Kurtak on 11.05.2023.
//

import UIKit

class ViewController: UIViewController {

    var isSlideInMenuPresented = false
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.30

    lazy var menuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "sidebar.leading")?.withRenderingMode(.alwaysOriginal),
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(menuBarButtonItemTapped))

    lazy var swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))

    var home = CGAffineTransform()
    let screen = UIScreen.main.bounds

    lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
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
        containerView.backgroundColor = .systemRed
        containerView.layer.cornerRadius = 20
        // Add swipe gesture recognizer to the container view
        containerView.addGestureRecognizer(swipeGesture)

        // Add menu view and container view to the main view
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        containerView.edgeTo(view)
        
        home = containerView.transform
    }

    @objc
    func menuBarButtonItemTapped(_ sender: UIBarButtonItem) {
        toggleMenu()
    }

    @objc
    func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            showMenu()
        } else if sender.direction == .left {
            hideMenu()
        }
    }

    func showMenu() {
        isSlideInMenuPresented = true

        // Apply transform to the container view to move it to the right
        let x = screen.width * 0.5
        let scaledTransform = home.scaledBy(x: 0.5, y: 0.8)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
        UIView.animate(withDuration: 0.7) {
            self.containerView.transform = scaledAndTranslatedTransform
        }
    }

    func hideMenu() {
        isSlideInMenuPresented = false

        // Apply transform to the container view to move it back to its original position
        UIView.animate(withDuration: 0.7) {
            self.containerView.transform = self.home
        }
    }

    func toggleMenu() {
        if isSlideInMenuPresented {
            hideMenu()
        } else {
            showMenu()
        }
    }
}

public extension UIView {

    func edgeTo(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    func pinMenuTo(_ view: UIView, with constant: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

