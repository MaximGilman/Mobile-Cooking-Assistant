//
//  ChangePortionsViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 12/18/21.
//

import UIKit
import SnapKit

final class ChangePortionsViewController: UIViewController {

    @IBOutlet private var portionsContainerView: UIView!
    
    private let delegate: RecipePortionsViewDelegate
    
    init(delegate: RecipePortionsViewDelegate) {
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPortionsView()
    }
    
    private func setupPortionsView() {
        let portionsView = RecipePortionsView.make(delegate: delegate)
        portionsContainerView.addSubview(portionsView)
        portionsView.snp.makeConstraints { make in
            make.top.equalTo(portionsContainerView.snp.top)
            make.bottom.equalTo(portionsContainerView.snp.bottom)
            make.leading.equalTo(portionsContainerView.snp.leading)
            make.trailing.equalTo(portionsContainerView.snp.trailing)
        }
    }

    @IBAction func didTapOkButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
