//
//  ViewController.swift
//  MathGame
//
//  Created by Yoga on 2022/6/13.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var number1Label: UILabel!
    @IBOutlet weak var number2Label: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    @IBOutlet var resultView: UIView!
    @IBOutlet var multiplechoiceBtn: [UIButton]!
    
    @IBOutlet weak var background1ImageView: UIImageView!
    @IBOutlet weak var background2ImageView: UIImageView!
    
    @IBOutlet weak var score2Label: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    var num1 = 0
    var num2 = 0
    var ans = 0
    var symbolsArray = ["+","−","×","÷"]
    var score = 0
    var numberOfQuestion = 1
   //存選擇題選項的array
    var options:[Int] = []
    //非正解的其他三個選項
    var option1 = 0
    var option2 = 0
    var option3 = 0
    var index = 1
    //存暫時的num1、num2
    var temp1 = 0
    var temp2 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        background1ImageView.layer.cornerRadius = 60
        background2ImageView.layer.cornerRadius = 60
        randomQuestion()
        scoreLabel.text = "0"
        questionLabel.text = "1"
        
        
    }

    func randomQuestion(){
        //運算符號隨機
        symbolsArray.shuffle()
        option1 = Int.random(in: 1...100)
        option2 = Int.random(in: 1...100)
        option3 = Int.random(in: 1...100)
        options = [option1,option2,option3]
        num1 = Int.random(in: 1...50)
        num2 = Int.random(in: 1...50)
        temp1 = num1
        temp2 = num2
        //避免random出來的數字重複
        while num1 == temp1 || num2 == temp2{

            num1 = Int.random(in:1...50)
            num2 = Int.random(in:1...50)

        }
        
        //加法
        if symbolsArray[0]=="+"{
            symbolLabel.text = "+"
            ans = num1+num2
           
        //減法
        }else if symbolsArray[1]=="−"{
            symbolLabel.text = "−"
           
            //避免負數，當數1小於數字2兩者交換
            if num1<num2{
                let tempnum = num1
                num1 = num2
                num2 = tempnum
            }
            ans = num1-num2
        
        //乘法
        }else if symbolsArray[2]=="×"{
            symbolLabel.text = "×"
            ans = num1*num2
            
        //除法
        }else if symbolsArray[3]=="÷"{
            symbolLabel.text = "÷"
           
            //為了讓數字相除為整數
            let doublenum = Int.random(in: 1...10)
            num1 = num2*doublenum
            ans = num1/num2
            
           
        }
        //把正確解答加到options的array中
        options.append(ans)
        options.shuffle()
        
        //顯示選擇button的選項
        for i in 0...3{
            multiplechoiceBtn[i].setTitle(String(options[i]), for: .normal)
            //改變button的顯示字體，不然會跑回預設無法與storyboard設定的字相同
            multiplechoiceBtn[i].titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
            //改變button的顏色
            multiplechoiceBtn[i].setTitleColor(.gray, for: .normal)
            //改變button的邊框角度
            multiplechoiceBtn[i].layer.cornerRadius = 30
            
        }
        number1Label.text = "\(num1)"
        number2Label.text = "\(num2)"
        
    }
    

    
    @IBAction func selectAnswer(_ sender: UIButton) {
        index = index+1
        questionLabel.text = "\(index)"
       
        
        //當答案選對時，分數加10分
        if sender.currentTitle == String(ans){
            score = score+10
        }
        randomQuestion()
        scoreLabel.text = "\(score)"
        
        if index == 11{
            
            resultView.isHidden = false
            score2Label.text = "\(score)"
            if score == 100{
                levelLabel.text = "根本數學小天才！"
            }else if score >= 60 {
                levelLabel.text = "差一點點了！"
            }else{
                levelLabel.text = "可以改學習國文！"
            }
            
            randomQuestion()
            scoreLabel.text = "0"
            score = 0
            questionLabel.text = "1"
            index=1
        }
        
    }
    
    @IBAction func replay(_ sender: UIButton) {
        randomQuestion()
        scoreLabel.text = "0"
        score = 0
        questionLabel.text = "1"
        index = 1
        
    }
    
    
    @IBAction func playagain(_ sender: UIButton) {
        resultView.isHidden = true
        randomQuestion()
        scoreLabel.text = "0"
        score = 0
        questionLabel.text = "1"
        index = 1
    }
    
    
}

