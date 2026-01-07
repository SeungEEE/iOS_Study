//
//  Example 2.swift
//  ToolBarCustomizations
//
//  Created by 이승진 on 1/7/26.
//

import SwiftUI

struct Example_2: View {
  @State private var searchText: String = ""
  var body: some View {
    NavigationStack {
      List {
        NavigationLink {
          Example2DetailView()
        } label: {
          HStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
              .fill(.fill)
              .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 6) {
              Text("Apple")
                .fontWeight(.semibold)
              
              Text("Your Invoice from Apple")
                .font(.caption)
            }
          }
        }
        .toolbar(id: "WRITEACTION") {
          ToolbarItem(id: "WRITE", placement: .bottomBar) {
            Button {
              
            } label: {
              Image(systemName: "square.and.pencil")
            }
          }
        }
        .toolbar {
          ToolbarItem(placement: .bottomBar) {
            Button {
              
            } label: {
              Image(systemName: "line.3.horizontal.decrease")
            }
          }
          /// 두 개 항목 나누기
          ToolbarSpacer(.fixed, placement: .bottomBar)
          
          DefaultToolbarItem(kind: .search, placement: .bottomBar)
          
          /// 두 개 항목 나누기
          ToolbarSpacer(.fixed, placement: .bottomBar)
        }
        .searchable(text: $searchText)
      }
      .navigationTitle("Inbox")
      .navigationSubtitle("iCloud - Updated Just Now")
    }
  }
}

struct Example2DetailView: View {
  var body: some View {
    VStack {
      
    }
    .navigationTitle("Apple")
    .toolbar(id: "WRITEACTION") {
      ToolbarItem(id: "WRITE", placement: .bottomBar) {
        Button {
          
        } label: {
          Image(systemName: "square.and.pencil")
        }
      }
    }
    .toolbar {
      ToolbarItem(placement: .bottomBar) {
        HStack(spacing: 12) {
          Button {
            
          } label: {
            Image(systemName: "trash")
              .padding(.horizontal, 5)
          }
          
          Button {
            
          } label: {
            Image(systemName: "folder")
              .padding(.horizontal, 5)
          }
          
          Button {
            
          } label: {
            Image(systemName: "arrowshape.turn.up.forward.fill")
              .padding(.horizontal, 5)
          }
        }
        .padding(.horizontal, 5)
        .buttonStyle(.plain)
      }
      
      ToolbarSpacer(.flexible, placement: .bottomBar)
    }
  }
}

#Preview {
  Example_2()
}
