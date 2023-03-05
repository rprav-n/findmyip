//
//  ContentView.swift
//  FindMyIP
//
//  Created by Praveen on 05/03/23.
//

import SwiftUI


struct ContentView: View {
    
    @State private var fetching = false
    @State private var ipAddress = "127.0.0.1"
    @State private var copyBtnText = "Copy"
    
    var body: some View {
        VStack {
            if (fetching) {
                ProgressView()
                    .scaleEffect(0.5)
            } else {
                HStack {
                    Text(ipAddress)
                        .padding()
                    Spacer()
                    Button {
                        copyButtonPressed()
                    } label: {
                        Text(copyBtnText)
                    }
                    Spacer()
                }
            }
        }
        .frame(width: 200, height: 25)
        .task {
            await getIPAddress()
        }
    }
    
    func copyButtonPressed() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(ipAddress, forType: .string)
        copyBtnText = "Copied"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            copyBtnText = "Copy"
        }
        
    }
    
    func getIPAddress() async {
        let url = "https://jsonip.com"
        let apiService = APIService(urlString: url)
        fetching.toggle()
        defer {
            fetching.toggle()
        }
        do {
            let ipModel: IPModel = try await apiService.getJSON()
            ipAddress = ipModel.ip
        } catch {
            ipAddress = error.localizedDescription
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
