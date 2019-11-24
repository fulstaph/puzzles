//
//  NetworkService.swift
//  Puzzles
//
//  Created by Leonid Serebryanyy on 18.11.2019.
//  Copyright © 2019 Leonid Serebryanyy. All rights reserved.
//

import Foundation
import UIKit


class NetworkService {
	
	let session: URLSession
	
	private var queue = DispatchQueue(label: "com.sber.puzzless", qos: .default, attributes: .concurrent)

	
	init() {
		session = URLSession(configuration: .default)
	}
	
	
	// MARK:- Первое задание
	
	///  Вот здесь должны загружаться 4 картинки и совмещаться в одну.
	///  Для выполнения этой задачи вам можно изменять только этот метод.
	///  Метод, соединяющий картинки в одну, уже написан (вызывается в конце).
	///  Ответ передайте в completion.
	///  Помните, что надо сделать так, чтобы метод работал как можно быстрее.
	public func loadPuzzle(completion: @escaping (Result<UIImage, Error>) -> ()) {
		// это адреса картинок. они работающие, всё ок!
		let firstURL = URL(string: "https://i.imgur.com/JnY1dY7.jpg")!
		let secondURL = URL(string: "https://i.imgur.com/S93pvex.jpg")!
		let thirdURL = URL(string: "https://i.imgur.com/pvCHGsL.jpg")!
		let fourthURL = URL(string: "https://i.imgur.com/DgijrVE.jpg")!
		let urls = [firstURL, secondURL, thirdURL, fourthURL]
        
		// в этот массив запишите итоговые картинки
		var results = [UIImage]()
		//<#место для вашего кода#>
		let group = DispatchGroup()
        // sry for forced unwrap ain't nobody got time for that
        for img_url in urls {
            group.enter()
            let data = try! Data(contentsOf: img_url)
            results.append(UIImage(data: data)!)
            group.leave()
        }
	
		//group.wait()
        group.notify(queue: DispatchQueue.main) {
            if let merged = ImagesServices.image(byCombining: results) {
                completion(.success(merged))
            }
        }
//
//        DispatchQueue.main.async {
//            if let merged = ImagesServices.image(byCombining: results) {
//                completion(.success(merged))
//            }
//
//        }
	}
	
	
	// MARK:- Второе задание
	
	
	///  Здесь задание такое:
	///  У вас есть ключ keyURL, по которому спрятан клад.
	///  Верните картинку с этим кладом в completion
    public func loadQuiz(completion: @escaping(Result<UIImage, Error>) -> ()) {
        
        let opQ = OperationQueue()
        var pic_url = String()
        let keyURL = URL(string: "https://sberschool-c264c.firebaseio.com/enigma.json?avvrdd_token=AIzaSyDqbtGbRFETl2NjHgdxeOGj6UyS3bDiO-Y")!
        var img = UIImage()
		// Вам придёт строка, её надо прочитать с помощью JSONDecoder (ну как мы всегда читали с файрбэйза)
		//<#место для вашего кода#>
        let op1 = BlockOperation {
            let group = DispatchGroup()
            group.enter()
            let request = URLRequest(url: keyURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request,
                                        completionHandler: {
                                            (data: Data?, response: URLResponse?, error: Error?) in
                                            pic_url = String(data: data!, encoding: .utf8)!
                                                .trimmingCharacters(in: CharacterSet(charactersIn: "\\ \""))
                                            group.leave()
                                            
            })
            task.resume()
            
            group.wait()
        }
        let op2 = BlockOperation {
            let data = try! Data(contentsOf: URL(string: pic_url)!)
            img = UIImage(data: data)!
        }
        
        op2.addDependency(op1)
        opQ.addOperations([op2, op1], waitUntilFinished: true)
        
        DispatchQueue.main.async {
            completion(.success(img))
        }
    }

}
