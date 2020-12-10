//
//  SellViewController.swift
//  Krishakah
//
//  Created by RichLabs on 29/11/20.
//

import UIKit

class SellViewController: UIViewController {
    //Views
    @IBOutlet weak var legumeView:UIView!
    @IBOutlet weak var grainView:UIView!
    @IBOutlet weak var nutView:UIView!
    @IBOutlet weak var fruitView:UIView!
    @IBOutlet weak var vegetableView:UIView!
    @IBOutlet weak var oilView:UIView!
    @IBOutlet weak var spiceView:UIView!
    @IBOutlet weak var moreView:UIView!
   //Buttons
    @IBOutlet weak var nutBtn:UIButton!
    @IBOutlet weak var grainBtn:UIButton!
    @IBOutlet weak var legumeBtn:UIButton!
    @IBOutlet weak var spiceBtn:UIButton!
    @IBOutlet weak var oilBtn:UIButton!
    @IBOutlet weak var fruitBtn:UIButton!
    @IBOutlet weak var vegetableBtn:UIButton!
    @IBOutlet weak var moreBtn:UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onNutBtnTap(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SellVC") as! SellVC
        vc.sellType = "nutpost"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onGrainBtnTap(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SellVC") as! SellVC
        vc.sellType = "grainpost"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onLegumeBtnTap(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SellVC") as! SellVC
        vc.sellType = "legumepost"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onSpiceBtnTap(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SellVC") as! SellVC
        vc.sellType = "spicepost"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onOilBtnTap(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SellVC") as! SellVC
        vc.sellType = "oilpost"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onFruitBtnTap(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SellVC") as! SellVC
        vc.sellType = "fruitpost"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onVegetableBtnTap(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SellVC") as! SellVC
        vc.sellType = "vegetablepost"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onMoreBtnTap(_ sender: Any)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SellVC") as! SellVC
        vc.sellType = "extrapost"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
