//
//  ResultViewCell.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 04.08.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import UIKit

class ResultViewCell: UITableViewCell {
    var labelAnswerCount: UILabel!
    var labelAnswerRight: UILabel!
    var labelPrize: UILabel!
    var viewT: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        createLabelAnswerCount()
        createLabelAnswerRight()
        createLabelPrize()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func createView(){
        viewT?.removeFromSuperview()
        viewT = UIView(frame: labelAnswerCount.frame)
        viewT.frame.origin.y += self.frame.width * 0.05
        viewT.backgroundColor = .black
        self.addSubview(viewT)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setup(session: GameSession){
        labelAnswerCount.text = "Всего вопросов:\n \(session.questions.count)"
        labelAnswerRight.text = "Правильных ответов:\n \(session.answerRight) (\(session.rightProcent.rounded())%)"
        labelPrize.text = "Выигрыш:\n \(session.prize)"
        
        setupLabels()
    }
    private func setupLabels(){
        labelAnswerCount.sizeToFit()
        labelPrize.sizeToFit()
        labelAnswerRight.sizeToFit()
        
        labelAnswerCount.frame.origin.x = self.frame.origin.x + self.frame.width * 0.1
        labelAnswerCount.center.y = self.frame.height / 2
        
        labelAnswerRight.frame.origin.x = labelAnswerCount.frame.maxX + self.frame.width * 0.08
        labelAnswerRight.center.y = self.frame.height / 2
        
        labelPrize.frame.origin.x = labelAnswerRight.frame.maxX + self.frame.width * 0.08
        labelPrize.center.y = self.frame.height / 2
    }
    private func createLabelAnswerCount(){
        labelAnswerCount = UILabel(frame: CGRect())
        labelAnswerCount.font = .boldSystemFont(ofSize: self.frame.width * 0.035)
        labelAnswerCount.textAlignment = .center
        labelAnswerCount.numberOfLines = 2
        self.addSubview(labelAnswerCount)
    }
    private func createLabelAnswerRight(){
        labelAnswerRight = UILabel(frame: CGRect())
        labelAnswerRight.font = .boldSystemFont(ofSize: self.frame.width * 0.035)
        labelAnswerRight.textAlignment = .center
        labelAnswerRight.numberOfLines = 2
        self.addSubview(labelAnswerRight)
    }
    private func createLabelPrize(){
        labelPrize = UILabel(frame: CGRect())
        labelPrize.font = .boldSystemFont(ofSize: self.frame.width * 0.035)
        labelPrize.textAlignment = .center
        labelPrize.numberOfLines = 2
        self.addSubview(labelPrize)
    }

}
