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
    var dateFormatter = DateFormatter()
    
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
        
        
        
        if site!.isFavorite {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "favoriteIconDeselected"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(toggleFavorite(_:)))
        } else {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "favoriteIconSelected"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(toggleFavorite(_:)))
        }
        
        
        navigationItem.rightBarButtonItem?.tintColor = Theme.current.accent

        if let LinkID = site?.linkDataID{
            for id in LinkID{
                if let imagem = UIImage(named: unwrappedSite.siteFileId + "_" + id + ".png"){
                    images.append(imagem)
                }
            }
        }
        
        customizeLabels([monthLabel, dayLabel, yearLabel])
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let width: CGFloat = screenWidth * 0.1
        let height: CGFloat = screenHeight * 0.4
        
        carouselView.type = iCarouselType.invertedTimeMachine
        carouselView.reloadData()
        
//        --- carouselView Options ---
//        carouselView.perspective = -0.005
        carouselView.viewpointOffset = CGSize(width: 0, height: 0)

    }
    // Toggle site.isFavorite
    @objc func toggleFavorite(_ sender: UIBarButtonItem) {
        
        showFavoriteAlert()
        self.site?.isFavorite = !self.site!.isFavorite
        
        if site!.isFavorite {
            
            GlobalData.favoriteSiteArray.append(self.site!)
            navigationItem.rightBarButtonItem?.image = UIImage(named: "favoriteIconDeselected")
            
        } else {
            
            GlobalData.favoriteSiteArray.removeAll(where: { (site) -> Bool in
                return site.siteName == self.site?.siteName
            })
            navigationItem.rightBarButtonItem?.image = UIImage(named: "favoriteIconSelected")

        }
        
        //print(GlobalData.favoriteSiteArray)
        
    }
    
    func updateView(with site: ModelSite){
        self.title = site.siteName
        self.site = site
    }
    
    func getDayOfWeek(_ today:String) -> Int? {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = dateFormatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay - 1
    }
    
    func customizeLabels(_ labels: [UILabel]){
       
        for label in labels {
            label.layer.backgroundColor = Theme.current.accent.cgColor
            label.layer.cornerRadius = 7
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 19)
            label.textAlignment = .center
        }
    }
    
    func showFavoriteAlert() {
        
        let alertView = UIView()
        alertView.frame = CGRect(x: (self.view.bounds.width / 2) - 112, y: (self.view.bounds.width / 2) + 112, width: 224, height: 224)
        alertView.layer.cornerRadius = 14
        alertView.layer.masksToBounds = true
        alertView.addBlurEffect()
        alertView.alpha = 0
        
        let descriptionLabel = UILabel(frame: CGRect(x: 16, y: alertView.frame.height / 1.5, width: alertView.frame.width - 32
            , height: alertView.frame.height / 3))
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.text = ""
        
        var favoriteIcon = UIImageView()
        var iconWidth = 84.0
        var iconHeight = 74.0

        if site!.isFavorite {
            descriptionLabel.text = "\(site!.siteName) removido dos Favoritos"
            favoriteIcon = UIImageView(image: UIImage(named: "favoriteIconDeselected"))
            iconWidth = 95.0
            iconHeight = 73.0
        } else {
            descriptionLabel.text = "\(site!.siteName) adicionado aos Favoritos"
            favoriteIcon = UIImageView(image: UIImage(named: "favoriteIconSelected"))
        }
        
        favoriteIcon.frame = CGRect(x: (alertView.frame.width / 2) - CGFloat(iconWidth / 2), y: alertView.frame.height / 4, width: CGFloat(iconWidth), height: CGFloat(iconHeight))

        
        
        alertView.addSubview(favoriteIcon)
        alertView.addSubview(descriptionLabel)
        self.view.addSubview(alertView)

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0.2, options: [.curveEaseInOut], animations: {
            alertView.alpha = 1
        }, completion: { _ in
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 1.5, options: [.curveEaseInOut], animations: {
                alertView.alpha = 0
                
                self.view.willRemoveSubview(alertView)
                alertView.willRemoveSubview(favoriteIcon)
                alertView.willRemoveSubview(descriptionLabel)

            }, completion: { _ in
                favoriteIcon.removeFromSuperview()
                descriptionLabel.removeFromSuperview()
                alertView.removeFromSuperview()
            })
        })
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
                //dayLabel.text = "dia: " + websiteDate[0]
                ////dateFormatter.weekdaySymbols?[Int(websiteDate[0]) ?? 1]
                let fullDate = websiteDate[2]+"/"+websiteDate[1]+"/"+websiteDate[0]
                dayLabel.text = ((dateFormatter.shortStandaloneWeekdaySymbols?[ getDayOfWeek(fullDate) ?? 0]) ?? "N/A") + ", " + websiteDate[0]

                print("\(websiteDate[2]+"/"+websiteDate[1]+"/"+websiteDate[0])")
                monthLabel.text = dateFormatter.standaloneMonthSymbols?[Int(websiteDate[1])! - 1]
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
    
    func extractWebsiteDate(siteLinkID: String) -> [String]{
        
        var result = [String]()
        //result = []
        
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
