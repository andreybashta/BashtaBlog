//
//  SecondViewController.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/29/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import UIKit
import Alamofire

class PostDetailsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postContentView: PostContentView!
    @IBOutlet weak var addCommentView: AddCommentView!
    
    var post: PostData?
    var marks = [MarkData]()
    var comments = [CommentData]()
    
    private var presenter = PostDetailsPresenter()
    
    private var currentDate: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        addCommentView.commentTextField.delegate = self
        
        presenter.attachView(view: self)
        presenter.loadData(forPost: post)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        postContentView.configureCell(post: post!)
    }
    
    @IBAction func addComment(_ sender: Any) {
        let author = UserDefaults.standard.string(forKey: "username")
        
        let comment = CommentData(commentID: 0, text: addCommentView.commentTextField.text!, datePublic: currentDate, author: author!)

        presenter.addComment(comment)
    }
    
}

// MARK: Keyboard extension
extension PostDetailsVC {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 && (comments.count > 1) {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}

extension PostDetailsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCommentView.commentTextField.resignFirstResponder()
        return true
    }
    
}

extension PostDetailsVC: PostsDetailsView {
    
    func appendComment(comment: CommentData?) {
        guard let comment = comment else {
            print("COMMENT DIDN'T ADDED TO ARRAY")
            return
        }
        self.comments.append(comment)
        tableView.reloadData()
    }
    
    func appendMarks(marks: [MarkData]?) {
        guard let marks = marks else {
            print("MARKS DIDN'T ADDED TO ARRAY")
            return
        }
        
        self.marks = marks
        
        if marks.count != 0 {
            postContentView.marksScrollView.isHidden = false
            postContentView.setScrollViewItems(marks: marks)
            postContentView.setScrollSize(marks: marks)
        }
        
    }

    func appendComments(comments: [CommentData]?) {
        guard let comments = comments else {
            print("COMMENTS DIDN'T ADDED TO ARRAY")
            return
        }
        
        self.comments = comments
        tableView.reloadData()
    }
    
}

extension PostDetailsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let commentCell = tableView.dequeueReusableCell(withIdentifier: "PostCommentCell", for: indexPath) as? PostCommentsCell {
            
            let comment = comments[indexPath.row]
            commentCell.сonfigureCell(comment: comment)
            
            return commentCell
            
        } else {
            return PostCommentsCell()
        }
        
    }
}
