//
//  InterfaceController.swift
//  test4 WatchKit Extension
//
//  Created by Suyash Kumar on 9/28/15.
//  Copyright © 2015 Suyash Kumar. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    var index1=0
    var index2=0
    var index3=0
    var index4=0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        var pickerItems: [WKPickerItem] = []
        for i in 1...10 {
            let item = WKPickerItem()
            //item.title = ""
            item.contentImage=WKImage(imageName: "\(i).png")
            item.caption="a"
            pickerItems.append(item)
            
        }
        // Create Tolerance Picker Items
        var pickerItemsTolerance : [WKPickerItem]=[]
        var gold=WKPickerItem()
        gold.contentImage=WKImage(imageName:"gold.png")
        var silver=WKPickerItem()
        silver.contentImage=WKImage(imageName:"silve.png")
        
        pickerItemsTolerance.append(gold)
        pickerItemsTolerance.append(silver)
        self.pickerFour.setItems(pickerItemsTolerance)
        self.pickerThree.setItems(pickerItems)
        self.pickerTwo.setItems(pickerItems)
        self.pickerOne.setItems(pickerItems)
        
        // test.setImage(UIImage(contentsOfFile: "sqtest.png"))
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBOutlet var pickerFour: WKInterfacePicker!
    
    
    @IBOutlet var pickerThree: WKInterfacePicker!
    
    @IBOutlet var pickerTwo: WKInterfacePicker!
    
    @IBOutlet var pickerOne: WKInterfacePicker!
    
    
    @IBOutlet var resistorValue: WKInterfaceLabel!
    
    @IBAction func oneChanged(value: Int) {
        index1=value
        updateResistance()
    }
    
    @IBAction func twoChanged(value: Int) {
        index2=value
        updateResistance()
    }
    @IBAction func threeChanged(value: Int) {
        index3=value
        updateResistance()
    }
    
    @IBAction func fourChanged(value: Int) {
        index4=value
        updateResistance()
    }
    
    func updateResistance(){
        var valueString=""
        let resistance=CLongLong(((index1*10)+index2))*CLongLong(pow(10.0,Double(index3)))
        if (resistance/1000<1){
            valueString=valueString+String(resistance)+" Ω"
        }
        else if ((resistance/1000)<1000){
            valueString=valueString+String(Double(resistance)/1000.0)+" kΩ"
        }
        else if ((resistance/CLongLong(pow(10.0,6.0)))<1000){
            valueString=valueString+String(Double(resistance)/pow(10.0,6.0))+" MΩ"
        }
        else if ((resistance/CLongLong(pow(10.0,9.0)))<1000){
            valueString=valueString+String(Double(resistance)/pow(10.0,9.0))+" GΩ"
        }
        
        var toleranceMap : [Int:String]=[0:" ±5%",1:" ±10%"]
        
        valueString=valueString+toleranceMap[index4]!
        resistorValue.setText("Resistor Value\n"+valueString)
    }
    
}
