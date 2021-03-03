//
//  EMOMCommentViewController.swift
//  onemoretimer
//
//  Created by Derrick on 2021/02/24.
//

import UIKit

class EMOMCommentViewController: UIViewController {

    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var labelCurrentTime: UILabel!
    @IBOutlet weak var textViewComment: UITextView!
    @IBOutlet weak var buttonInsertComment: UIButton!
    
    var db:DBHelper = DBHelper()
    
    var getRound = 0
    var getSecond = 0
    var getCurrentTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI Shape
        textViewComment.layer.borderWidth = 1
        textViewComment.layer.masksToBounds = true
        textViewComment.layer.cornerRadius = 8
        buttonInsertComment.layer.masksToBounds = true
        buttonInsertComment.layer.cornerRadius = 20
        
        // show workout result
        let minute = getSecond / 60
        let second = getSecond % 60
        var stringWorkTime = ""
        
        if minute > 10 {
            if second < 10 {
                stringWorkTime = "\(minute):0\(second)"
            }else{
                stringWorkTime = "\(minute):\(second)"
            }
        }else{
            if second < 10 {
                stringWorkTime = "0\(minute):0\(second)"
            }else{
                stringWorkTime = "0\(minute):\(second)"
            }
        }
       
        labelCurrentTime.text = getCurrentTime
        labelResult.text = "\(stringWorkTime) / \(getRound) 라운드"
    }
    
    // from segue
    func receiveItems(_ round: String, _ timeSecond: Int, _ date : String) {
        getRound = Int(round)!
        getSecond = timeSecond
        getCurrentTime = date
        
    }
    // Insert Function
    @IBAction func buttonInsertComment(_ sender: UIButton) {
        let InsertExerciseComment: String = textViewComment.text!.trimmingCharacters(in: .whitespaces)
        
        // comment update
        db.updateByID(exerciseWhen: getCurrentTime, exerciseComment: InsertExerciseComment)
        print(db.read())
        performSegue(withIdentifier: "unwindEmomTimer", sender: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
