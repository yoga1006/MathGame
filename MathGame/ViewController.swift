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
    
    
    @IBOutlet var multiplechoiceBtn: [UIButton]!
    
    @IBOutlet weak var background1ImageView: UIImageView!
    @IBOutlet weak var background2ImageView: UIImageView!
    
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
        
        
        
        if symbolsArray[0]=="+"{
            symbolLabel.text = "+"
            num1 = Int.random(in: 1...50)
            num2 = Int.random(in: 1...50)
            ans = num1+num2
            temp1 = num1
            temp2 = num2
          
        }else if symbolsArray[1]=="−"{
            symbolLabel.text = "−"
            num1 = Int.random(in: 1...50)
            num2 = Int.random(in: 1...50)
            //避免負數，當數1小於數字2兩者交換
            if num1<num2{
                let tempnum = num1
                num1 = num2
                num2 = tempnum
            }
            ans = num1-num2
            temp1 = num1
            temp2 = num2
           
        }else if symbolsArray[2]=="×"{
            symbolLabel.text = "×"
            num1 = Int.random(in: 1...50)
            num2 = Int.random(in: 1...50)
            ans = num1*num2
            temp1 = num1
            temp2 = num2
            
        }else if symbolsArray[3]=="÷"{
            symbolLabel.text = "÷"
            num1 = Int.random(in: 1...50)
            num2 = Int.random(in: 1...50)
            //為了讓數字相除為整數
            let doublenum = Int.random(in: 1...10)
            num1 = num2*doublenum
            ans = num1/num2
            temp1 = num1
            temp2 = num2
           
        }
        //把正確解答加到options的array中
        options.append(ans)
        options.shuffle()
        
        //顯示選擇button的選項
        for i in 0...3{
            multiplechoiceBtn[i].setTitle(String(options[i]), for: .normal)
            multiplechoiceBtn[i].titleLabel?.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
            multiplechoiceBtn[i].setTitleColor(.gray, for: .normal)
            multiplechoiceBtn[i].layer.cornerRadius = 30
            
        }
        number1Label.text = "\(num1)"
        number2Label.text = "\(num2)"
        
    }
    

    
    @IBAction func selectAnswer(_ sender: UIButton) {
        index = index+1
        questionLabel.text = "\(index)"
       
        while num1 == temp1 || num2 == temp2{

            num1 = Int.random(in:1...100)
            num2 = Int.random(in:1...100)

        }
        
        
        //當答案選對時，分數加10分
        if sender.currentTitle == String(ans){
            score = score+10
        }
        randomQuestion()
        scoreLabel.text = "\(score)"
        
        if index == 11{
            randomQuestion()
            scoreLabel.text = "0"
            questionLabel.text = "1"
            index=1
        }
        
    }
    
    @IBAction func replay(_ sender: UIButton) {
        randomQuestion()
        scoreLabel.text = "0"
        questionLabel.text = "1"
        index = 1
        
    }
    
    
}

