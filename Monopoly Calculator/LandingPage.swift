//
//  LandingPage.swift
//  Monopoly Calculator
//
//  Created by Nihal Memon on 6/12/22.
//

import SwiftUI

struct LandingPage: View {
    @State var numOfGames = 0
    @State var allPlayers : [PlayerModel] = []
    @State var allGames : [GameModel] = []
    @State var tabSelection = 0
    var body: some View {
        NavigationView{
            ZStack{
               BackgroundGradient()
                VStack{
                    Text("Monopoly Calculator+")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach($allGames){game in
                                NavigationLink{
                                    PlayingPage(game: game)
                                        .navigationBarHidden(true)
                                } label: {
                                    gameBox(game: game)
                                        .overlay(
                                            Button{
                                                self.deleteGame(gameId: game.id)
                                            } label: {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.white)
                                                    .font(.title3)
                                            }
                                                .padding()
                                                .background(.ultraThinMaterial)
                                                .cornerRadius(30)
                                                .offset(x: 162, y: -87)
                                        )
                                }
                            }
                            
                            NavigationLink{
                                AddUsersPage()
                                    .navigationBarHidden(true)
                            } label: {
                                VStack{
                                    Spacer()
                                    Image(systemName: "plus")
                                        .font(.largeTitle)
                                        .padding(.bottom, 25)
                                        .foregroundColor(.white)
                                    
                                    Text("Start New Game")
                                        .font(.title)
                                        .padding()
                                        .foregroundColor(.white)
                                }
                                .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 4)
                                .background(.ultraThinMaterial)
                                .cornerRadius(30)
                                .padding(.leading, 50)
                                .padding(.trailing, numOfGames > 1 ? 0 : 25)
                            }
                        }
                    }
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
        .onAppear(){
            self.getGames()
        }
    }
    
    func getGames(){
        let gameList = UserDefaults.standard.string(forKey: "Games") ?? ""
        var arrayOfGameID = gameList.components(separatedBy: "***")
        arrayOfGameID.remove(at: 0)
        if(arrayOfGameID.count > 0){
            for gameID in arrayOfGameID{
                let players = getPlayers(gameID: gameID)
                let gameName = UserDefaults.standard.string(forKey: "GameName-\(gameID)") ?? "Game#Unknown"
                let newGame = GameModel(id: gameID, gameName: gameName, players: players)
                self.allGames.append(newGame)
            }
        }
       
    }
    
    func deleteGame(gameId: String){
        var gameList = UserDefaults.standard.string(forKey: "Games") ?? ""
        var arrayOfGameID = gameList.components(separatedBy: "***")
        arrayOfGameID.remove(at: 0)
        if let index = arrayOfGameID.firstIndex(of: gameId){
            withAnimation(.spring()) {
                allGames.remove(at: index)
            }
            arrayOfGameID.remove(at: index)
        }
        gameList = ""
        for strings in arrayOfGameID{
            gameList = gameList + "***" + strings
        }
        UserDefaults.standard.removeObject(forKey: gameId)
        UserDefaults.standard.removeObject(forKey: "GameName-\(gameId)")
        UserDefaults.standard.set(gameList, forKey: "Games")
    }
    
    func getPlayers(gameID : String)->[PlayerModel]{
        if let data = UserDefaults.standard.data(forKey: gameID) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let players = try decoder.decode([PlayerModel].self, from: data)
               allPlayers = players

            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
        return allPlayers
    }
}

struct gameBox : View{
    @Binding var game : GameModel
    var body: some View{
        ZStack{
            VStack{
                HStack{
                    Text(game.gameName)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    
                    Text("Players")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top)
                        
                    Spacer()
                }
               
                ScrollView(.vertical, showsIndicators: false){
                    VStack {
                        ForEach(game.players){player in
                            HStack{
                                Text("\(player.token) | \(player.name)")
                                    .font(.title3)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal)
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                        }
                    }
                    .padding()
                }
                .offset(y: -15)
            }
            .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 4)
            .background(.ultraThinMaterial)
            .cornerRadius(30)
            .padding(.leading, 50)
        }
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
