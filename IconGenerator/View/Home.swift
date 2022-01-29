//
//  Home.swift
//  IconGenerator
//
//  Created by Chirag's on 28/01/22.
//

import SwiftUI

struct Home: View {
    @StateObject var iconModel: IconViewModel = IconViewModel()
    // MARK: - Enviroment Values for adapting UI for dark/Light Mode....
    @Environment(\.self) var env
    var body: some View {
        VStack(spacing: 15.0) {
            if let image = iconModel.pickedImage {
                // MARK: -  Displaying Image with Action.....
                Group {
                    Image(nsImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 250)
                        .clipped()
                        .onTapGesture {
                            iconModel.PickImage()
                        }
                    // MARK: - Generate Button
                    Button(action: {
                        iconModel.generateIconSet()
                    }) {
                            Text("Generate Icon Set")
                            .foregroundColor(env.colorScheme == .dark ? .black : .white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 18)
                            .background(.primary, in: RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.top, 10)
                }
            }else {
                // MARK: - Add Button....
                ZStack {
                    Button(action: {
                        iconModel.PickImage()
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(env.colorScheme == .dark ? .black : .white)
                            .padding(15)
                            .background(.primary, in: RoundedRectangle(cornerRadius: 10))
                    }
                    
                    // MARK: -  Recommended Size Text....
                    Text("1024 X 1024 is Recommended!")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
        .frame(width: 400, height: 400)
        .buttonStyle(.plain)
        // MARK: - Alert View
        .alert(iconModel.alertMsg, isPresented: $iconModel.showAlert){
            
        }
        // MARK: -  Loading View
        .overlay {
            ZStack {
                if iconModel.isGenerating {
                    Color.black.opacity(0.25)
                    ProgressView()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 10))
                    // MARK: - Always  Light Mode....
                        .environment(\.colorScheme, .light)
                }
            }
        }
        .animation(.easeInOut, value: iconModel.isGenerating)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
