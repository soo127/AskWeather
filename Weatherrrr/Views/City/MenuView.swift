//
//  MenuView.swift
//  Weatherrrr
//
//  Created by 이상수 on 6/11/25.
//

import SwiftUI

struct MenuView: View {

    var body: some View {
        Menu {
            Button {
                print("hello")
            } label: {
                Label("목록 삭제", systemImage: "eraser")
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }

}

#Preview {
    MenuView()
}
