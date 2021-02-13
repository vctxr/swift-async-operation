//
//  RandomGIFVC.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import UIKit

class RandomGIFVC: UIViewController {

    @IBOutlet var lblLoadingMessage: UILabel!
    @IBOutlet var imgGIF: UIImageView!
    @IBOutlet var btnRandomGIF: UIButton!
    
    private let viewModel = RandomGIFVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBoxListener()
        viewModel.fetchRandomGIF()
    }
    
    @IBAction func didTapRandomGIF(_ sender: UIButton) {
        viewModel.fetchRandomGIF()
    }
    
    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
        viewModel.cancel()
    }
}

// MARK: - View Model Listener
extension RandomGIFVC {
    
    private func setupBoxListener() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            self.btnRandomGIF.isLoading(isLoading)
            self.lblLoadingMessage.isHidden = !isLoading
        }
        
        viewModel.loadingMessage.bind { [weak self] loadingMessage in
            guard let self = self else { return }
            self.lblLoadingMessage.text = loadingMessage
        }
        
        viewModel.isNeedResetGIF.bind { [weak self] isNeedResetGif in
            guard let self = self else { return }
            self.imgGIF.stopAnimating()
            self.imgGIF.animationImages = nil
            self.imgGIF.image = nil
        }
        
        viewModel.randomWord.bind { [weak self] randomWord in
            guard let self = self else { return }
            self.navigationItem.title = randomWord
        }
        
        viewModel.gifData.bind { [weak self] gifData in
            guard let self = self else { return }
            if let gifData = gifData {
                self.imgGIF.loadGIF(gifData: gifData)
            } else {
                self.imgGIF.image = UIImage(named: "no-image")
            }
        }
    }
}
