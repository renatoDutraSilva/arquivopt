//
//  TimeMachineViewController.swift
//  ArquivoPT
//
//  Created by Paulo Rocha on 30/03/2019.
//  Copyright © 2019 Renato Silva. All rights reserved.
//

import UIKit
import iCarousel
import AudioToolbox

class TimeMachineViewController: UIViewController {
    
    var siteId: UUID!
    var siteCategory: Category!
    var site: ModelSite?
    
    @IBOutlet var carouselView: iCarousel!
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SiteFunctions.readSite(by: siteId, category: siteCategory) { [weak self] (modelSite) in
            guard let self = self else { return }//if self is nil then terminate the function (for example, user left this page before the function ended)
            self.site = modelSite
            
            guard let modelSite = modelSite else {return}//if model is nil then terminate the function (for example, user lost connection to the data base)
            self.title = modelSite.siteName
        }
        
        
        let LinkID = ["19991129051739", "19991129051739", "19991129051739", "19991129051739", "19991129051739", "19991129051739", "19991129051739", "19991129051739", "19991129051739", "19991129051739", "19991129051739", "19991129051739", "19991129051739", "19991129051739"]
        
        for id in LinkID{
            if let imagem = UIImage(named: id + ".png"){
                images.append(imagem)
            }
        }
        
        carouselView.type = iCarouselType.invertedTimeMachine
        carouselView.reloadData()

    }


}

extension TimeMachineViewController: iCarouselDelegate, iCarouselDataSource{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return images.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let imageView = UIImageView()
        
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        imageView.image = images[index]
        //        imageView.isHighlighted = true
        let width: CGFloat = 200
        let height: CGFloat = 200
        
        let shadowSize: CGFloat = 20
        let shadowDistance: CGFloat = 0
        let contactRect = CGRect(x: -shadowSize, y: height - (shadowSize * 0.4) + shadowDistance, width: width + shadowSize * 2, height: shadowSize)
        imageView.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOpacity = 0.4
        
        tempView.addSubview(imageView)
        
        return tempView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        AudioServicesPlaySystemSound(SystemSoundID(1105))
    }
    
    
}
