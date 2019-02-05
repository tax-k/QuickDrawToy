//
//  ViewController.swift
//  QuickDrawToy
//
//  Created by tax_k on 02/02/2019.
//  Copyright © 2019 tax_k. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let canvas = Canvas()
    
    override func loadView() {
        self.view = canvas
    }
    
    let undoButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleUndo), for: .touchUpInside)
        
        return button
    }()
    
    let clearButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleUndo(){
        canvas.undo()
    }
    
    @objc fileprivate func handleClear(){
        canvas.clear()
    }
    
    let yellowButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        
        return button
    }()
    
    let redButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let blueButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    let slider:UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleWidthChange), for: .valueChanged)
        
        
        return slider
    }()
    
    @objc fileprivate func handleColorChange(button:UIButton){
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
    }
    
    @objc fileprivate func handleWidthChange(slider:UISlider){
        canvas.setStrokeWidth(width: slider.value)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        canvas.backgroundColor = .white
        setupBtnLayout()
    }
    
    
    fileprivate func setupBtnLayout() {
        
        let colorStackView = UIStackView(arrangedSubviews: [yellowButton, redButton, blueButton])
        colorStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [undoButton, clearButton, colorStackView, slider])
        
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
}

