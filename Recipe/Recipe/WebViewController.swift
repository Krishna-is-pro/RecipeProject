//
//  WebViewController.swift
//  Recipe
//
//  Created by friend on 25/06/24.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

    @IBOutlet weak var recipeWebView: WKWebView!
    private let url  : URL = URL(string: "https://www.youtube.com/@RecipeoftheWorld")!
    override func viewDidLoad() {
        super.viewDidLoad()
        let preference = WKWebpagePreferences()
        preference.preferredContentMode = .mobile
        preference.allowsContentJavaScript = true
        let configuration  = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preference
        recipeWebView.load(URLRequest(url: url))
        recipeWebView.goBack()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
