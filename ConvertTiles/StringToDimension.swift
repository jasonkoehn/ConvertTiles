//
//  StringToDimension.swift
//  ConvertTiles
//
//  Created by Jason Koehn on 2/15/23.
//

import Foundation

func StringToDimension(unit: String) -> Dimension {
    var unitName: Dimension
    switch unit {
        
        //UnitAcceleration
    case "Meters Per Second Squared":
        unitName = UnitAcceleration.metersPerSecondSquared
    case "Gravity":
        unitName = UnitAcceleration.gravity
        
        //UnitAngle
    case "Degrees":
        unitName = UnitAngle.degrees
    case "Arc Minutes":
        unitName = UnitAngle.arcMinutes
    case "Arc Seconds":
        unitName = UnitAngle.arcSeconds
    case "Radians":
        unitName = UnitAngle.radians
    case "Gradians":
        unitName = UnitAngle.gradians
    case "Revolutions":
        unitName = UnitAngle.revolutions
        
        //UnitArea
    case "Square Megameters":
        unitName = UnitArea.squareMegameters
    case "Square Kilometers":
        unitName = UnitArea.squareKilometers
    case "Square Meters":
        unitName = UnitArea.squareMeters
    case "Square Centimeters":
        unitName = UnitArea.squareCentimeters
    case "Square Millimeters":
        unitName = UnitArea.squareMillimeters
    case "Square Micrometers":
        unitName = UnitArea.squareMicrometers
    case "Square Nanometers":
        unitName = UnitArea.squareNanometers
    case "Square Inches":
        unitName = UnitArea.squareInches
    case "Square Feet":
        unitName = UnitArea.squareFeet
    case "Square Yards":
        unitName = UnitArea.squareYards
    case "Square Miles":
        unitName = UnitArea.squareMiles
    case "Acres":
        unitName = UnitArea.acres
    case "Ares":
        unitName = UnitArea.ares
    case "Hectares":
        unitName = UnitArea.hectares
        
        //UnitConcentrationMass
    case "Grams Per Liter":
        unitName = UnitConcentrationMass.gramsPerLiter
    case "Milligrams Per Deciliter":
        unitName = UnitConcentrationMass.milligramsPerDeciliter
        
        //UnitDuration
    case "Seconds":
        unitName = UnitDuration.seconds
    case "Minutes":
        unitName = UnitDuration.minutes
    case "Hours":
        unitName = UnitDuration.hours
        
        //UnitElectricCharge
    case "Coulombs":
        unitName = UnitElectricCharge.coulombs
    case "Megaampere Hours":
        unitName = UnitElectricCharge.megaampereHours
    case "Kiloampere Hours":
        unitName = UnitElectricCharge.kiloampereHours
    case "Ampere Hours":
        unitName = UnitElectricCharge.ampereHours
    case "Milliampere Hours":
        unitName = UnitElectricCharge.milliampereHours
    case "Microampere Hours":
        unitName = UnitElectricCharge.microampereHours
        
        //UnitElectricCurrent
    case "Megaamperes":
        unitName = UnitElectricCurrent.megaamperes
    case "Kiloamperes":
        unitName = UnitElectricCurrent.kiloamperes
    case "Amperes":
        unitName = UnitElectricCurrent.amperes
    case "Milliamperes":
        unitName = UnitElectricCurrent.milliamperes
    case "Microamperes":
        unitName = UnitElectricCurrent.microamperes
        
        //UnitElectricPotentialDifference
    case "Megavolts":
        unitName = UnitElectricPotentialDifference.megavolts
    case "Kilovolts":
        unitName = UnitElectricPotentialDifference.kilovolts
    case "Volts":
        unitName = UnitElectricPotentialDifference.volts
    case "Millivolts":
        unitName = UnitElectricPotentialDifference.millivolts
    case "Microvolts":
        unitName = UnitElectricPotentialDifference.microvolts
        
        //UnitElectricResistance
    case "Megaohms":
        unitName = UnitElectricResistance.megaohms
    case "Kiloohms":
        unitName = UnitElectricResistance.kiloohms
    case "Ohms":
        unitName = UnitElectricResistance.ohms
    case "Milliohms":
        unitName = UnitElectricResistance.milliohms
    case "Microohms":
        unitName = UnitElectricResistance.microohms
        
        //UnitEnergy
    case "Kilojoules":
        unitName = UnitEnergy.kilojoules
    case "Joules":
        unitName = UnitEnergy.joules
    case "Kilocalories":
        unitName = UnitEnergy.kilocalories
    case "Calories":
        unitName = UnitEnergy.calories
    case "Kilowatt Hours":
        unitName = UnitEnergy.kilowattHours
        
        //UnitFrequency
    case "Terahertz":
        unitName = UnitFrequency.terahertz
    case "Gigahertz":
        unitName = UnitFrequency.gigahertz
    case "Megahertz":
        unitName = UnitFrequency.megahertz
    case "Kilohertz":
        unitName = UnitFrequency.kilohertz
    case "Hertz":
        unitName = UnitFrequency.hertz
    case "Millihertz":
        unitName = UnitFrequency.millihertz
    case "Microhertz":
        unitName = UnitFrequency.microhertz
    case "Nanohertz":
        unitName = UnitFrequency.nanohertz
        
        //UnitFuelEfficiency
    case "Liters Per 100 Kilometers":
        unitName = UnitFuelEfficiency.litersPer100Kilometers
    case "Miles Per Gallon":
        unitName = UnitFuelEfficiency.milesPerGallon
    case "Miles Per Imperial Gallon":
        unitName = UnitFuelEfficiency.milesPerImperialGallon
        
        //UnitInformationStorage
    case "Bits":
        unitName = UnitInformationStorage.bits
    case "Kilobits":
        unitName = UnitInformationStorage.kilobits
    case "Megabits":
        unitName = UnitInformationStorage.megabits
    case "Gigabits":
        unitName = UnitInformationStorage.gigabits
    case "Terabits":
        unitName = UnitInformationStorage.terabits
    case "Petabits":
        unitName = UnitInformationStorage.petabits
    case "Exabits":
        unitName = UnitInformationStorage.exabits
    case "Zettabits":
        unitName = UnitInformationStorage.zettabits
    case "Yottabits":
        unitName = UnitInformationStorage.yottabits
    case "Bytes":
        unitName = UnitInformationStorage.bytes
    case "Kilobytes":
        unitName = UnitInformationStorage.kilobytes
    case "Megabytes":
        unitName = UnitInformationStorage.megabytes
    case "Gigabytes":
        unitName = UnitInformationStorage.gigabytes
    case "Terabytes":
        unitName = UnitInformationStorage.terabytes
    case "Petabytes":
        unitName = UnitInformationStorage.petabytes
    case "Exabytes":
        unitName = UnitInformationStorage.exabytes
    case "Zettabytes":
        unitName = UnitInformationStorage.zettabytes
    case "Yottabytes":
        unitName = UnitInformationStorage.yottabytes
        
        //UnitLength
    case "Megameters":
        unitName = UnitLength.megameters
    case "Kilometers":
        unitName = UnitLength.kilometers
    case "Hectometers":
        unitName = UnitLength.hectometers
    case "Decameters":
        unitName = UnitLength.decameters
    case "Meters":
        unitName = UnitLength.meters
    case "Decimeters":
        unitName = UnitLength.decameters
    case "Centimeters":
        unitName = UnitLength.centimeters
    case "Millimeters":
        unitName = UnitLength.millimeters
    case "Micrometers":
        unitName = UnitLength.micrometers
    case "Nanometers":
        unitName = UnitLength.nanometers
    case "Picometers":
        unitName = UnitLength.picometers
    case "Inches":
        unitName = UnitLength.inches
    case "Feet":
        unitName = UnitLength.feet
    case "Yards":
        unitName = UnitLength.yards
    case "Miles":
        unitName = UnitLength.miles
    case "Scandinavian Miles":
        unitName = UnitLength.scandinavianMiles
    case "Light Years":
        unitName = UnitLength.lightyears
    case "Nautical Miles":
        unitName = UnitLength.nauticalMiles
    case "Fathoms":
        unitName = UnitLength.fathoms
    case "Furlongs":
        unitName = UnitLength.furlongs
    case "Astronomical Units":
        unitName = UnitLength.astronomicalUnits
    case "Parsecs":
        unitName = UnitLength.parsecs
        
        //UnitMass
    case "Kilograms":
        unitName = UnitMass.kilograms
    case "Grams":
        unitName = UnitMass.grams
    case "Decigrams":
        unitName = UnitMass.decigrams
    case "Centigrams":
        unitName = UnitMass.centigrams
    case "Milligrams":
        unitName = UnitMass.milligrams
    case "Micrograms":
        unitName = UnitMass.micrograms
    case "Nanograms":
        unitName = UnitMass.nanograms
    case "Picograms":
        unitName = UnitMass.picograms
    case "Ounces":
        unitName = UnitMass.ounces
    case "Pounds":
        unitName = UnitMass.pounds
    case "Stones":
        unitName = UnitMass.stones
    case "MetricTons":
        unitName = UnitMass.metricTons
    case "ShortTons":
        unitName = UnitMass.shortTons
    case "Carats":
        unitName = UnitMass.carats
    case "OuncesTroy":
        unitName = UnitMass.ouncesTroy
    case "Slugs":
        unitName = UnitMass.slugs
        
        //UnitPower
    case "Terawatts":
        unitName = UnitPower.terawatts
    case "Gigawatts":
        unitName = UnitPower.gigawatts
    case "Megawatts":
        unitName = UnitPower.megawatts
    case "Kilowatts":
        unitName = UnitPower.kilowatts
    case "Watts":
        unitName = UnitPower.watts
    case "Milliwatts":
        unitName = UnitPower.milliwatts
    case "Microwatts":
        unitName = UnitPower.microwatts
    case "Nanowatts":
        unitName = UnitPower.nanowatts
    case "Picowatts":
        unitName = UnitPower.picowatts
    case "Femtowatts":
        unitName = UnitPower.femtowatts
    case "Horsepower":
        unitName = UnitPower.horsepower
        
        //UnitPressure
    case "Newtons Per Meter Squared":
        unitName = UnitPressure.newtonsPerMetersSquared
    case "Gigapascals":
        unitName = UnitPressure.gigapascals
    case "Megapascals":
        unitName = UnitPressure.megapascals
    case "Kilopascals":
        unitName = UnitPressure.kilopascals
    case "Hectopascals":
        unitName = UnitPressure.hectopascals
    case "Inches of Mercury":
        unitName = UnitPressure.inchesOfMercury
    case "Bars":
        unitName = UnitPressure.bars
    case "Millibars":
        unitName = UnitPressure.millibars
    case "Millimeters of Mercury":
        unitName = UnitPressure.millimetersOfMercury
    case "Pounds Per Square Inch":
        unitName = UnitPressure.poundsForcePerSquareInch
        
        //UnitSpeed
    case "Meters Per Second":
        unitName = UnitSpeed.metersPerSecond
    case "Kilometers Per Hour":
        unitName = UnitSpeed.kilometersPerHour
    case "Miles Per Hour":
        unitName = UnitSpeed.milesPerHour
    case "Knots":
        unitName = UnitSpeed.knots
        
        //UnitTemperature
    case "Kelvin":
        unitName = UnitTemperature.kelvin
    case "Celsius":
        unitName = UnitTemperature.celsius
    case "Fahrenheit":
        unitName = UnitTemperature.fahrenheit
        
        //UnitVolume
    case "Megaliters":
        unitName = UnitVolume.megaliters
    case "Kiloliters":
        unitName = UnitVolume.kiloliters
    case "Liters":
        unitName = UnitVolume.liters
    case "Deciliters":
        unitName = UnitVolume.deciliters
    case "Centiliters":
        unitName = UnitVolume.centiliters
    case "Milliliters":
        unitName = UnitVolume.milliliters
    case "Cubic Kilometers":
        unitName = UnitVolume.cubicKilometers
    case "Cubic Meters":
        unitName = UnitVolume.cubicMeters
    case "Cubic Decimeters":
        unitName = UnitVolume.cubicDecimeters
    case "Cubic Millimeters":
        unitName = UnitVolume.cubicMillimeters
    case "Cubic Inches":
        unitName = UnitVolume.cubicInches
    case "Cubic Feet":
        unitName = UnitVolume.cubicFeet
    case "Cubic Yards":
        unitName = UnitVolume.cubicYards
    case "Cubic Miles":
        unitName = UnitVolume.cubicMiles
    case "Acre Feet":
        unitName = UnitVolume.acreFeet
    case "Bushels":
        unitName = UnitVolume.bushels
    case "Teaspoons":
        unitName = UnitVolume.teaspoons
    case "Tablespoons":
        unitName = UnitVolume.tablespoons
    case "Fluid Ounces":
        unitName = UnitVolume.fluidOunces
    case "Cups":
        unitName = UnitVolume.cups
    case "Pints":
        unitName = UnitVolume.pints
    case "Quarts":
        unitName = UnitVolume.quarts
    case "Gallons":
        unitName = UnitVolume.gallons
    case "Imperial Teaspoons":
        unitName = UnitVolume.imperialTeaspoons
    case "Imperial Tablespoons":
        unitName = UnitVolume.imperialTablespoons
    case "Imperial Fluid Ounces":
        unitName = UnitVolume.imperialFluidOunces
    case "Imperial Pints":
        unitName = UnitVolume.imperialPints
    case "Imperial Quarts":
        unitName = UnitVolume.imperialQuarts
    case "Imperial Gallons":
        unitName = UnitVolume.imperialGallons
    case "Metric Cups":
        unitName = UnitVolume.metricCups
        
        //Defaut
    default:
        unitName = UnitLength.meters
        
    }
    return unitName
}
