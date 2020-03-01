//
//  LegendViewController.swift
//  testing-annotation
//
//  Created by Luke Son on 2020-01-12.
//  Copyright © 2020 Luke Son. All rights reserved.
//

import UIKit

class LegendViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
