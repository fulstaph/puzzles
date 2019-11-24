//
//  ViewController.swift
//  Puzzles
//
//  Created by Leonid Serebryanyy on 18.11.2019.
//  Copyright © 2019 Leonid Serebryanyy. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

	var imageView = UIImageView()
	var puzzleButton = UIButton(type: .system)
	var quizButton = UIButton(type: .system)
	
	let networkService: NetworkService
	
	init(networkService: NetworkService) {
		self.networkService = networkService
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	required init() {
		fatalError("use 'init networkService:' instead")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = UIColor.blue.withAlphaComponent(0.7)
		view.addSubview(imageView)
		
		puzzleButton.translatesAutoresizingMaskIntoConstraints = false
		puzzleButton.addTarget(self, action: #selector(puzzle), for: .touchUpInside)
		puzzleButton.setTitle("puzzle!", for: .normal)
		view.addSubview(puzzleButton)
		
		quizButton.translatesAutoresizingMaskIntoConstraints = false
		quizButton.addTarget(self, action: #selector(quiz), for: .touchUpInside)
		quizButton.setTitle("quiz!", for: .normal)
		view.addSubview(quizButton)
		
		createConstraints()
	}

	
	@objc
	func puzzle() {
		networkService.loadPuzzle {[weak self] (result) in
			DispatchQueue.main.async {
				switch result {
				case .success(let image):
					self?.imageView.image = image
				case .failure(let error):
					let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
					self?.show(alert, sender: nil)
				}
			}
		}
	}
	
	@objc
	func quiz() {
	  // <#место для вашего кода#>
		// здесь по аналогии с puzzle, так что верю, что вы справитесь!
        networkService.loadQuiz { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.imageView.image = image
                case .failure(let error):
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription,      preferredStyle: .alert)
                    self?.show(alert, sender: nil)
                }
            }
        }
	}
	
	func createConstraints() {
		let safeArea = self.view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
			imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
			imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
			])
		NSLayoutConstraint.activate([
			puzzleButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
			puzzleButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
			puzzleButton.bottomAnchor.constraint(greaterThanOrEqualTo: safeArea.bottomAnchor, constant: -80),
			])
		NSLayoutConstraint.activate([
			quizButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
			quizButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
			quizButton.bottomAnchor.constraint(greaterThanOrEqualTo: safeArea.bottomAnchor, constant: -80),
			])
		
		quizButton.leadingAnchor.constraint(equalTo: puzzleButton.trailingAnchor, constant: -40).isActive = true
		quizButton.widthAnchor.constraint(equalTo: puzzleButton.widthAnchor).isActive = true
	}

}

