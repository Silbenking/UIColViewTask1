//
//  ViewController.swift
//  UIColViewTask1
//
//  Created by Сергей Сырбу on 20.09.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
//    let source: [Photo] = Source.randomPhoto(with: 15) // хотим 15 рандомных фото/ работа с одной секцией
    let source: [SectionPhoto] = [ // работа с двумя секциями
        SectionPhoto(sectionName: "first section", photos: Source.randomPhoto(with: 6)),
        SectionPhoto(sectionName: "second section", photos: Source.randomPhoto(with: 6))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    //  настройка коллекции
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collectionView.dataSource = self
        collectionView.backgroundColor = .darkGray
        //регистрируем ячейку
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier:"PhotoCell") // задаем тип и идентификатор
        //регистрируем хедер, т.к. он тоже переиспользуемый
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HeaderReusableView.self)")
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 40, left: 0, bottom: 20, right: 0))
            
            // работа с делегатом
            collectionView.delegate = self
        }
        
    }
    // обращаем внимание на коолекшинFLOWlayout, насраиваем лайут
    func setupFlowLayout() -> UICollectionViewFlowLayout { // отввечает за настройку как все будет выглядеть - размеры и тд
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 100, height: 100) // размер ячейки подстраивается под этот размер
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize //не всегда хотим чтобы ячейки были одного размерв(ячейки соответствуют размерам картинки и сами высчитывают свой размер - настраиваем из cell)
        layout.minimumLineSpacing = 30 //расстояние между ячейками перпендикуляр оси скролла
        layout.minimumInteritemSpacing = 30 // расстояние между ячейками параллельно оси скролла
//        layout.sectionInset = .init(top: 30, left: 30, bottom: 30, right: 30)// отступы внури каждой секции
        layout.headerReferenceSize = .init(width: view.frame.size.width, height: 60) // размер хедера
        return layout
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { // сколько ячеек(item) будет
//        source.count //раьота с одной секцией
        source[section].photos.count //  работа с несколькими секциями
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {//настрйока itrm
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {return UICollectionViewCell()}
//        cell.imageView.image = UIImage(named: source[indexPath.item].imageName)  //работа с одной секцией
        cell.imageView.image = UIImage(named: source[indexPath.section].photos[indexPath.item].imageName) // работа с ненсколькми секциями
        return cell
    }
    //работа с несколькими секциями
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        source.count // количство секций
    }
    //работа с хедерами и футтерами
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {//какой вид секции будет использовать
        case UICollectionView.elementKindSectionHeader: //когда это хедер, то создаем вью
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderReusableView", for: indexPath) as? HeaderReusableView else {return UICollectionReusableView()}
            view.titleLabel.text = source[indexPath.section].sectionName
            return view
        default: return UICollectionReusableView()
        }
    }
}
// работа с делегатом
extension ViewController: UICollectionViewDelegate {
    // подсвечивание ячейки
//    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {//вызывается когда нужно подстветить item
//        true
//    }
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) { // какой то iteм был подсвечен и какой конкретно
////        let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell // обычно кастят до какой то ячейки
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.contentView.backgroundColor = .red
//    }
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {// уведомляет о том что подсвечивание прекратилось
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.contentView.backgroundColor = .clear
//    }
    
    // нажатие ячейки
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool { // нужно ли выделить данный элемент, реализуется по дефолту
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { //  говорит контроллеру что какой то элемент нажат
//        let alertController = UIAlertController(title: "select", message: "section - \(indexPath.section), intem - \(indexPath.item)", preferredStyle: .actionSheet)
//        let okAction = UIAlertAction(title: "ok", style: .cancel)
//        alertController.addAction(okAction)
//        present(alertController, animated: true)
        
        let vc = ImageViewController()
        navigationController?.pushViewController(vc, animated: true)
        DispatchQueue.main.async {
            vc.imageView.image = UIImage(named: self.source[indexPath.section].photos[indexPath.item].imageName)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) { // говорит контроллеру что элемент уже был нажат, срабатывает когда нажимаешь на другой элемент
        print("deselect")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //какая то ячейка вот вот отобразиться на экране, код выполняется когда ячейки отобразяться последний элемент (перед отображением)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // что то сделать после отображения, когда ячейка перестает отобрадтьсяю проскроливаем ее вниз
        print("end Display")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) { //  хедер для секции появиться, с приставкой end - хедер исчез
        print("display header \(elementKind)")
    }
}
