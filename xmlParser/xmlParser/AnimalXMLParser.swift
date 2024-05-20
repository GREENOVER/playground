//
//  AnimalXMLParser.swift
//  xmlParser
//
//  Created by GREEN on 5/20/24.
//

import Foundation

class AnimalXMLParser: NSObject, XMLParserDelegate {
  private var animals: [Animal] = []
  private var currentElement = ""
  private var currentName = ""
  private var currentOwner = ""
  private var currentAge = ""
  
  func parse(data: Data) -> [Animal] {
    let parser = XMLParser(data: data)
    parser.delegate = self
    parser.parse()
    return animals
  }
  
  // MARK: - XMLParserDelegate
  func parser(
    _ parser: XMLParser,
    didStartElement elementName: String,
    namespaceURI: String?,
    qualifiedName qName: String?,
    attributes attributeDict: [String : String] = [:]
  ) {
    currentElement = elementName
    if currentElement == "animal" {
      currentName = ""
      currentOwner = ""
      currentAge = ""
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    switch currentElement {
    case "name":
      currentName += string
    case "owner":
      currentOwner += string
    case "age":
      currentAge += string
    default:
      break
    }
  }
  
  func parser(
    _ parser: XMLParser,
    didEndElement elementName: String,
    namespaceURI: String?,
    qualifiedName qName: String?
  ) {
    if elementName == "animal" {
      let animal = Animal(name: currentName, owner: currentOwner, age: currentAge)
      animals.append(animal)
    }
  }
}
