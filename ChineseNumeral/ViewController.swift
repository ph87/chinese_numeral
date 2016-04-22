//
//  ViewController.swift
//  ChineseNumeral
//
//  Created by alphwe on 20160216.
//  Copyright © 2016年 alphwe. All rights reserved.
//

import UIKit


let digitalMap: [Double: String ] = [
    0.01: "分",
    0.1: "角",
    0: "零",
    1: "壹",
    2: "贰",
    3: "叁",
    4: "肆",
    5: "伍",
    6: "陆",
    7: "柒",
    8: "捌",
    9: "玖",
    10: "拾",
    100: "佰",
    1000: "仟",
    10000: "万",
    100000000: "亿",
]

func convert (var value: Double) -> String {
    //value = Double(Int(value * 100)/100)
    var returnValue = ""
    if value >= 100000000 {
        let wanPart = value / 100000000.0
        value = value % 100000000.0
        let wanPartString = convert(Double(Int(wanPart)))
        if wanPartString.substringFromIndex(wanPartString.endIndex.predecessor()) == "整" {
            let subWanPartString = wanPartString.substringToIndex(wanPartString.endIndex)
            returnValue = returnValue + subWanPartString + digitalMap[100000000]!
        } else {
            returnValue = returnValue + wanPartString + digitalMap[100000000]!
        }
    }
    if value >= 10000 {
        let wanPart = value / 10000.0
        value = value % 10000.0
        let wanPartString = convert(Double(Int(wanPart)))
        if wanPartString.substringFromIndex(wanPartString.endIndex.predecessor()) == "整" {
            let subWanPartString = wanPartString.substringToIndex(wanPartString.endIndex)
            returnValue = returnValue + subWanPartString + digitalMap[10000]!
        } else {
            returnValue = returnValue + wanPartString + digitalMap[10000]!
        }
    }
    if value >= 1000 {
        let qianPart = Double(Int(value / 1000.0))
        value = value % 1000.0
        returnValue = returnValue + digitalMap[qianPart]! + digitalMap[1000]!
    }
    if value >= 100 {
        let baiPart = Double(Int(value / 100.0))
        value = value % 100.0
        returnValue = returnValue + digitalMap[baiPart]! + digitalMap[100]!
    }
    if value >= 10 {
        let shiPart = Double(Int(value / 10.0))
        value = value % 10.0
        returnValue = returnValue + digitalMap[shiPart]! + digitalMap[10]!
    }
    if value >= 0 {
        let gePart = Double(Int(value / 1.0))
        value = value % 1.0
        if returnValue != "" && gePart == 0 {
            returnValue = returnValue + "整"
        } else {
            returnValue = returnValue + digitalMap[gePart]!
        }
    }
    if value >= 0.1 {
        let jiaoPart = Double(Int(value * 10))
        value = value % 0.1
        returnValue = returnValue + digitalMap[jiaoPart]! + digitalMap[0.1]!
    }
    if value >= 0.01 {
        let jiaoPart = Double(Int(value*100))
        value = value % 0.01
        returnValue = returnValue + digitalMap[jiaoPart]! + digitalMap[0.01]!
    }
    return returnValue
}

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var outputField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.delegate = self
        outputField.userInteractionEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        inputField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        inputField.resignFirstResponder()
        return true
    }


    @IBAction func inputValueEditingDidEnd(sender: UITextField) {
        if let value = Double(sender.text!) {
            let outputValue = convert(value)
            outputField.text = outputValue
            UIPasteboard.generalPasteboard().string = outputValue
        } else {
            outputField.text = ""
        }
    }
}