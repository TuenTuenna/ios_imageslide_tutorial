//
//  ViewController.swift
//  imageslideshow_tutorial_
//
//  Created by Jeff Jeong on 2020/10/01.
//

import UIKit
import ImageSlideshow

class ViewController: UIViewController {

    @IBOutlet var myImageSlide : ImageSlideshow!
    
    let imageResources = [
        // 만약 로컬 이미지가 있다면
//        ImageSource(image: UIImage(named: "myImage"))!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1601408594761-e94d31023591?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1593642702909-dec73df255d7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1593642532973-d31b6557fa68?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1601293058843-f34e8dd9ccfd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!,
        KingfisherSource(urlString: "https://images.unsplash.com/photo-1601351581610-7bc02ab3b914?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60", placeholder: UIImage(systemName: "photo")?.withTintColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), renderingMode: .alwaysOriginal), options: .none)!
    ]
    
    // 이미지 슬라이드쇼
    let mySecondSlideShow : ImageSlideshow = {
        let slideShow = ImageSlideshow()
        slideShow.isUserInteractionEnabled = true
        slideShow.slideshowInterval = 2.5
        slideShow.contentScaleMode = .scaleAspectFill
        slideShow.translatesAutoresizingMaskIntoConstraints = false
        return slideShow
    }()
    
    // 라벨 배경 뷰
    let labelBgView : UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4416045368, green: 0.4416045368, blue: 0.4416045368, alpha: 0.4092465753)
//        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 디테일 화면 라벨
    let myLabelIndicator : UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "asdfasdf"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 뷰가 로드될때
    override func loadView() {
        super.loadView()
        print("ViewController - loadView() called")
        let labelPageIndicator = LabelPageIndicator() // 2/10
        labelPageIndicator.textColor = .white
        mySecondSlideShow.pageIndicator = labelPageIndicator
        mySecondSlideShow.setImageInputs(imageResources)

        self.view.addSubview(mySecondSlideShow)
        
//        mySecondSlideShow.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        NSLayoutConstraint.activate([
            mySecondSlideShow.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mySecondSlideShow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mySecondSlideShow.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mySecondSlideShow.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        mySecondSlideShow.addSubview(labelBgView)
        NSLayoutConstraint.activate([
            labelBgView.centerXAnchor.constraint(equalTo: labelPageIndicator.centerXAnchor),
            labelBgView.centerYAnchor.constraint(equalTo: labelPageIndicator.centerYAnchor),
            labelBgView.widthAnchor.constraint(equalTo: labelPageIndicator.widthAnchor, multiplier: 1.2),
            labelBgView.heightAnchor.constraint(equalTo: labelPageIndicator.heightAnchor, multiplier: 1.2)
        ])
        
        mySecondSlideShow.bringSubviewToFront(labelPageIndicator)
        
        print("UIDevice.current.hasNotch: \(UIDevice.current.hasNotch)")
        
        mySecondSlideShow.pageIndicatorPosition = .init(horizontal: .right(padding: 20), vertical: .customBottom(padding: UIDevice.current.hasNotch == true ? -10 : 20))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        mySecondSlideShow.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myImageSlide.setImageInputs(imageResources)
        myImageSlide.contentScaleMode = .scaleAspectFill
        myImageSlide.slideshowInterval = 1
        myImageSlide.pageIndicatorPosition = .init(horizontal: .left(padding: 10), vertical: .bottom)
    }

    @objc func didTap(sender: UITapGestureRecognizer? = nil){
        print("ViewController - didTap() called")
        let fullScreenController = mySecondSlideShow.presentFullScreenController(from: self, completion: nil)
        fullScreenController.slideshow.pageIndicator = LabelPageIndicator()
        
        fullScreenController.view.addSubview(myLabelIndicator)
        
        myLabelIndicator.topAnchor.constraint(equalTo: fullScreenController.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        myLabelIndicator.centerXAnchor.constraint(equalTo: fullScreenController.view.centerXAnchor).isActive = true
        let currentPageString = String(fullScreenController.slideshow.currentPage + 1)
        myLabelIndicator.text = currentPageString + " / \(fullScreenController.slideshow.images.count)"
        
        fullScreenController.slideshow.delegate = self
    }
    
}

// 이미지 슬라이드쇼 델리겟 메소드 익스텐션
extension ViewController: ImageSlideshowDelegate {
    
    // 이미지 페이지가 변경되었을때
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("ViewController - didChangeCurrentPageTo() called - page: \(page)")
        // 라벨의 텍스트를 변경
        myLabelIndicator.text = String(page + 1) + " / " + String(imageSlideshow.images.count)
    }
}

// 현재 장치
extension UIDevice {
    // 노치 여부 확인
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            if UIApplication.shared.windows.count == 0 { return false }
            let top = UIApplication.shared.windows[0].safeAreaInsets.top
            return top > 20
        } else {
            return false
        }
    }
}
