//
//  ImagesServices.swift
//  Puzzles
//
//  Created by Leonid Serebryanyy on 19.11.2019.
//  Copyright © 2019 Leonid Serebryanyy. All rights reserved.
//

import Foundation
import UIKit


class ImagesServices {
	
	static public func image(byCombining fourImages: [UIImage]) -> UIImage? {
		let oneImageSize = CGSize(width: 150, height: 150)
		let croppedImages = fourImages.compactMap { (image) in
			return crop(image, to: oneImageSize)
		}
		
		let newImageSize = CGSize(width: oneImageSize.width * 2, height: oneImageSize.height * 2)
		UIGraphicsBeginImageContext(newImageSize)
		croppedImages.enumerated().forEach { (index, image) in
			if index < 2 {
				image.draw(at: CGPoint(x: CGFloat(index) * oneImageSize.width, y: 0))
			} else if index < 4 {
				image.draw(at: CGPoint(x: CGFloat(index - 2) * oneImageSize.width, y: oneImageSize.height))
			} else {
				print("that's more that 4 images, ignoring")
			}
		}
		let result = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		return result
	}
	
	static private func crop(_ image: UIImage, to size: CGSize) -> UIImage? {
		let imageRect = CGRect(origin: .zero, size: size)
		UIGraphicsBeginImageContext( imageRect.size );
		image.draw(in: imageRect)
		let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return croppedImage
	}
	
}
