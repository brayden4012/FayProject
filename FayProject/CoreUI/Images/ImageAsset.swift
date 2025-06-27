//
//  ImageAsset.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import SwiftUI

protocol ImageAsset {
    var imageName: String { get }
    var image: Image { get }
}

extension ImageAsset where Self: RawRepresentable, Self.RawValue == String {
    var imageName: String {
        rawValue
    }

    var image: Image {
        Image(imageName)
    }
}
