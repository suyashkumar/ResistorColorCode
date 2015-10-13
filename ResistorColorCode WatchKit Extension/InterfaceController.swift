//
//  InterfaceController.swift
//  ResistorColorCode WatchKit Extension
//
//  Created by Suyash Kumar on 9/28/15.
//  Copyright © 2015 Suyash Kumar. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    var index1=0 // Holds the current selection of band 1
    var index2=0 // Holds the current selection of band 2
    var index3=0 // Holds the current selection of band 3
    var index4=0 // Holds the current selection of band 4
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var pickerItems: [WKPickerItem] = [] // Will hold the selectable band colors
        // Create colored band items and add to pickerItems
        for i in 1...10 {
            let band = WKPickerItem()
            band.contentImage=WKImage(imageName: "\(i).png") // Grab current band color image
            pickerItems.append(band) // Add current band item to pickerItems
        }
        
        // Create the picker items for tolerance selection
        var pickerItemsTolerance : [WKPickerItem]=[]
        var gold=WKPickerItem()
        gold.contentImage=WKImage(imageName:"gold.png")
        var silver=WKPickerItem()
        silver.contentImage=WKImage(imageName:"silve.png")
        pickerItemsTolerance.append(gold)
        pickerItemsTolerance.append(silver)
        
        // Add colored band item sets to the pickers:
        self.pickerOne.setItems(pickerItems)
        self.pickerTwo.setItems(pickerItems)
        self.pickerThree.setItems(pickerItems)
        self.pickerFour.setItems(pickerItemsTolerance)

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
        /*
            This function is called whenever a band picker is touched. It recalculates the resistance value
            based on the current positions of all band selectors and then updates the resistorValue label
            in the UI to reflect the updated value.
        */
        var valueString="" // This will hold the final resistance value (and tolerance) to write to the UI
        let resistance=CLongLong(((index1*10)+index2))*CLongLong(pow(10.0,Double(index3))) // Calculate the resistance
        
        // Now check the size of the calculated resistance to determine the correct SI prefix to apply when printing to screen (e.g. kΩ):
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
        
        var toleranceMap : [Int:String]=[0:" ±5%",1:" ±10%"] // Maps pickerFour indices to tolerance strings
        
        valueString=valueString+toleranceMap[index4]! // Add the proper tolerance string to valueString
        resistorValue.setText("Resistor Value\n"+valueString) // Set the resistorValue WKInterfaceLabel with updated value. 
    }
    
}
