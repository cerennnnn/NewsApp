//
//  DetailLinkViewController.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import UIKit
import WebKit

class DetailLinkViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = urlString else { return }
        guard let secureURL = URL(string: urlString) else { return }
        webView.load(URLRequest(url: secureURL))
    }
}
