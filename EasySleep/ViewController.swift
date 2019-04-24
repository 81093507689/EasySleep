//
//  ViewController.swift
//  EasySleep
//
//  Created by developer on 30/03/19.
//  Copyright © 2019 EasySleep. All rights reserved.
//

import UIKit
import GradientSlider

protocol addNewCategoryProtocol: class {
    
    func doneDateSelected(getDate:String)
    
    
}


class ViewController: UIViewController,addNewCategoryProtocol {
   
    
    var aryData:NSArray = NSArray()
    
    
    @IBOutlet weak var basicBarChart: BasicBarChart!
    @IBOutlet weak var basicBarChart2: BasicBarChart!
    @IBOutlet weak var lbl1tab3: UILabel!
    @IBOutlet weak var lbl2tab3: UILabel!
    @IBOutlet weak var lblNoRecordFoundtab3: UILabel!
    @IBOutlet weak var lblNoRecordFoundtab2: UILabel!
    
    
    @IBOutlet weak var customColorSlider: CustomColorSlider!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblHr: UILabel!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet var circularRingSlider: SSCircularRingSlider!
    let arrValues: [Int] = [Int](0...24)
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var tbl: UITableView!
    
    var getHrValue:Int = 0
    var getQualityValue:Double = 0.0
    
    var currentselected:Int = 0
    
    //57,63,144
    let selectedColor:UIColor = UIColor(red: 57/255, green: 63/255, blue: 144/255, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl.tableFooterView = UIView()
        tbl.estimatedRowHeight = 44.0
        self.tbl.rowHeight = UITableView.automaticDimension
        
        
        self.title = "Easy Sleep"
        circularRingSlider.delegate = self
         self.setCircularRingSliderColor()

        customColorSlider.defaultValue = 0.0
        customColorSlider.actionBlock={slider,newvalue in
            
            //print("newvalue--->",newvalue)
            
            let getValue = self.getLevel(v: Double(newvalue))
            self.lblTitle.text = getValue
            self.getQualityValue = Double(newvalue)
        }
        
        
        let getToday = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let theDate = dateFormatter.string(from: getToday)
        self.btnDate.setTitle(theDate, for: .normal)
        
        UpdateTabFunction()
        
    
        
        refresh()
        
    }
    
    
    

    
    func getLevel(v:Double)->String
    {
        var setObj:String = ""
        if(v > 0 && v < 0.1)
        {
            setObj = "Very bad"
        }else if(v > 0.2 && v < 0.4)
        {
            setObj = "Bad"
        }else if(v > 0.4 && v < 0.6)
        {
            setObj = "Okay"
        }else if(v > 0.6 && v < 0.8)
        {
            setObj = "Fine"
        }else if(v > 0.8 && v < 0.9)
        {
            setObj = "Good"
        }else
        {
            setObj = "Very Good"
        }
        
        return setObj
    }
    
