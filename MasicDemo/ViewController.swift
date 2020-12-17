//
//  ViewController.swift
//  MasicDemo
//
//  Created by Ming on 2020/12/17.
//

import UIKit

class MosaicView: UIView {
    let strokePath = UIBezierPath()
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let maskLayer : CAShapeLayer = {
        let maskLayer = CAShapeLayer()
        maskLayer.lineWidth = 20.0
        maskLayer.strokeColor = UIColor.black.cgColor
        maskLayer.fillColor = UIColor.clear.cgColor
        return maskLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.layer.mask = maskLayer
        maskLayer.path = strokePath.cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
        maskLayer.frame = self.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let point = touches.first?.location(in: self)
        strokePath.move(to: point!)
        maskLayer.path = strokePath.cgPath
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let point = touches.first?.location(in: self)
        strokePath.addLine(to: point!)
        maskLayer.path = strokePath.cgPath
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        let point = touches.first?.location(in: self)
        strokePath.addLine(to: point!)
        maskLayer.path = strokePath.cgPath
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        let point = touches.first?.location(in: self)
        strokePath.addLine(to: point!)
        maskLayer.path = strokePath.cgPath
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let image = UIImage(named: "kui_shou")
        let imageView = UIImageView(image: image)
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFit
        
        let ciImage = CIImage(image: image!)
        let filter = CIFilter(name: "CIPixellate")
        filter?.setDefaults()
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        let mosaicImage = filter?.outputImage
        let mosaicView = MosaicView()
        mosaicView.frame = view.bounds
        mosaicView.imageView.image = UIImage(ciImage: mosaicImage!)
        
        view.addSubview(imageView)
        view.addSubview(mosaicView)
    }
}

