import SwiftUI

// MARK: - 뷰모델
final class ListViewModel: ObservableObject {
  @Published var items: [Color] = [.red, .blue, .black, .green, .yellow]
  @Published var currentItem: Color?
  @Published var isDragging = false
  @Published var draggingIndex: Int?
}

// MARK: - 메인 리스트 뷰
struct ListView: View {
  @StateObject var viewModel = ListViewModel()
  
  var body: some View {
    VStack {
      ItemView(viewModel: viewModel)
    }
    .padding(.horizontal, 20)
  }
}

// MARK: - 리스트 아이템 뷰
private struct ItemView: View {
  @ObservedObject var viewModel: ListViewModel
  
  var body: some View {
    VStack {
      ForEach(viewModel.items.indices, id:\.self) { index in
        if viewModel.draggingIndex != index {
          RoundedRectangle(cornerRadius: 20)
            .foregroundColor(viewModel.items[index])
            .frame(width: 100, height: 100)
            .overlay(
              viewModel.currentItem == viewModel.items[index] && viewModel.isDragging
              ? Color.white.opacity(0.5)
              : Color.clear
            )
            .onDrag {
              viewModel.currentItem = viewModel.items[index]
              viewModel.isDragging = true
              viewModel.draggingIndex = index
              return NSItemProvider(object: String(describing: index) as NSString)
            }
            .onDrop(of: [.text], delegate: ItemDropDelegate(index: index, viewModel: viewModel))
        }
      }
    }
  }
}

// MARK: - 커스텀한 DropDelegate
struct ItemDropDelegate: DropDelegate {
  let index: Int
  let viewModel: ListViewModel
  
  func dropUpdated(info: DropInfo) -> DropProposal? {
    return DropProposal(operation: .move)
  }
  
  func dropEntered(info: DropInfo) {
    viewModel.isDragging = true
    guard let from = viewModel.items.firstIndex(of: viewModel.currentItem!),
          from != index else {
      return
    }
    
    let toIndex = from < index ? index + 1 : index
    viewModel.items.move(fromOffsets: IndexSet(integer: from), toOffset: toIndex)
  }
  
  func performDrop(info: DropInfo) -> Bool {
    viewModel.currentItem = nil
    viewModel.isDragging = false
    viewModel.draggingIndex = nil
    return true
  }
}
