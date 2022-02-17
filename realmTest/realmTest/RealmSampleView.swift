//
//  RealmSampleView.swift
//  realmTest
//
//  Created by Chanwoo Cho on 2022/02/17.
//

import SwiftUI
import RealmSwift

struct RealmSampleView: View {
  @State var name: String = "이름 데이터를 가져와주세요."
  @State var age: String = "나이 데이터를 가져와주세요."
    var body: some View {
      Button("Set Realm Data") {
        setRealmData()
      }
      Button("Get Realm Data") {
        let realmData = getRealmData()
        name = realmData.name
        age = String(realmData.age)
      }
      Button("Remove Realm Data") {
        removeRealmData()
      }
      Text(name)
      Text(age)
    }
}

private func setRealmData() {
  let realmData = RealmData()
  realmData.name = "그린"
  realmData.age = 100
  
  let realm = try! Realm()
  try! realm.write {
    realm.add(realmData)
  }
}

private func getRealmData() -> RealmData {
  let realm = try! Realm()
  let filteredData = realm.objects(RealmData.self)
    .filter("age > 50")
  let arrData = Array(filteredData)
  guard let resultData = arrData.first else { return RealmData() }
  
  return resultData
}

private func removeRealmData() {
  let realm = try! Realm()
  try! realm.write {
    realm.delete(realm.objects(RealmData.self))
  }
}

struct RealmSampleView_Previews: PreviewProvider {
    static var previews: some View {
      RealmSampleView()
    }
}
