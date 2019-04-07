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
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet var carouselView: iCarousel!
    
    var images = [UIImage]()
    let selection = UISelectionFeedbackGenerator()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ThemeFunctions.applyTheme(view: view)
    }
    
    override func viewDidLoad() {
        guard let unwrappedSite = site else {return}
        super.viewDidLoad()
        updateView(with: unwrappedSite)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "favoriteIconSelected"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(toggleFavorite(_:)))
        
        navigationItem.rightBarButtonItem?.tintColor = Theme.current.accent
        
        if let LinkID = site?.linkDataID{
            for id in LinkID{
                if let imagem = UIImage(named: "gulbenkian_" + id + ".png"){
                    images.append(imagem)
                }
            }
        }
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let width: CGFloat = screenWidth * 0.1
        let height: CGFloat = screenHeight * 0.4
        
        carouselView.type = iCarouselType.invertedTimeMachine
        carouselView.reloadData()
        
//        --- carouselView Options ---
//        carouselView.perspective = -0.005
        
        print(screenHeight/screenWidth)
        carouselView.viewpointOffset = CGSize(width: width, height: 0)

    }
    // Toggle site.isFavorite
    @objc func toggleFavorite(_ sender: UIBarButtonItem) {
        self.site?.isFavorite = !self.site!.isFavorite
    }
    
    func updateView(with site: ModelSite){
        self.title = site.siteName
        self.site = site
    }
    
}

extension TimeMachineViewController: iCarouselDelegate, iCarouselDataSource{
    func numberOfItems(in carousel: iCarousel) -> Int {
        return images.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let width: CGFloat = screenWidth * 0.4
        let height: CGFloat = screenHeight * 0.4
        
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        let imageView = UIImageView()
        
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        imageView.image = images[index]
        //        imageView.isHighlighted = true
        
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
//        AudioServicesPlaySystemSound(SystemSoundID(1105))
        if carousel.currentItemIndex != -1{
            if let LinkID = site?.linkDataID[carousel.currentItemIndex]{
                let websiteDate = extractWebsiteDate(siteLinkID: LinkID)
                dayLabel.text = "dia: " + websiteDate[0]
                monthLabel.text = "mês: " + websiteDate[1]
                yearLabel.text = websiteDate[2]
            }
        }

        selection.selectionChanged()
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        
        let storyboard = UIStoryboard(name: String(describing: WebViewController.self), bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! WebViewController
        vc.siteWebName = site?.linkData[index]
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
//        <#code#>
//    }
    
    func extractWebsiteDate(siteLinkID: String) -> [String]{
        
        var result: [String]
        result = []
        
        let year = String(siteLinkID.prefix(4))
        
        let indexMonth = siteLinkID.index(siteLinkID.endIndex, offsetBy: -8)
        let month = String(String(siteLinkID[..<indexMonth]).suffix(2))
        
        let indexDay = siteLinkID.index(siteLinkID.endIndex, offsetBy: -6)
        let day = String(String(siteLinkID[..<indexDay]).suffix(2))
        
        result.append(day)
        result.append(month)
        result.append(year)
        
        return result
    }
    
}
