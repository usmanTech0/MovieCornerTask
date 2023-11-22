//
//  ImageDownloader.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import Foundation
import Kingfisher

extension UIImageView {
    func downloadImage(withWidth:ImageWidth = .w500, path:String) {
        self.kf.setImage(with: URL(string: "\(URLSettings.imageBaseURL)\(withWidth.rawValue)\(path)"), placeholder: UIImage(named: "placeholderImage"))
    }
}