    func generateDataEntries() -> [BarEntry] {
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [BarEntry] = []
        for i in 0..<aryData.count {
            
            let getObje = aryData.object(at: i) as! NSDictionary
            
            let total = getObje.value(forKey: "hr") as? String ?? "0.0"
            let getDouble:Double = Double(total) ?? 0.0
            
            let getDate:String = getObje.value(forKey: "dt") as? String ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let getFinalDate = dateFormatter.date(from: getDate)
            
            var value = Int(getDouble) ?? 0
            
            if(value > 100)
            {
                value = 100
            }
            let height: Float = Float(value * 10) / 240.0
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            //var date = Date()
            // date.addTimeInterval(TimeInterval(24*60*60*i))
            result.append(BarEntry(color: colors[i % colors.count], height: height, textValue: "\(value)", title: formatter.string(from: getFinalDate!)))
        }
        return result
    }
    func generateDataEntries2() -> [BarEntry] {
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [BarEntry] = []
        for i in 0..<aryData.count {
            
            let getObje = aryData.object(at: i) as! NSDictionary
           
            let getQuality = getObje.value(forKey: "quality") as? String ?? "0.0"
            let getDouble:Double = Double(getQuality) ?? 0.0
           
            let getQualityInt:Int = Int(getDouble * 10) ?? 0
            //print("getQualityInt-",getQualityInt)
            
            
            let getDate:String = getObje.value(forKey: "dt") as? String ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let getFinalDate = dateFormatter.date(from: getDate)
            
            var value = (Int(getQualityInt) ?? 0) * 10
            //print("value-->",value)
            if(value > 100)
            {
                value = 100
            }
            let height: Float = Float(value) / 100
            //print("height-->",height)
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            //var date = Date()
            // date.addTimeInterval(TimeInterval(24*60*60*i))
            result.append(BarEntry(color: colors[i % colors.count], height: height, textValue: "\(getQualityInt)", title: formatter.string(from: getFinalDate!)))
        }
        return result
    }
    
    
    @IBAction func click_Calendar(_ sender: Any) {
        
      //  let getObje = aryData.object(at: indexPath.row) as! NSDictionary
        let mainStory : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController:HorizontalCalendarController = mainStory.instantiateViewController(withIdentifier: "HorizontalCalendarController") as! HorizontalCalendarController
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func doneDateSelected(getDate: String) {
        
        //print(getDate)
        self.btnDate.setTitle(getDate, for: .normal)
    }
    
    // MARK: - Circular slider setup
    fileprivate func setCircularRingSliderColor() {
        let indexOfValue = 0
        let titleColor = UIColor.clear//UIColor(red: 31.0/255.0, green: 0.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        let shadowColor = UIColor.black
        circularRingSlider.setValues(initialValue: arrValues[indexOfValue].toCGFloat(), minValue: arrValues[0].toCGFloat(), maxValue: arrValues[arrValues.count-1].toCGFloat())
        circularRingSlider.setCircluarRingShadow(shadowColor: shadowColor, radius: 2)
        circularRingSlider.setShadowOfAllButtons(color: shadowColor, opacity: 0.5, offset: 0, radius: 1)
        circularRingSlider.setTextLabel(labelFont: UIFont.systemFont(ofSize: 60), textColor: titleColor)
        circularRingSlider.setValueTextFieldDelegate(viewController: self)
        circularRingSlider.setArrayValues(labelValues: arrValues, currentIndex: indexOfValue)
        circularRingSlider.setCircluarRingColor(innerCirlce: UIColor.white, outerCircle: UIColor.red)
        circularRingSlider.setBackgroundColorOfAllButtons(startPointColor: UIColor.red, endPointColor: UIColor.lightGray, knobColor: UIColor.white)
        circularRingSlider.setEndPointsImage(startPointImage: UIImage(named: "iconMinusRed")!, endPointImage: UIImage(named: "iconPlusRed")!)
        circularRingSlider.setProgressLayerColor(colors: [UIColor.red.cgColor, UIColor.red.cgColor])
        circularRingSlider.setKnobOfSlider(knobSize: 60, knonbImage: UIImage(named: "iconKnobRed")!)
        circularRingSlider.setCircularRingWidth(innerRingWidth: 18, outerRingWidth: 18)
    }
    
//    @IBAction func faderValueDidChange(sender: LiveFaderView) {
//        print("\(sender) \(sender.value)")
//    }
    
    
    func refresh()
    {
        
        aryData = FMDBQueueManager.shareFMDBQueueManager.GetAllDATA()
        
        let dataEntries = generateDataEntries()
        basicBarChart.dataEntries = dataEntries
        
        let dataEntries2 = generateDataEntries2()
        
        basicBarChart2.dataEntries = dataEntries2
        
        self.tbl.reloadData()
        
        
       
        
        if(aryData.count > 0)
        {
            lbl1tab3.isHidden = false
            lbl2tab3.isHidden = false
            lblNoRecordFoundtab3.isHidden = true
            lblNoRecordFoundtab2.isHidden = true
        }else
        {
            lbl1tab3.isHidden = true
            lbl2tab3.isHidden = true
            lblNoRecordFoundtab3.isHidden = false
            lblNoRecordFoundtab2.isHidden = false
        }
        
    }
    
    @IBAction func click_Submit(_ sender: UIButton) {
        
        
       
        if(getHrValue > 0)
        {
            
            if(getQualityValue > 0)
            {
                
            let getDate:String = self.btnDate.titleLabel?.text as? String ?? ""
            
            let getData:NSMutableArray = FMDBQueueManager.shareFMDBQueueManager.CheckNOTE(getdate: getDate)
            
            if(getData.count > 0)
            {
                let otherAlert = UIAlertController(title: "OOPS!", message: "Already added for this date!", preferredStyle: UIAlertController.Style.alert)
                
                let printSomething = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                    
                }
                
                // relate actions to controllers
                otherAlert.addAction(printSomething)
                present(otherAlert, animated: true, completion: nil)
                
            }else
            {
                
                FMDBQueueManager.shareFMDBQueueManager.insertNOTE(gethr: String(getHrValue), getdate: getDate, quality: String(getQualityValue))
              
                getHrValue = 0
                getQualityValue = 0.0
                lblHr.text = "\(getHrValue)Hr"
                lblTitle.text = ""
                self.customColorSlider.defaultValue = 0.0
                self.setCircularRingSliderColor()
                
                refresh()
                
            }
                
            }else
            {
                let otherAlert = UIAlertController(title: "OOPS!", message: "Please select your bad quality", preferredStyle: UIAlertController.Style.alert)
                
                let printSomething = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                    
                }
                
                // relate actions to controllers
                otherAlert.addAction(printSomething)
                present(otherAlert, animated: true, completion: nil)
            }
            
        }else
        {
            let otherAlert = UIAlertController(title: "OOPS!", message: "Please select Hours", preferredStyle: UIAlertController.Style.alert)
            
            let printSomething = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                
            }
            
            
            otherAlert.addAction(printSomething)
            present(otherAlert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func click_Delete(_ sender: UIButton)
    {
        let getObje = aryData.object(at: sender.tag) as! NSDictionary
       
        
        let id = getObje.value(forKey: "id") as? String ?? ""
        
        
        let otherAlert = UIAlertController(title: "DELETE", message: "Are you sure want to delete ?", preferredStyle: UIAlertController.Style.alert)
        
        let printSomething = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            
            
            FMDBQueueManager.shareFMDBQueueManager.removeNote(cartid: id)
            
            self.refresh()
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { _ in
            
        }
        
        // relate actions to controllers
        otherAlert.addAction(printSomething)
        otherAlert.addAction(cancel)
        present(otherAlert, animated: true, completion: nil)
    }
    
    @IBAction func click_s(_ sender: UIButton) {
        
        currentselected = sender.tag
        UpdateTabFunction()
    }
    
    func UpdateTabFunction()
    {
        if(currentselected == 0)
        {
            
            v1.isHidden = false
            v2.isHidden = true
            v3.isHidden = true
            
            btn1.backgroundColor = selectedColor
            btn2.backgroundColor = UIColor.clear
            btn3.backgroundColor = UIColor.clear
    
        }else if(currentselected == 1)
        {
   
            v1.isHidden = true
            v2.isHidden = false
            v3.isHidden = true
            
            btn1.backgroundColor = UIColor.clear
            btn2.backgroundColor = selectedColor
            btn3.backgroundColor = UIColor.clear
            
        }else if(currentselected == 2)
        {
            currentselected = 2
            v1.isHidden = true
            v2.isHidden = true
            v3.isHidden = false
            
            btn1.backgroundColor = UIColor.clear
            btn2.backgroundColor = UIColor.clear
            btn3.backgroundColor = selectedColor
        }
    }
}



// MARK: - Circular sider delegate
extension ViewController: SSCircularRingSliderDelegate {
    
