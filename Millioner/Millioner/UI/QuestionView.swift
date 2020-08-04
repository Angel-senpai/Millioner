//
//  QuestionView.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 30.07.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import UIKit

class QuestionView: UIView{
    var label: UILabel!
    var answerTrue: Bool = false
    var button: UIButton!
    var selected: Bool = false{
        willSet(newValue){
            if newValue{
                self.layer.borderColor = #colorLiteral(red: 1, green: 0.4078431373, blue: 0.4784313725, alpha: 1)
            }else{
                self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
        }
    }
    
    init(frame: CGRect,answer: String,_ answerTrue: Bool) {
        super.init(frame: frame)
        self.frame = frame
        self.answerTrue = answerTrue
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 3
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        createSubView()
        createLabel(answer)
        createButton()
        self.transform.a = 0.9
        self.transform.d = 0.9
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubView(){
        let circle = UIView(frame: CGRect(origin: CGPoint(),
        size:  CGSize(width: frame.size.width * 0.95,
                      height: frame.size.width * 0.95)))
        circle.backgroundColor = .white
        circle.layer.cornerRadius = circle.frame.height / 2
        circle.center = self.center
        self.addSubview(circle)
    }
    
    private func createLabel(_ text: String){
        label = UILabel(frame: self.bounds)
        label.text = text
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: self.frame.width * 0.1)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        self.addSubview(label)
    }
    
    private func createButton(){
        let button = UIButton(frame: self.frame)
        button.addTarget(self, action: #selector(selectedView), for: .touchUpInside)
        self.addSubview(button)
    }
    
    @objc func selectedView(){
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
            self.selected = !self.selected
        })
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.8, options: [], animations:{
            self.transform.a = self.selected ? 1 : 0.9
            self.transform.d = self.selected ? 1 : 0.9
        })
    }
}
