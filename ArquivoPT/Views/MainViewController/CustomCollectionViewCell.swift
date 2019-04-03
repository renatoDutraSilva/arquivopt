//
//  CustomCollectionViewCell.swift
//  ArquivoPT
//
//  Created by Renato Silva on 3/27/19.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit

protocol CategoryRowDelegate: class {
    func cellTapped(site: ModelSite)
}

protocol CustomCollectionViewCellDelegate: class {
    func chicletButtonTapped(site: ModelSite)
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    let siteLogo = UIImage(contentsOfFile: "dnLogo.png")
    
    var chicletButton = UIButton()
    var delegate: CustomCollectionViewCellDelegate?
    
    var site: ModelSite? = nil
    
    let siteNameLabel = UILabel()

    /* Ao desativar a propriedade "Delay Content Touch" no storyboard ou definindo em código como "false", a
     chiclet responde muito mais rapido e de forma natural.
     Contudo, com esta propriedade em False, nao é possivel iniciar o scroll a partir de uma célula pois o primeiro trigger de animação
     é sempre o cell "resize"
     Para já, a propriedade ficou ativa
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        generateChiclet()
        chicletButton.startAnimatingPressActions()
    }
    
    func generateChiclet(){
    
        chicletButton.setImage(UIImage(contentsOfFile: site?.siteLogo ?? "dnLogo.png"), for: .normal)
        chicletButton.frame = CGRect(x: 0, y: 0, width: self.frame.width + 32, height: self.frame.height + 32)
        chicletButton.titleLabel!.text = site?.siteName
        chicletButton.tintColor = UIColor.white
        chicletButton.backgroundColor = UIColor.black
        
        chicletButton.addTarget(self, action: #selector(chicletButtonTouchUpInside), for: [.touchUpInside])
        
        chicletButton.addShadowAndRoundedCorners()
        self.addSubview(chicletButton)

    }
    
    @IBAction func chicletButtonTouchUpInside(_ sender: UIButton) {
        
        guard let unwrappedSite = self.site else {return}
        print("Got past guard")
        delegate?.chicletButtonTapped(site: unwrappedSite)
    }
}

extension UIButton {
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.90, y: 0.90))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
        }, completion: nil)
    }
    
}