    // This function will be called after updating Circular Slider Control value
    func controlValueUpdated(value: Int) {
       // print("current control value\(value)")
        getHrValue = value
        lblHr.text = "\(getHrValue)Hr"
    }
    
}

// MARK: - Textfield delegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let str = textField.text!
        guard let number = NumberFormatter().number(from: str) else {
            return
        }
        guard let offset = circularRingSlider.getClosestElementFromArray(arrValues: arrValues, enteredValue: Int(truncating: number)) else { return }
        circularRingSlider.setCurrentIndexAndUpdate(offset)
    }
    
}











extension ViewController:UITableViewDataSource,UITableViewDelegate
{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return self.aryData.count
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as! cellDetail
            let getObje = aryData.object(at: indexPath.row) as! NSDictionary
            cell.btnDelete.tag = indexPath.row
        
            let gethrText = getObje.value(forKey: "hr") as? String ?? ""
            cell.lblTitle.text = "\(gethrText) hour(s)"
            
            let getDate:String = getObje.value(forKey: "dt") as? String ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let getFinalDate = dateFormatter.date(from: getDate)
            dateFormatter.dateFormat = "dd/MMMM/yyyy"
            let getdateINString = dateFormatter.string(from: getFinalDate!)
            
            cell.lbldate.text = getdateINString
            
        
            cell.viw.layer.borderColor = UIColor.black.cgColor
            cell.viw.layer.borderWidth = 0.1
        
             let getQuality = getObje.value(forKey: "quality") as? String ?? "0.0"
        let getDouble:Double = Double(getQuality) ?? 0.0
             let GetText = self.getLevel(v: getDouble)
             let getQualityInt:Int = Int(getDouble * 10) ?? 0
        
        cell.lblCount.text = "\(getQualityInt) out of 10   (\(GetText))"
            
            cell.selectionStyle = .none
            return cell
            
    
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
