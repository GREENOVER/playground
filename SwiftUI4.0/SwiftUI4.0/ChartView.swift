//
//  ChartView.swift
//  SwiftUI4.0
//
//  Created by GREEN on 2022/06/08.
//

import Charts
import SwiftUI

struct Posting: Identifiable {
  let name: String
  let count: Int
  
  var id: String { name }
}

let postings: [Posting] = [
  .init(name: "Green", count: 250),
  .init(name: "James", count: 100),
  .init(name: "Tony", count: 70)
]

struct ChartView: View {
  var body: some View {
    BarChartView()
    HorizontalBarChartView()
    GraphChartView()
    PointChartView()
    GraphAndSymbolChartView()
    AreaChartView()
    RectangleMarkChartView()
    RuleMarkChartView()
  }
}

struct BarChartView: View {
  var body: some View {
    
    
    
    Chart {
      ForEach(postings) { posting in
        BarMark(
          x: .value("Name", posting.name),
          y: .value("Posting", posting.count)
        )
      }
    }
  }
}

struct HorizontalBarChartView: View {
  var body: some View {
    Chart {
      ForEach(postings) { posting in
        BarMark(
          x: .value("Posting", posting.count),
          y: .value("Name", posting.name)
        )
      }
    }
  }
}

struct GraphChartView: View {
  var body: some View {
    Chart {
      ForEach(postings) { posting in
        LineMark(
          x: .value("Name", posting.name),
          y: .value("Posting", posting.count)
        )
        .foregroundStyle(Color.red)
      }
    }
  }
}

struct PointChartView: View {
  var body: some View {
    Chart {
      ForEach(postings) { posting in
        PointMark(
          x: .value("Posting", posting.count),
          y: .value("Name", posting.name)
        )
      }
    }
  }
}

struct GraphAndSymbolChartView: View {
  var body: some View {
    Chart {
      ForEach(postings) { posting in
        LineMark(
          x: .value("Name", posting.name),
          y: .value("Posting", posting.count)
        )
        .symbol(by: .value("Name", posting.name))
      }
    }
  }
}

struct AreaChartView: View {
  var body: some View {
    Chart {
      ForEach(postings) { posting in
        AreaMark(
          x: .value("Name", posting.name),
          y: .value("Posting", posting.count)
        )
      }
    }
  }
}

struct RectangleMarkChartView: View {
  var body: some View {
    Chart {
      ForEach(postings) { posting in
        RectangleMark(
          x: .value("Name", posting.name),
          y: .value("Posting", posting.count)
        )
      }
    }
  }
}

struct RuleMarkChartView: View {
  var body: some View {
    Chart {
      ForEach(postings) { posting in
        RuleMark(
          xStart: .value("Posting", posting.count),
          xEnd: .value("Posting", posting.count + 20),
          y: .value("Name", posting.name)
        )
      }
    }
  }
}

struct ChartView_Previews: PreviewProvider {
  static var previews: some View {
    ChartView()
  }
}
