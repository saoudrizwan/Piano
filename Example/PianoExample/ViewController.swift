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

    @IBOutlet weak var label: ResponsiveLabel!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    
    let cellData: [(title: String, rows: [(title: String, note: 🎹.Note)])] = {
        let sections = ["", "", "Vibration", "Taptic Engine", "Haptic Feedback - Notification", "Haptic Feedback - Impact", "Haptic Feedback - Selection", "Sound - Assets Example", "Sound - File Example", "Sound - URL Example", "Sound - System Predefined"]
        
        var rows = [[(title: String, note: 🎹.Note)]]()
        for i in 0..<sections.count {
            switch i {
            case 0:
                // Wait
                rows.append([
                    (".wait(text goes here)", .wait(0))
                    ])
            case 1:
                // Wait Until Finished
                rows.append([
                    (".waitUntilFinished", .waitUntilFinished)
                    ])
            case 2:
                // Vibration
                rows.append([
                    (".vibration(.default)", .vibration(.default)),
                    (".vibration(.alert)", .vibration(.alert))
                    ])
            case 3:
                // Taptic Engine
                rows.append([
                    (".tapticEngine(.peek)", .tapticEngine(.peek)),
                    (".tapticEngine(.pop)", .tapticEngine(.pop)),
                    (".tapticEngine(.cancelled)", .tapticEngine(.cancelled)),
                    (".tapticEngine(.tryAgain)", .tapticEngine(.tryAgain)),
                    (".tapticEngine(.failed)", .tapticEngine(.failed))
                    ])
            case 4:
                // Haptic Feedback - Notification
                rows.append([
                    (".hapticFeedback(.notification(.success))", .hapticFeedback(.notification(.success))),
                    (".hapticFeedback(.notification(.warning))", .hapticFeedback(.notification(.warning))),
                    (".hapticFeedback(.notification(.failure))", .hapticFeedback(.notification(.failure)))
                    ])
            case 5:
                // Haptic Feedback - Impact
                rows.append([
                    (".hapticFeedback(.impact(.light))", .hapticFeedback(.impact(.light))),
                    (".hapticFeedback(.impact(.medium))", .hapticFeedback(.impact(.medium))),
                    (".hapticFeedback(.impact(.heavy))", .hapticFeedback(.impact(.heavy)))
                    ])
            case 6:
                // Haptic Feedback - Selection
                rows.append([
                    (".hapticFeedback(.selection)", .hapticFeedback(.selection))
                    ])
            case 7:
                // Sound - Assets Example
                rows.append([
                    (".sound(.asset(name: \"heart\"))", .sound(.asset(name: "heart"))),
                    (".sound(.asset(name: \"kiss\"))", .sound(.asset(name: "kiss"))),
                    (".sound(.asset(name: \"wink\"))", .sound(.asset(name: "wink")))
                    // MARK:-
                    // MARK: Add your own sound assets here...
                    // MARK:-
                    
                    ])
            case 8:
                // Sound - File Example
                rows.append([
                    (".sound(.asset(name: \"heart\"))", .sound(.file(name: "harp", extension: "wav")))
                    // MARK:-
                    // MARK: Add your own sound files here...
                    // MARK:-
                    
                    ])
            case 9:
                // Sound - URL Example
                let joyFileUrl = Bundle.main.url(forResource: "joy", withExtension: "wav")!
                rows.append([
                    (".sound(.url(joyFileUrl))", .sound(.url(joyFileUrl)))
                    ])
            case 10:
                // Sound - System Predefined
                rows.append([
                    (".sound(.system(.newMail))", .sound(.system(.newMail))),
                    (".sound(.system(.mailSent))", .sound(.system(.mailSent))),
                    (".sound(.system(.voicemail))", .sound(.system(.voicemail)))
                    ])
                // There's too many to manually code here, so let's use some Swift black magic
                Piano.SystemSound.allCases.forEach {
                    rows[10].append((title: ".sound(.system(.\($0))", note: .sound(.system($0))))
                }
                /*
                var z = 0
                let sounds = AnyIterator {
                    let next = withUnsafeBytes(of: &z) { $0.load(as: 🎹.SystemSound.self) }
                    if next.hashValue != z { return nil }
                    z += 1
                    return next
                } as AnyIterator<🎹.SystemSound>
                for sound in sounds {
                    rows[10].append((title: ".sound(.system(.\(sound))", note: .sound(.system(sound))))
                }
                 */
                rows[10].removeSubrange(0..<3) // remove the first three we created as an example
            default: break
            }
        }
        var data = [(title: String, rows: [(title: String, note: 🎹.Note)])]()
        for i in 0..<sections.count {
            let section = sections[i]
            let rows = rows[i]
            data.append((title: section, rows: rows))
        }
        return data
    }()
    
    lazy var waitTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.borderStyle = .none
        return textField
    }()
    
    var waitValue: TimeInterval? = nil
    
    var pianoString: String = "" {
        didSet {
            if pianoString.count == 0 {
                label.textAlignment = .center
                label.textColor = UIColor.gray
                label.text = "Add some notes to your symphony"
            } else {
                label.textAlignment = .left
                label.textColor = UIColor.black
                label.text = pianoString
            }
        }
    }
    
    var notesToPlay = [🎹.Note]()
    var notesToPlayAsStrings = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "🎹 Piano"
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        navigationItem.setLeftBarButton(refreshButton, animated: false)
        
        let undoButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undoButtonTapped))
        navigationItem.setRightBarButton(undoButton, animated: false)
        
        pianoString = ""
        
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
        let toolBarTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toolBarTapped))
        toolBarTapGestureRecognizer.delegate = self
        toolBar.addGestureRecognizer(toolBarTapGestureRecognizer)
        
        let labelLongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(labelLongPressed))
        labelLongPressGestureRecognizer.minimumPressDuration = 0.3
        labelLongPressGestureRecognizer.delegate = self
        label.addGestureRecognizer(labelLongPressGestureRecognizer)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        
        label.lineBreakMode = .byTruncatingMiddle
        label.adjustsFontSizeToFitWidth = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc func refreshButtonTapped() {
        🎹.cancel()
        waitTextField.resignFirstResponder()
        notesToPlay.removeAll()
        notesToPlayAsStrings.removeAll()
        pianoString = ""
    }
    
    @objc func undoButtonTapped() {
        waitTextField.resignFirstResponder()
        notesToPlay.removeLast()
        notesToPlayAsStrings.removeLast()
        setPianoStringToNotes()
    }
    
    @objc func toolBarTapped(sender: UITapGestureRecognizer) {
        tableView.setContentOffset(.zero, animated: true)
        waitTextField.resignFirstResponder()
    }
    
    @objc func labelLongPressed(sender: UILongPressGestureRecognizer) {
        guard sender.state == .began, let senderView = sender.view, let superView = sender.view?.superview else { return }
        senderView.becomeFirstResponder()
        let copyItem = UIMenuItem(title: "Copy", action: #selector(labelMenuCopyTapped))
        UIMenuController.shared.menuItems = [copyItem]
        UIMenuController.shared.arrowDirection = .up
        UIMenuController.shared.setTargetRect(senderView.frame, in: superView)
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
    
    @objc func labelMenuCopyTapped() {
        let text = label.text
        UIPasteboard.general.string = text
        label.resignFirstResponder()
    }
    
    @objc func playButtonTapped() {
        waitTextField.resignFirstResponder()
        if notesToPlay.count > 0 {
            label.textColor = UIColor(red: 69.0/255.0, green: 241.0/255.0, blue: 126.0/255.0, alpha: 1.0)
            🎹.play(notesToPlay) {
                self.label.textColor = UIColor.black
            }
        }
        
    }
    
    func cellTapped(indexPath: IndexPath) {
        let data = cellData[indexPath.section].rows[indexPath.row]
        switch data.note {
        case .wait, .waitUntilFinished: break
        default:
            🎹.play([data.note])
        }
    }
    
    @objc func cellAddButtonTapped(sender: UIButton) {
        waitTextField.resignFirstResponder()
        guard let cell = sender.superview as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else { return }
        let data = cellData[indexPath.section].rows[indexPath.row]
        switch data.note {
        case .wait:
            let waitNote = 🎹.Note.wait(waitValue ?? 0)
            let waitString = ".wait(\(waitValue ?? 0.0))"
            notesToPlay.append(waitNote)
            notesToPlayAsStrings.append(waitString)
        default:
            notesToPlay.append(data.note)
            notesToPlayAsStrings.append(data.title)
        }
        setPianoStringToNotes()
    }
    
    func setPianoStringToNotes() {
        var entireCommandAsString = ""
        var numberOfLines = 0
        for i in 0..<notesToPlayAsStrings.count {
            if i == 0 {
                entireCommandAsString.append("Piano.play([\n")
                numberOfLines += 1
            }
            if i != notesToPlayAsStrings.count - 1 {
                let noteToPlayAsString = notesToPlayAsStrings[i]
                entireCommandAsString.append("    " + noteToPlayAsString + ",\n")
                numberOfLines += 1
            } else {
                let noteToPlayAsString = notesToPlayAsStrings[i]
                entireCommandAsString.append("    " + noteToPlayAsString + "\n")
                numberOfLines += 1
            }
            if i == notesToPlayAsStrings.count - 1 {
                entireCommandAsString.append("    ])")
                numberOfLines += 1
            }
        }
        pianoString = entireCommandAsString
        label.numberOfLines = numberOfLines
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = cellData[section].title
        
        let unsupported = " (UNSUPPORTED)"
        switch section {
        case 3:
            // Taptic Engine
            if !UIDevice.current.hasTapticEngine {
                title.append(unsupported)
            }
        case 4, 5, 6:
            // Haptic Feedback
            if !UIDevice.current.hasHapticFeedback {
                title.append(unsupported)
            }
        default:
            break
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") ?? UITableViewCell(style: .value1, reuseIdentifier: "cellId")
        let data = cellData[indexPath.section].rows[indexPath.row]
        cell.textLabel?.text = data.title
        
        let addButton = UIButton(type: .contactAdd)
        addButton.addTarget(self, action: #selector(cellAddButtonTapped), for: .touchUpInside)
        cell.accessoryView = addButton
        
        if indexPath.section == 0 { // Wait
            cell.textLabel?.text = ""
            cell.contentView.addSubview(waitTextField)
            NSLayoutConstraint.activate([
                waitTextField.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 20),
                waitTextField.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                waitTextField.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20),
                waitTextField.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
                ])
            waitTextField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
            
            let one = ".wait("
            let two: String = (waitValue == nil) ? "tap to input seconds" : "\(waitValue!)"
            let three = ")"
            let attributedString = NSMutableAttributedString(string: one + two + three)
            attributedString.addAttributes([.foregroundColor: UIColor.black], range: NSRange(location: 0, length: one.count))
            attributedString.addAttributes([.foregroundColor: UIColor.lightGray], range: NSRange(location: one.count, length: two.count))
            attributedString.addAttributes([.foregroundColor: UIColor.black], range: NSRange(location: one.count + two.count, length: three.count))
            waitTextField.attributedText = attributedString
        } else {
            if cell.contentView.subviews.contains(waitTextField) {
                waitTextField.removeFromSuperview()
            }
        }
        
        cell.selectionStyle = (indexPath.section == 0 || indexPath.section == 1) ? .none : .default
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellTapped(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == waitTextField {
            let text = (textField.text ?? "") as NSString
            var newString = text.replacingCharacters(in: range, with: string)
            
            newString = newString.replacingOccurrences(of: ".wait(", with: "")
            newString = newString.replacingOccurrences(of: ".wait", with: "")
            newString = newString.replacingOccurrences(of: ")", with: "")
            newString = newString.replacingOccurrences(of: "tap to input seconds", with: "")
            newString = newString.replacingOccurrences(of: " ", with: "")
            
            waitValue = TimeInterval(newString)
            
            newString = ".wait(" + newString + ")"
            let attributedString = NSMutableAttributedString(string: newString)
            attributedString.addAttributes([.foregroundColor: UIColor.black], range: NSRange(location: 0, length: newString.count))
            waitTextField.attributedText = attributedString
            
            if let newPosition = textField.position(from: textField.endOfDocument, offset: -1) {
                textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            }
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == waitTextField {
            let string = ".wait(" + ((waitValue == nil) ? "" : "\(waitValue!)") + ")"
            let attributedString = NSMutableAttributedString(string: string)
            attributedString.addAttributes([.foregroundColor: UIColor.black], range: NSRange(location: 0, length: string.count))
            waitTextField.attributedText = attributedString
            
            if let newPosition = textField.position(from: textField.endOfDocument, offset: -1) {
                textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == waitTextField {
            let one = ".wait("
            let two: String = (waitValue == nil) ? "tap to input seconds" : "\(waitValue!)"
            let three = ")"
            let attributedString = NSMutableAttributedString(string: one + two + three)
            attributedString.addAttributes([.foregroundColor: UIColor.black], range: NSRange(location: 0, length: one.count))
            attributedString.addAttributes([.foregroundColor: UIColor.gray], range: NSRange(location: one.count, length: two.count))
            attributedString.addAttributes([.foregroundColor: UIColor.black], range: NSRange(location: one.count + two.count, length: three.count))
            waitTextField.attributedText = attributedString
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchedView = touch.view, touchedView.isKind(of: UIControl.self) {
            return false
        } else {
            return true
        }
    }
}

extension ViewController {
    @objc private func keyboardWillShow(notification: NSNotification) {
        let waitCellIndexPath = IndexPath(row: 0, section: 0)
        if let visibleIndexPaths = tableView.indexPathsForVisibleRows, visibleIndexPaths.contains(waitCellIndexPath) {
            tableView.scrollToRow(at: waitCellIndexPath, at: UITableViewScrollPosition.middle, animated: true)
        }
    }
}
