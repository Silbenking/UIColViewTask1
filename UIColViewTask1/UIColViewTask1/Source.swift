//
//  Source.swift
//  UIColViewTask1
//
//  Created by Сергей Сырбу on 20.09.2023.
//

import Foundation

struct Source {
    static func allPhoto() -> [Photo] {
        // хранятся фото
        [
            .init(id: 1, imageName: "белка"),
            .init(id: 2, imageName: "зебра"),
            .init(id: 3, imageName: "кенгуру"),
            .init(id: 4, imageName: "лягушка"),
            .init(id: 5, imageName: "медведь"),
            .init(id: 6, imageName: "мышь"),
            .init(id: 7, imageName: "олень"),
            .init(id: 8, imageName: "панда"),
            .init(id: 9, imageName: "слон"),
            .init(id: 10, imageName: "улитка")
        ]
    }
    
    static func randomPhoto(with count: Int) -> [Photo] { //по введенному количесвту выдает рандомное количество фото и порядке
        return (0..<count).map{ _ in allPhoto().randomElement()!}
    }
}

struct Photo { // описание структуры
    let id: Int
    let imageName: String
}

struct SectionPhoto {
    let sectionName: String
    var photos: [Photo]
}
