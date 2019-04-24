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
    
    var siteCategory: Category!
    weak var site: ModelSite?
    
    @IBOutlet weak var carouselView: iCarousel!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var noImagesLabel: UILabel!
    @IBOutlet weak var filterSetLabel: UILabel!
    @IBOutlet weak var initialFilterDateLabel: UILabel!
    @IBOutlet weak var finalFilterDateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var dateFormatter = DateFormatter()
    let impact = UIImpactFeedbackGenerator()
    let selection = UISelectionFeedbackGenerator()
    
    var images = [UIImage](){
        didSet{
            carouselView.reloadData()
            setFilterLabels()
            if images.count == 0{
                noImagesLabel.textColor = Theme.current.accent
                dateLabel.textColor = .clear
                dateButton.isHidden = true
            } else {
                dateButton.isHidden = false
                noImagesLabel.textColor = .clear
                dateLabel.textColor = Theme.current.textColor
                dateButton.isHidden = false
            }
        }
    }
    
    var validDates = [String?]()
    var validLinks = [String]()
    
    var countReused = 0
    var count = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImages()
        ThemeFunctions.applyTheme(view: view)
        checkIsFavorite()
//        navigationItem.rightBarButtonItem?.tintColor = Theme.current.textColor
        navigationItem.leftBarButtonItem?.tintColor = Theme.current.textColor
    }
    
    override func viewDidLoad() {
        guard let unwrappedSite = site else {return}
        super.viewDidLoad()
        updateView(with: unwrappedSite)
        
        loadImages()
        dateLabel.text = validDates[0]
        
        filterSetLabel.text = "Filtro Definido"
        noImagesLabel.text = "Não existem dados disponíveis"
        
        customizeButtons([dateButton])
        NotificationCenter.default.addObserver(forName: .saveSelectedDate, object: nil, queue: OperationQueue.main) { (notification) in
            let dateVC = notification.object as! PopupViewController
            let currentPage = dateVC.selectedDate
            self.carouselView.scrollToItem(at: currentPage!, animated: true)
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
        }
        
        carouselView.type = iCarouselType.invertedTimeMachine
        
//        --- carouselView Options ---
//        carouselView.perspective = -0.005
//        carouselView.viewpointOffset = CGSize(width: 0, height: 0)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
        if segue.identifier == "toPopupViewControllerSegue"{
            let popup = segue.destination as! PopupViewController
            popup.validDates = validDates
            popup.selectedDate = carouselView.currentItemIndex
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        impact.impactOccurred()
    }
    
    func setFilterLabels() {
        let format = DateFormatter()
        format.dateFormat = "dd MMM yyyy"
        format.locale = Locale(identifier: "pt")

        if !SettingsParams.filterDateHiddden{
            filterSetLabel.textColor = Theme.current.accent
            initialFilterDateLabel.text = format.string(from: SettingsParams.initialFilterDate)
            finalFilterDateLabel.text = format.string(from: SettingsParams.finalFilterDate)
            
            initialFilterDateLabel.textColor = Theme.current.textColor
            finalFilterDateLabel.textColor = Theme.current.textColor
        } else{
            filterSetLabel.textColor = .clear
            initialFilterDateLabel.textColor = .clear
            finalFilterDateLabel.textColor = .clear
        }
    }
    

    
    func loadImages(){
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        format.locale = Locale(identifier: "pt")
        
        images.removeAll()
        validDates.removeAll()
        validLinks.removeAll()
        
        if let LinkID = site?.linkDataID{
            for (index, id) in LinkID.enumerated(){

                if SettingsParams.filterDateHiddden {
                    if let imagem = UIImage(named: site!.siteFileId + "_" + id + ".png"){
                        images.append(imagem)
                        let websiteDate = extractWebsiteDate(siteLinkID: id)
                        let month = format.standaloneMonthSymbols?[Int(websiteDate[1])! - 1]
                        let fullDate = websiteDate[0] + " " + month! + " " + websiteDate[2]
                        validDates.append(fullDate)
                        if let link = site?.linkData[index]{
                            validLinks.append(link)
                        }
                    }
                } else {
                    let initialLinkdID = format.string(from: SettingsParams.initialFilterDate)
                    let finalLinkdID = format.string(from: SettingsParams.finalFilterDate)
                    if id > initialLinkdID && id < finalLinkdID{
                        if let imagem = UIImage(named: site!.siteFileId + "_" + id + ".png"){
                            images.append(imagem)
                            let websiteDate = extractWebsiteDate(siteLinkID: id)
                            let month = format.standaloneMonthSymbols?[Int(websiteDate[1])! - 1]
                            let fullDate = websiteDate[0] + " " + month! + " " + websiteDate[2]
                            validDates.append(fullDate)
                            if let link = site?.linkData[index]{
                                validLinks.append(link)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
//=================================================//
//------------------- Favorires -------------------//
//=================================================//
    
    
    // Toggle site.isFavorite
    @objc func toggleFavorite(_ sender: UIBarButtonItem) {
        
        showFavoriteAlert()
        self.site?.isFavorite = !self.site!.isFavorite

        if site!.isFavorite {
            
            GlobalData.favoriteSiteArray.append(self.site!)
            GlobalData.favoriteID.append(site!.siteFileId)
            navigationItem.rightBarButtonItem?.image = UIImage(named: "favoriteIconSelected")
            navigationItem.leftBarButtonItem?.tintColor = Theme.current.textColor
            navigationItem.rightBarButtonItem?.tintColor = Theme.current.accent
            UserDefaults.standard.set(GlobalData.favoriteID, forKey: GlobalKeys.favoriteKey)
            
        } else {
            
            GlobalData.favoriteSiteArray.removeAll(where: { (site) -> Bool in
                return site.siteName == self.site?.siteName
            })
            
            if let index = GlobalData.favoriteID.firstIndex(of: site!.siteFileId) {
                GlobalData.favoriteID.remove(at: index)
            }
            navigationItem.rightBarButtonItem?.image = UIImage(named: "favoriteIconSelected")
            navigationItem.leftBarButtonItem?.tintColor = Theme.current.textColor
            navigationItem.rightBarButtonItem?.tintColor = .lightGray
            UserDefaults.standard.set(GlobalData.favoriteID, forKey: GlobalKeys.favoriteKey)
        }
    }
    
    func checkIsFavorite(){
        
        if site!.isFavorite {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "favoriteIconSelected"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(toggleFavorite(_:)))
            navigationItem.leftBarButtonItem?.tintColor = Theme.current.textColor
            navigationItem.rightBarButtonItem?.tintColor = Theme.current.accent
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "favoriteIconSelected"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(toggleFavorite(_:)))
            navigationItem.leftBarButtonItem?.tintColor = Theme.current.textColor
            navigationItem.rightBarButtonItem?.tintColor = .lightGray
        }
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
    
    func customizeButtons(_ buttons: [UIButton]){
       
        for button in buttons {
            button.layer.backgroundColor = Theme.current.accent.cgColor
            button.layer.cornerRadius = 7
            button.titleLabel?.textColor = UIColor.white
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
            button.titleLabel?.textAlignment = .center
        }
    }
    
    func showFavoriteAlert() {
        
        let alertView = UIView()
        alertView.frame = CGRect(x: (UIScreen.main.bounds.width / 2) - 112, y: (UIScreen.main.bounds.height / 2) - 112, width: 224, height: 224)
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

//===========================================================//
//------------------------ iCarousel ------------------------//
//===========================================================//

extension TimeMachineViewController: iCarouselDelegate, iCarouselDataSource{
    
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return images.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let width: CGFloat = 0.5 * screenWidth
        let height: CGFloat = 0.2 * screenHeight
        
//        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))

        var imageView: UIImageView
        
        if let view = view as? UIImageView {
            imageView = view
            countReused += 1
            print("Reused cells:")
            print(countReused)
        }else{
            count += 1
            print("New cells:")
            print(count)
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
            imageView.contentMode = .scaleToFill
            let shadowSize: CGFloat = 20
            let shadowDistance: CGFloat = 0
            let contactRect = CGRect(x: -shadowSize, y: height - (shadowSize * 0.4) + shadowDistance, width: width + shadowSize * 2, height: shadowSize)
            imageView.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
            imageView.layer.shadowRadius = 5
            imageView.layer.shadowOpacity = 0.4
            
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha: 1).cgColor
//            imageView.layer.cornerRadius = 14
        }

        imageView.image = images[index]
        
//        tempView.addSubview(imageView)
        
        return imageView
    }
    
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
//        AudioServicesPlaySystemSound(SystemSoundID(1105))
        if carousel.currentItemIndex != -1 &&  validDates.count != 0{
            if let date = validDates[carousel.currentItemIndex]{
                dateLabel.text = date
            }
        }

        selection.selectionChanged()
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        
        let storyboard = UIStoryboard(name: String(describing: WebViewController.self), bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! WebViewController
        vc.siteWebName = validLinks[index]
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
//        switch (option) {
//        case .tilt:
//            return 10;
//        case .spacing:
//            return 1.2
//        default:
//            return value;
//        }
//    }
    
    func extractWebsiteDate(siteLinkID: String) -> [String]{
        
        var result = [String]()
        
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
