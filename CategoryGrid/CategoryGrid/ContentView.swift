//
//  ContentView.swift
//  CategoryGrid
//
//  Created by GREEN on 12/23/24.
//

import SwiftUI

struct Region: Identifiable {
  let id = UUID()
  let name: String
  var districts: [District]
}

struct District: Identifiable {
  let id = UUID()
  let name: String
}

struct RegionsView: View {
  @State private var expandedRegion: String?
  @State private var selectedDistricts: [String: [String]] = [:]
  
  var firstRowRegions = [
    Region(name: "서울", districts: [
      District(name: "전체"), District(name: "종로"), District(name: "중구"),
      District(name: "용산"), District(name: "성동"), District(name: "광진"),
      District(name: "동대문"), District(name: "중랑"), District(name: "성북"),
      District(name: "강북"), District(name: "도봉"), District(name: "노원"),
      District(name: "은평"), District(name: "서대문"), District(name: "마포"),
      District(name: "양천"), District(name: "강서"), District(name: "구로"),
      District(name: "금천"), District(name: "영등포"), District(name: "동작"),
      District(name: "관악"), District(name: "서초"), District(name: "강남"),
      District(name: "송파"), District(name: "강동")
    ]),
    Region(name: "인천", districts: [
      District(name: "전체"), District(name: "중구"), District(name: "동구"),
      District(name: "미추홀구"), District(name: "연수구"), District(name: "남동구"),
      District(name: "부평구"), District(name: "계양구"), District(name: "서구")
    ]),
    Region(name: "경기", districts: [
      District(name: "전체"), District(name: "수원시"), District(name: "성남시"),
      District(name: "의정부시"), District(name: "안양시"), District(name: "부천시"),
      District(name: "광명시"), District(name: "평택시"), District(name: "동두천시"),
      District(name: "안산시"), District(name: "고양시"), District(name: "과천시")
    ]),
    Region(name: "강원", districts: [
      District(name: "전체"), District(name: "춘천시"), District(name: "원주시"),
      District(name: "강릉시"), District(name: "동해시"), District(name: "태백시"),
      District(name: "속초시"), District(name: "삼척시"), District(name: "홍천군")
    ])
  ]
  var secondRowRegions = [
    Region(name: "충북", districts: [
      District(name: "전체"), District(name: "청주시"), District(name: "충주시"),
      District(name: "제천시"), District(name: "보은군"), District(name: "옥천군"),
      District(name: "영동군"), District(name: "증평군"), District(name: "진천군")
    ]),
    Region(name: "충남", districts: [
      District(name: "전체"), District(name: "천안시"), District(name: "공주시"),
      District(name: "보령시"), District(name: "아산시"), District(name: "서산시"),
      District(name: "논산시"), District(name: "계룡시"), District(name: "당진시")
    ]),
    Region(name: "세종", districts: [
      District(name: "전체")
    ]),
    Region(name: "대전", districts: [
      District(name: "전체")
    ])
  ]
  var thirdRowRegions = [
    Region(name: "경북", districts: [
      District(name: "전체")
    ]),
    Region(name: "대구", districts: [
      District(name: "전체")
    ]),
    Region(name: "제주", districts: [
      District(name: "전체")
    ])
  ]
  
  var body: some View {
    ScrollView {
      VStack(spacing: 16) {
        RegionRowView(
          regions: firstRowRegions,
          expandedRegion: expandedRegion,
          onRegionTap: handleRegionTap,
          selectedSubRegion: selectedDistricts,
          onSubRegionTap: handleDistrictTap
        )
        
        RegionRowView(
          regions: secondRowRegions,
          expandedRegion: expandedRegion,
          onRegionTap: handleRegionTap,
          selectedSubRegion: selectedDistricts,
          onSubRegionTap: handleDistrictTap
        )
        
        RegionRowView(
          regions: thirdRowRegions,
          expandedRegion: expandedRegion,
          onRegionTap: handleRegionTap,
          selectedSubRegion: selectedDistricts,
          onSubRegionTap: handleDistrictTap
        )
      }
    }
  }
  
  private func handleRegionTap(_ regionName: String) {
    withAnimation {
      if expandedRegion == regionName {
        expandedRegion = nil
      } else {
        expandedRegion = regionName
      }
    }
  }
  
  private func handleDistrictTap(_ district: District, region: Region) {
    withAnimation {
      if district.name == "전체" {
        // 이미 선택된 '전체'를 다시 클릭하면 선택 해제
        if selectedDistricts[region.name]?.contains("전체") ?? false {
          // 현재 지역의 '전체' 선택을 해제
          selectedDistricts[region.name]?.removeAll()
        } else {
          // 현재 지역의 '전체'만 선택
          selectedDistricts[region.name] = ["전체"]
        }
      } else {
        if let index = selectedDistricts[region.name]?.firstIndex(of: district.name) {
          // 이미 선택된 구역이면 해제
          selectedDistricts[region.name]?.remove(at: index)
        } else {
          // 현재 지역의 배열이 없으면 생성
          if selectedDistricts[region.name] == nil {
            selectedDistricts[region.name] = []
          }
          
          // 현재 지역의 '전체' 선택만 해제
          if selectedDistricts[region.name]?.contains("전체") ?? false {
            selectedDistricts[region.name]?.removeAll()
          }
          
          // 새로운 구역 추가
          selectedDistricts[region.name]?.append(district.name)
        }
      }
    }
  }
}

struct RegionRowView: View {
  let regions: [Region]
  let expandedRegion: String?
  let onRegionTap: (String) -> Void
  let selectedSubRegion: [String: [String]]
  let onSubRegionTap: (District, Region) -> Void
  let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)
  
  var body: some View {
    VStack(spacing: 0) {
      LazyVGrid(columns: gridColumns, alignment: .leading, spacing: 8) {
        ForEach(regions) { region in
          regionButton(for: region)
        }
      }
      .padding(.horizontal)
      
      if let selectedRegion = regions.first(where: { $0.name == expandedRegion }) {
        districtsGrid(for: selectedRegion)
      }
    }
  }
  
  @ViewBuilder
  private func regionButton(for region: Region) -> some View {
    Button(action: {
      onRegionTap(region.name)
    }) {
      Text(region.name)
        .font(.body)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.1))
        )
        .opacity(expandedRegion == region.name ? 0 : 1)
        .overlay(
          Text(region.name)
            .font(.body)
            .bold()
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.green.opacity(0.1))
            )
            .opacity(expandedRegion == region.name ? 1 : 0)
        )
    }
    .buttonStyle(PlainButtonStyle())
  }
  
  @ViewBuilder
  private func districtsGrid(for region: Region) -> some View {
    LazyVGrid(columns: gridColumns, spacing: 8) {
      ForEach(region.districts) { district in
        Button(action: {
          onSubRegionTap(district, region)
        }) {
          Text(district.name)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(
                  selectedSubRegion[region.name]?.contains(district.name) ?? false
                  ? Color.blue.opacity(0.1)
                  : Color.gray.opacity(0.3)
                )
            )
        }
        .buttonStyle(PlainButtonStyle())
      }
    }
    .padding(.horizontal)
    .padding(.top, 16)
    .transition(.opacity)
  }
}

#Preview {
  RegionsView()
}
