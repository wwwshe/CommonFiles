//
//  TutorialView.swift
//
//  Created by jun wook on 2020/02/18.
//  Copyright © 2020 ryuickhwan. All rights reserved.
//

import Foundation
import UIKit


/// 튜토리얼 커스텀 뷰
class TutorialView : UIView{
    var margin : CGFloat = 5
    let backgroundView = UIView()
    let tutorialView = UIView()
    let commentView = UIView()
    let arrowView = UIImageView(image: #imageLiteral(resourceName: "coachmarkArrowTop"))
    let screenShotView = UIImageView(frame: .zero)
    let commentLabel = PaddingLabel(withInsets: 10, 10, 10, 10)
    var beforeConstraint : [NSLayoutConstraint]? = nil

    init(){
        super.init(frame: .zero)
        setViews()
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        self.isHidden = true
    }
    
    /// 초기 백그라운드 뷰 셋팅
    /// - Parameter view: 튜토리얼뷰를 넣을 메인 뷰
    func setBackgroundView(view : UIView){
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    /// 뷰 오토 레이아웃 셋팅
    func setViews(){
        self.isUserInteractionEnabled = false
        self.tutorialView.isUserInteractionEnabled = false
        tutorialView.layer.borderColor = UIColor.white.cgColor
        tutorialView.layer.borderWidth = 10
        tutorialView.layer.cornerRadius = 5
        tutorialView.layer.masksToBounds = true
        tutorialView.backgroundColor = .clear
        
        commentLabel.text = "테스트 테스트 테스트 테스트"
        commentLabel.layer.masksToBounds = true
        commentLabel.layer.cornerRadius = 5
        commentLabel.backgroundColor = .white
        
        tutorialView.translatesAutoresizingMaskIntoConstraints = false
        commentView.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        screenShotView.translatesAutoresizingMaskIntoConstraints = false
        
        commentView.backgroundColor = UIColor.clear
        commentView.addSubview(arrowView)
        commentView.addSubview(commentLabel)

        backgroundView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        tutorialView.addSubview(screenShotView)
        self.addSubview(backgroundView)
        self.addSubview(tutorialView)
        self.addSubview(commentView)
        
     
        NSLayoutConstraint.activate([
            arrowView.topAnchor.constraint(equalTo: commentView.topAnchor,constant: margin),
            arrowView.centerXAnchor.constraint(equalTo: commentView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: arrowView.bottomAnchor,constant: 0),
        
        ])

        let leading = commentLabel.leadingAnchor.constraint(greaterThanOrEqualTo: backgroundView.leadingAnchor, constant:  10)
        leading.priority = .required
      
        let trailing = commentLabel.trailingAnchor.constraint(lessThanOrEqualTo: backgroundView.trailingAnchor, constant: -10)
        trailing.priority = .required
    

    let center = commentLabel.centerXAnchor.constraint(equalTo: tutorialView.centerXAnchor, constant: 0)
        center.priority = .defaultHigh
      NSLayoutConstraint.activate([
        leading,
        trailing,
        center
        ])
               
        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: tutorialView.bottomAnchor,constant: 0),
            commentView.centerXAnchor.constraint(equalTo: tutorialView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            screenShotView.topAnchor.constraint(equalTo: tutorialView.topAnchor),
            screenShotView.leadingAnchor.constraint(equalTo: tutorialView.leadingAnchor),
            screenShotView.bottomAnchor.constraint(equalTo: tutorialView.bottomAnchor),
            screenShotView.trailingAnchor.constraint(equalTo: tutorialView.trailingAnchor)
        ])
    }
    
    /// 튜토리얼뷰 show
    /// - Parameter view: 포커스 뷰
    func showTutorial(view : UIView){
        beforeConstraint?.forEach{$0.isActive = false}
        DispatchQueue.main.async {
            self.screenShotView.image = view.screenshot()
        }
        beforeConstraint = [
            tutorialView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tutorialView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialView.widthAnchor.constraint(equalTo: view.widthAnchor,constant: 0),
            tutorialView.heightAnchor.constraint(equalTo: view.heightAnchor,constant: 0),
        ]
        NSLayoutConstraint.activate(beforeConstraint!)

        self.isHidden = false
    }
    
}

