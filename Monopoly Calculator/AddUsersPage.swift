//
//  AddUsersPage.swift
//  Monopoly Calculator
//
//  Created by Nihal Memon on 6/12/22.
//

import SwiftUI

struct AddUsersPage: View {
    @State var playersName : String = ""
    @State var playersList : [PlayerModel]  = []
    @State var tokenArray = ["🐕", "🐈", "🎩", "🗑", "🏎", "🥾", "⛴", "🚃"]
    @State var tokenSelected = "🐕"
    @State var numOfGames = UserDefaults.standard.integer(forKey: "numOfGames")
    @Environment(\.presentationMode) var presentationMode
    @State var newGame : GameModel = GameModel(id: "",gameName: "", players: [])
    @State var gameName = ""
    var body: some View {
        ZStack{
           BackgroundGradient()
            
            VStack{
                TextField("Game Name", text: self.$gameName)
                    .foregroundColor(.white)
                    .font(.title)
                    .accentColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                
                //Textfield entry
                Spacer()
                if(self.playersList.count < 8){
                    HStack{
                        TextField(" ", text: self.$playersName)
                            .placeholder(when: playersName.isEmpty){
                                Text("John")
                                    .foregroundColor(.white.opacity(0.7))
                                    .font(.title3)
                            }
                            .accentColor(.white)
                            .foregroundColor(.white)
                            .disableAutocorrection(true)
                            .frame(height: 50)
                            .padding(.leading, 10)
                        Picker("Pick the Token", selection: self.$tokenSelected) {
                            ForEach(tokenArray, id: \.self){token in
                                Text(token)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.trailing)
                            
                    }
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding()
                    
                    //Add Player Button
                    Button{
                        self.addPlayer(name: playersName, token: self.tokenSelected)
                    } label: {
                        Text("Add")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .disabled(self.playersName.isEmpty == true)
                }
                else{
                    HStack{
                        TextField(" ", text: self.$playersName)
                            .placeholder(when: playersName.isEmpty){
                                Text("John")
                                    .foregroundColor(.white.opacity(0.7))
                                    .font(.title3)
                            }
                            .accentColor(.white)
                            .foregroundColor(.white)
                            .disableAutocorrection(true)
                            .frame(height: 50)
                            .padding(.leading, 10)
                        Picker("Pick the Token", selection: self.$tokenSelected) {
                            ForEach(tokenArray, id: \.self){token in
                                Text(token)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.trailing)
                            
                    }
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding()
                    .hidden()
                    //Add Player Button
                    Button{
                        self.addPlayer(name: playersName, token: self.tokenSelected)
                    } label: {
                        Text("Add")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .disabled(self.tokenArray.isEmpty == true)
                    .hidden()
                }
                
                Spacer()
                //Name Scroll List
                VStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(self.playersList){player in
                                HStack{
                                    Text("\(player.token) | \(player.name)")
                                        .font(.title3)
                                        .foregroundColor(.white)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                .background(.ultraThinMaterial)
                                .cornerRadius(15)
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        tokenArray.append(player.token)
                                        playersList.removeAll{ $0.id == player.id}
                                    }
                                }
                                
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .padding()
                    
                    if(!self.playersList.isEmpty){
                        HStack{
                            Text("Tap the names to remove")
                                .font(.body)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                        .offset(y: -15)
                    }else{
                        HStack{
                            Text(" ")
                                .font(.body)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                        .offset(y: -15)
                    }
                }
                    
                Spacer()
                
                //Bottom Buttons
                HStack{
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("Cancel")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    if(self.playersList.count > 0){
                        NavigationLink{
                            PlayingPage(game: self.$newGame)
                                .navigationBarHidden(true)
                        } label: {
                            Text("Done")
                                .foregroundColor(.white)
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .simultaneousGesture(TapGesture().onEnded{ createUsers()})
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear(){
            self.gameName = "Game #\(numOfGames+1)"
        }
    }
    
    func addPlayer(name: String, token: String){
        let newPlayer = PlayerModel(id: UUID().uuidString, name: name, token: token, balance: 15.000, history: "All Transactions: ", tag: Int.random(in: 0...100))
        withAnimation(.spring()){
            playersList.append(newPlayer)
        }
        self.playersName = ""
        self.tokenArray.removeAll{$0 == token}
        if(!tokenArray.isEmpty){
            self.tokenSelected = tokenArray[0]
        }
    }
    
    func createUsers(){
        let newID = UUID().uuidString
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(playersList)

            //Add num of games
            UserDefaults.standard.set((numOfGames + 1), forKey: "numOfGames")
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: newID)

        } catch {
            print("Unable to Encode Array of Players (\(error))")
        }
        
        self.newGame = GameModel(id: newID, gameName: "Game #\(numOfGames + 1)", players: self.playersList)
        UserDefaults.standard.set(gameName, forKey: "GameName-\(newID)")
        self.addGameToList(gameID: newID)
    }
    
    func addGameToList(gameID: String){
        var currentGames = UserDefaults.standard.string(forKey: "Games") ?? ""
        currentGames = currentGames + "***" + gameID
        UserDefaults.standard.set(currentGames, forKey: "Games")
    }
}

struct AddUsersPage_Previews: PreviewProvider {
    static var previews: some View {
        AddUsersPage()
    }
}
