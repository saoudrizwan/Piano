//
//  ViewController.swift
//  PianoExample
//
//  Created by Saoud Rizwan on 9/11/17.
//  Copyright © 2017 Saoud Rizwan. All rights reserved.
//

import UIKit
import Piano

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    
    let cellData: [(sectionTitle: String, rows: [String])] = {
        let data = [(sectionTitle: String, rows: [String])]()
        
        for i in 1...6 {
            switch i {
            case 1:
                break
            case 2:
                break
            case 3:
                break
            case 4:
                break
            case 5:
                break
            }
        }
        
        return data
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "🎹 Piano"
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        navigationItem.setLeftBarButton(refreshButton, animated: false)
        
        label.textAlignment = .center
        label.textColor = UIColor.gray
        label.text = "Add some notes to your symphony"
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let playButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(playButtonTapped))
        toolBar.setItems([space, playButton, space], animated: false)
        let shadow = UIView()
        shadow.translatesAutoresizingMaskIntoConstraints = false
        shadow.backgroundColor = UIColor.gray.withAlphaComponent(0.275)
        toolBar.addSubview(shadow)
        NSLayoutConstraint.activate([
            shadow.leadingAnchor.constraint(equalTo: toolBar.leadingAnchor),
            shadow.heightAnchor.constraint(equalToConstant: 0.75),
            shadow.trailingAnchor.constraint(equalTo: toolBar.trailingAnchor),
            shadow.bottomAnchor.constraint(equalTo: toolBar.bottomAnchor)
            ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func playButtonTapped() {
        print("play")
    }
    
    @objc func refreshButtonTapped() {
        print("redo")
    }
    
    @objc func playThing() {
        Piano.play([
            .sound(.system(.beepBeep)),
            .waitUntilFinished,
            .sound(.system(.voicemail)),
            .waitUntilFinished,
            .tapticEngine(.failed),
            .waitUntilFinished,
            .tapticEngine(.failed),
            .waitUntilFinished,
            .sound(.system(.beginVideoRecord))
        ]) {
            print("symphony did complete")
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
