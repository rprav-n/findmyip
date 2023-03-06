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
    @State private var isLaunchOnStart = false
    
    var body: some View {
        VStack {
            if (fetching) {
                ProgressView()
                    .scaleEffect(0.5)
            } else {
                VStack {
                    HStack {
                        Text(ipAddress)
                            .padding(.leading, 10)
                        Spacer()
                        Button {
                            copyButtonPressed()
                        } label: {
                            Text(copyBtnText)
                        }
                        .padding(.trailing, 10)
                    }
                }
            }
            Divider()
            HStack {
                Text("Launch on Start")
                    .padding(.horizontal, 10)
                Spacer()
                Toggle("", isOn: $isLaunchOnStart)
                    .toggleStyle(.switch)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .padding(.horizontal, 10)
                    .onChange(of: isLaunchOnStart) { newValue in
                        print("newValue", newValue)
                    }
            }
            Divider()
        }
        .frame(width: 200, height: 100)
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
    
    func launchOnStartToggle(){
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
