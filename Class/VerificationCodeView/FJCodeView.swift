//
//  FJCodeView.swift
//  FJKit
//
//  Created by jun on 2017/7/14.
//  Copyright © 2017年 JUN. All rights reserved.
//

import UIKit

class FJCodeView: UIView {

    /// 验证码
    var code:String?
    
    /// 验证码内容
    fileprivate var characterArray: NSMutableArray = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    /// 干扰线个数
    let kLineCount = 6
    
    /// 干扰线长度
    let kLineWidth = CGFloat(2.0)
    
    /// 验证码长度
    let kCharCount = 4
    
    /// 验证码字体大小（随机）
    let kFontSize = UIFont.systemFont(ofSize: CGFloat(arc4random() % 5) + 18)
    
    /// 初始化
    ///
    /// - Parameter frame: frame description
    override init(frame: CGRect) {
        super.init(frame: frame)
        let randomColor:UIColor = UIColor.randomColor(alpha: nil)
        self.layer.cornerRadius = 5.0   //设置layer圆角半径
        self.layer.masksToBounds = true //隐藏边界
        self.backgroundColor = randomColor
        getCode()
    }
    
    /// 初始化，自定义验证码内容
    ///
    /// - Parameters:
    ///   - frame: frame description
    ///   - characterArray: characterArray description
    init(frame: CGRect, characterArray:[String]) {
        super.init(frame: frame)
        self.characterArray = characterArray as! NSMutableArray
    }
    
    /// 绘制验证码
    ///
    /// - Parameter rect: rect description
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
        let str = NSString(string: "S")
        let size = str.size(attributes: [NSFontAttributeName : kFontSize])
        let width = rect.size.width / CGFloat(NSString(string: code!).length) - size.width
        let height = rect.size.height - size.height
        var point:CGPoint?
        var pX:CGFloat?
        var pY:CGFloat?
        // 绘制验证码
        for (i,_) in (code?.characters.enumerated())! {
            pX = CGFloat(arc4random()).truncatingRemainder(dividingBy: width) + rect.size.width / CGFloat(NSString(string: code!).length)*CGFloat(i)
            pY = CGFloat(arc4random()).truncatingRemainder(dividingBy: height)
            point = CGPoint(x: pX!, y: pY!)
            let c = NSString(string: code!).character(at: i)
            
            let codeText:NSString? = NSString(format: "%C",c)
            codeText!.draw(at: point!, withAttributes: [NSFontAttributeName : kFontSize])
        }
        
        //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
        let context :CGContext = UIGraphicsGetCurrentContext()!
        //设置画线宽度
        context.setLineWidth(kLineWidth)
        // 绘制干扰线
        for _ in 0..<kLineCount {
            //绘制干扰的彩色直线
            let randomLineColor = UIColor.randomColor(alpha: 0.2)
            context.setStrokeColor(randomLineColor.cgColor)
            //设置线的起点
            pX = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.width)
            pY = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.height)
            context.move(to: CGPoint(x: pX!, y:  pY!))
            //设置线终点
            pX = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.width)
            pY = CGFloat(arc4random()).truncatingRemainder(dividingBy: rect.size.height)
            context.addLine(to: CGPoint(x: pX!, y:  pY!))
            //画线
            context.strokePath()

        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension FJCodeView {
    
    /// 获得验证码串
    func getCode() {
        code = ""
        //随机从数组中选取需要个数的字符，然后拼接为一个字符串
        for _ in 0..<kCharCount {
            let index = Int(arc4random())%(characterArray.count - 1)
            let getStr = characterArray.object(at: index)
            code = code! + (getStr as! String)
        }
        print("验证码：\(code!)")
    }
    /// 刷新验证码
    ///
    /// - Parameters:
    ///   - touches: touches description
    ///   - event: event description
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches, with: event)
        getCode()
        setNeedsDisplay()
        
    }
}
