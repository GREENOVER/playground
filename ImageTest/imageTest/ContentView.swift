//
//  ContentView.swift
//  imageTest
//
//  Created by GREEN on 2022/06/02.
//

import SwiftUI
import NukeUI
import Kingfisher

struct ContentView: View {
  let images = [
  "https://user-images.githubusercontent.com/72292617/170170252-a316051f-334d-4f6a-98da-b39ca30df7bb.png",
  "https://user-images.githubusercontent.com/72292617/170170260-59662d47-0523-4301-8c01-5d9f29880de7.png",
  "https://user-images.githubusercontent.com/72292617/170170264-54fbd87c-55c8-4164-809f-d260a9830b6b.png",
  "https://user-images.githubusercontent.com/72292617/170170266-f8d4aeae-d388-49a8-aacc-b7e53d206081.png",
  "https://user-images.githubusercontent.com/72292617/170170270-d35ba6b8-d3dc-4aaa-9992-5fb5758c507e.png",
  "https://user-images.githubusercontent.com/72292617/170170272-7ddfcf76-5ed6-45c6-93d3-ad74f5636094.png",
  "https://user-images.githubusercontent.com/72292617/170170274-b3cd8dce-306c-4f65-8e66-4b5fc1d12af5.png",
  "https://user-images.githubusercontent.com/72292617/170170276-10eeeae1-34f3-4f09-98a2-d18898a492ef.png",
  "https://user-images.githubusercontent.com/72292617/170170252-a316051f-334d-4f6a-98da-b39ca30df7bb.png",
  "https://user-images.githubusercontent.com/72292617/170170260-59662d47-0523-4301-8c01-5d9f29880de7.png",
  "https://user-images.githubusercontent.com/72292617/170170264-54fbd87c-55c8-4164-809f-d260a9830b6b.png",
  "https://user-images.githubusercontent.com/72292617/170170266-f8d4aeae-d388-49a8-aacc-b7e53d206081.png",
  "https://user-images.githubusercontent.com/72292617/170170270-d35ba6b8-d3dc-4aaa-9992-5fb5758c507e.png",
  "https://user-images.githubusercontent.com/72292617/170170272-7ddfcf76-5ed6-45c6-93d3-ad74f5636094.png",
  "https://user-images.githubusercontent.com/72292617/170170274-b3cd8dce-306c-4f65-8e66-4b5fc1d12af5.png"
  ]
  
  var body: some View {
    VStack(spacing: 0) {
      Spacer()
        .frame(height: 100)
      KingfisherImageView(images: self.images)
        .background(Color.yellow)
      Spacer()
        .frame(height: 30)
      NukeImageView(images: self.images)
        .background(Color.red)
      Spacer()
        .frame(height: 30)
      AsyncImageView(images: self.images)
        .background(Color.blue)
    }
  }
}

private struct NukeImageView: View {
  var images: [String]
  
  init(images: [String]) {
    self.images = images
  }
  
  var body: some View {
    HStack {
      ForEach(images, id: \.self) { image in
        LazyImage(source: image)
          .animation(nil)
      }
    }
    .frame(height: 100)
  }
}

private struct KingfisherImageView: View {
  var images: [String]
  
  init(images: [String]) {
    self.images = images
  }
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack {
        ForEach(images, id: \.self) { image in
          KFImage(URL(string: image)!)
        }
      }
      .frame(height: 100)
    }
  }
}

private struct AsyncImageView: View {
  var images: [String]
  
  init(images: [String]) {
    self.images = images
  }
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack {
        ForEach(images, id: \.self) { image in
          AsyncImage(url: URL(string: image)!)
        }
      }
      .frame(height: 100)
    }
  }
}
