//
//  ViewController.swift
//  NasaApi
//
//  Created by macbook on 17.02.2021.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var tablleView: UITableView!
    
    
    @IBOutlet weak var roverField: UITextField!
    @IBOutlet weak var cameraField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
   
    
    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
   
    private var rover = "curiosity"
    private var camera = "FHAZ"
    private var date = "2019-01-01"
     var url:String?
    
    private var refreshController:UIRefreshControl?
    
    var dataPicker:UIPickerView?
    var cameraPicker:UIPickerView?
    var datePicker: UIDatePicker?
    
    let cameraImage = UIImage(named: "icons")
    let detailImage = UIImage(named: "detail")
    let calendarImage = UIImage(named: "calendar")
    
    private let rollerArr = ["Curiosity","Opportunity","Spirit"]
    
    private var chosenPickerVariable: choosenPicker? {
            if self.roverField.isEditing {
                cameraLabel.text = ""
                dateLabel.text = ""
                return .rower }
            else if self.cameraField.isEditing {
                
                return  .camera }
            else {
                
                return .date }
        }
    
    private var dataSource = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tablleView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tablleView.estimatedRowHeight = 70
        
        dataPicker = UIPickerView()
        dataPicker?.sizeToFit()
        dataPicker?.delegate = self
        dataPicker?.dataSource = self
       
        roverField.layer.borderColor = UIColor.red.cgColor
        roverField.layer.borderWidth = 1
        roverField.layer.cornerRadius = 5
        roverField.inputView = dataPicker
        
        addRightImageTo(txtField: roverField, andImage: detailImage!)
        
       
        
        
        
        cameraPicker = UIPickerView()
        cameraPicker?.sizeToFit()
        cameraPicker?.dataSource = self
        cameraPicker?.delegate = self
        cameraField.layer.borderColor = UIColor.red.cgColor
        cameraField.layer.borderWidth = 1
        cameraField.layer.cornerRadius = 5
        cameraField.inputView = cameraPicker
        cameraField.isUserInteractionEnabled = false
        
        
        
        addRightImageTo(txtField: cameraField, andImage: cameraImage!)
        
        
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.preferredDatePickerStyle = .wheels
        datePicker?.setDate(Date(), animated: true)
        datePicker?.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        dateField.layer.borderColor = UIColor.red.cgColor
        dateField.layer.borderWidth = 1
        dateField.layer.cornerRadius = 5
        dateField.inputView = datePicker
        dateField.isUserInteractionEnabled = false
        
        addRightImageTo(txtField: dateField, andImage: calendarImage!)
        
        
        refreshController = UIRefreshControl()
       refreshController?.addTarget(self, action: #selector(getAllData), for: .valueChanged)
       
        tablleView.refreshControl = self.refreshController
        
      
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonTapped))
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action:  #selector(saveDate))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([cancelButton, space, saveButton], animated: false)
        
        
        let cameraToolBar = UIToolbar()
        cameraToolBar.sizeToFit()
        let cameraSaveButoon = UIBarButtonItem(title: "Save", style: .done, target: self, action:  #selector(saveCameraDate))
        cameraToolBar.setItems([cancelButton, space, cameraSaveButoon], animated: false)
        
        
        
        let dateToolBar = UIToolbar()
        dateToolBar.sizeToFit()
        let dateCancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dateCancelButtonTapped))
        let dateSaveButton =  UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(dateSaveDate))
        dateToolBar.setItems([dateCancelButton, space, dateSaveButton], animated: false)
        
        
        
        cameraField.inputAccessoryView = cameraToolBar
        roverField.inputAccessoryView = toolbar
        dateField.inputAccessoryView = dateToolBar
        

        refreshController?.beginRefreshing()
        
        
            self.getAllData()
    }
    
    
    
    func addRightImageTo(txtField: UITextField, andImage img: UIImage) {
            let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 30, height: 30))
            leftImageView.image = img
            txtField.rightView = leftImageView
            txtField.rightViewMode = .always
        }

    
    
    @objc private func saveDate() {
        if roverLabel.text != nil {
            cameraField.isUserInteractionEnabled = true
            dateField.isUserInteractionEnabled = true
        }
        self.roverField.resignFirstResponder()
        
    }
    
    
    
  
    
    
    @objc private func cancelButtonTapped() {
        self.roverField.resignFirstResponder()
        self.cameraField.resignFirstResponder()
    }
    
    
    @objc private func dateChanged(_ sender: UIDatePicker?) {
        guard let date = sender?.date else {return}
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        dateLabel.text  = formatter1.string(from: date)
        }
    
    @objc private func saveCameraDate() {
        
        if dateLabel.text != nil {
            rover = roverLabel.text ?? ""
            camera = cameraLabel.text ?? ""
            self.date = dateLabel.text ?? ""
            getAllData()
            cameraField.resignFirstResponder()
        }else{
            
            cameraField.resignFirstResponder()
        }
    
        
    }
    
    
    
    @objc private func dateSaveDate() {
        guard let date = datePicker?.date else {return}
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd"
        dateLabel.text  = formatter1.string(from: date)
        if cameraLabel.text != nil {
            rover = roverLabel.text ?? ""
            camera = cameraLabel.text ?? ""
            self.date = dateLabel.text ?? ""
            getAllData()
            dateField.resignFirstResponder()
        }
        dateField.resignFirstResponder()
    }
    
    @objc private func dateCancelButtonTapped() {
        dateLabel.text = " "
        dateField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewRepController{
            vc.fvc = self
        }
    }
    
    
    
    
    
    
    @objc private func getAllData(){
        ReposisotiryObject.performRequest(rover: rover, camera: camera, date: date, url:url) { [weak self] (isSucces, response) in
            guard let self  = self else {return}
            if isSucces{
                self.dataSource = response
                print(response)
                DispatchQueue.main.async {
                    self.tablleView.reloadData()
                    self.refreshController?.endRefreshing()
                }
                
            }
            
        }
        
    }
        
    
    
    
    

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch chosenPickerVariable {
        case .rower:
           return rollerArr.count
        case .camera:
            switch self.roverLabel.text {
            case "Curiosity":
                return  InfoPicker.setValue(raw: "Curiosity").count
            case "Opportunity":
                return InfoPicker.setValue(raw: "Opportunity").count
            case  "Spirit":
                return InfoPicker.setValue(raw: "Spirit").count
            default:
                return 0
            }

        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch chosenPickerVariable {
        case .rower:
            return rollerArr[row]
        case .camera:
            switch self.roverLabel.text {
            case "Curiosity": return InfoPicker.setValue(raw: "Curiosity")[row]
            case "Opportunity": return InfoPicker.setValue(raw: "Opportunity")[row]
            case  "Spirit": return InfoPicker.setValue(raw: "Spirit")[row]
            default:
                 print("error")
            }
        default:
            print("error")
        }
        return "error"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch chosenPickerVariable {
        case .rower:
            self.roverLabel.text = rollerArr[row]
        case .camera:
            switch self.roverLabel.text {
            case "Curiosity":
                self.cameraLabel.text =  InfoPicker.setValue(raw: "Curiosity")[row]
            case "Opportunity":
                self.cameraLabel.text  = InfoPicker.setValue(raw: "Opportunity")[row]
            case  "Spirit":
                self.cameraLabel.text = InfoPicker.setValue(raw: "Spirit")[row]
            default:
                print("error")
            }
        default:
               print("error")
        }
    }
}


extension ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
                        
        cell.setRepositoryModel(with: dataSource[indexPath.row])
        //dataSource[indexPath.row].putObjectToUserDefaults()
        return cell
           }
           
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
               return 150
        
           }
    
}





