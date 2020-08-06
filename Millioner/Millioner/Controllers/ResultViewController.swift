//
//  ResultViewController.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 30.07.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    var label: UILabel!
    var button: UIButton!
    var table: UITableView!
    let cellId = "resultCell"
    let gameSessions: [GameSession] = GameSessionsCaretaker().retriveSessions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [#colorLiteral(red: 0.6941176471, green: 0.9294117647, blue: 0.9647058824, alpha: 1).cgColor,#colorLiteral(red: 0.6784313725, green: 0.7176470588, blue: 0.9568627451, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        createLabel()
        createTable()
        createButton()
        
        if gameSessions.count == 0{
            createsubLabel()
        }
    }
    

    private func createLabel(){
        label = UILabel()
        label.text = "Результаты игр"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: self.view.frame.width * 0.06)
        label.sizeToFit()
        label.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height * 0.1)
        self.view.addSubview(label)
    }
    
    private func createsubLabel(){
        let label = UILabel()
        label.text = "Тут пусто📖\nпоиграй и все будет😉"
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: self.view.frame.width * 0.06)
        label.sizeToFit()
        label.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height * 0.3)
        self.view.addSubview(label)
    }
    
    private func createTable() {
        let frame = CGRect(x: 0, y: label.frame.maxY + self.view.frame.width * 0.1,
                           width: self.view.frame.width, height: self.view.frame.height * 0.7)
        table = UITableView(frame: frame)
        table.separatorStyle = .none
        table.backgroundColor = .none
        table.delegate = self
        table.dataSource = self
        table.register(ResultViewCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(table)
    }
    
    private func createButton(){
        let buttonFrame = CGRect(x: 0, y: 0,
                                 width: self.view.frame.width * 0.8,
                                 height: self.view.frame.width * 0.15)
         button = UIButton(frame: buttonFrame)
         button.setTitleColor(.black, for: .normal)
         button.setTitle("Выход", for: .normal)
         button.titleLabel?.textAlignment = .center
         button.backgroundColor = .white
         button.layer.cornerRadius = button.frame.height / 3
         button.titleLabel?.font = .boldSystemFont(ofSize: self.view.frame.width * 0.045)
         button.center.x = self.view.frame.width / 2
         button.center.y = self.view.frame.height * 0.9
         self.view.addSubview(button)
        button.addAction {
            [unowned self] in
            self.dismiss(animated: true)
        }
    }

}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameSessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ResultViewCell
        cell.frame.size.width = self.table.frame.width
        
        cell.setup(session: gameSessions[indexPath.row])
        
        return cell
    }
}
