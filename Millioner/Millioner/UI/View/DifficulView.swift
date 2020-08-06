//
//  DifficulView.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 04.08.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import UIKit


class DifficulView: UIView {
    
    private(set) var difficult: Difficult!
    var label: UILabel!
    var pictureView: UIImageView!
    var button: UIButton!
    var descr: String = ""
    var selected: Bool = false{
        didSet{
            self.backgroundColor = selected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
    init(size: CGSize, label text: String, picture image: UIImage, state: Bool, description: String, difficult: Difficult) {
        super.init(frame: CGRect())
        self.frame.size = size
        self.difficult = difficult
        createLabel(text)
        createPicture(image)
        createButton()
        selected = state
        self.descr = description
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 5
        self.transform.a = 0.9
        self.transform.d = 0.9
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel(_ text: String){
        label = UILabel()
        label.text = text
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: self.frame.width * 0.1)
        label.sizeToFit()
        
        label.center.x = self.frame.width / 2
        label.frame.origin.y += self.frame.width * 0.05
        self.addSubview(label)
    }
    private func createPicture(_ image: UIImage){
        let imageSize = CGSize(width: self.frame.width * 0.6, height: self.frame.width * 0.6)
        pictureView = UIImageView(frame: CGRect(origin: CGPoint(), size: imageSize))
        pictureView.image = image
        pictureView.contentMode = .scaleAspectFit
        pictureView.center = CGPoint(x:  self.frame.width / 2, y:  self.frame.height / 2)
        self.addSubview(pictureView)
    }
    
    private func createButton(){
        button = UIButton(frame: self.frame)
        self.addSubview(button)
    }
    
    @objc func selectedView(){
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
            self.selected = !self.selected
        })
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations:{
            self.transform.a = self.selected ? 1 : 0.9
            self.transform.d = self.selected ? 1 : 0.9
        })
    }
    
    
}
