//
//  DialogController.swift
//  LaBeouf
//
//  Created by Sergey Levkachev on 01/05/2018.
//  Copyright © 2018 Sergey Levkachev. All rights reserved.
//

import UIKit

class DialogController: UIViewController {
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var videoContainer: UIView!
    
    @IBOutlet var buttons: [CustomButton]!
    
    var fromSecond: Double = 0
    
    weak var delegate: ModalHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedVideo()
        setupButtons()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        dismiss()
    }
    
    private func dismiss() {
        delegate?.modalWillDismissing()
        dismiss(animated: true, completion: nil)
    }
    
    private func setupButtons() {
        buttons.forEach {
            $0.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        }
    }
    
    @objc private func tapped(button: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.dismiss()
        }
    }
    
    private func embedVideo() {
        let vc = StoryboardControllerFactory()
            .createVideoController(startSecond: fromSecond, isMuted: true)
        embed(viewController: vc, in: videoContainer)
    }
}
