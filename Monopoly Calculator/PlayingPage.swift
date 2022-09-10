//
//  PlayingPage.swift
//  Monopoly Calculator
//
//  Created by Nihal Memon on 6/13/22.
//

import SwiftUI

struct PlayingPage: View {
    @Binding var game : GameModel
    @State var tabSelection = ""
    @State var showHistory = false
    @State var showMenu = false
    var body: some View {
        ZStack{
            BackgroundGradient()
            
            VStack{
                HStack{
                    NavigationLink{
                        LandingPage()
                            .navigationBarHidden(true)
                    } label: {
                        Image(systemName: "house")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
                TabView(selection: self.$tabSelection){
                    ForEach($game.players){player in
                        VStack{
                            ScrollView(.vertical, showsIndicators: false){
                                PlayerBox(currentPlayer: player, showHistory: self.$showHistory)
                                    .tag(player.id)
                            }
                            
                            Spacer()
                            if(!showHistory){
                                EntryPad(currentPlayer: player, allPlayers: $game.players, gameID: self.$game.id)
                            }
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}

struct PlayerBox : View{
    @Binding var currentPlayer : PlayerModel
    @State var amount : String = ""
    @State var userSelected : String = ""
    @Binding var showHistory : Bool
    var body: some View{
        VStack{
            
            HStack{
                Spacer()
                
                Text("\(currentPlayer.name)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text("\(currentPlayer.token)")
                    .font(.title3)
                    .padding(5)
                    .background(Circle().foregroundColor(.white))
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            
            HStack{
                VStack(alignment: .leading){
                    Text("Balance")
                        .foregroundColor(.white)
                        .font(.title3)
                        
                    
                    Text("\(self.showBalance(balance: currentPlayer.balance))")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .italic()
                }
                .padding()
                
                Spacer()
                
            }
            
            if(showHistory){
                ScrollView{
                    Text(currentPlayer.history)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
    
            HStack{
                Text(showHistory ? "Hide Transaction History" : "Show Transaction History")
                    .foregroundColor(.white)
                    .font(.title3)
            }
            .padding(.bottom, 5)
            .onTapGesture {
                withAnimation(.spring()){
                    self.showHistory.toggle()
                }
            }
            
        }
        .frame(width: UIScreen.main.bounds.width - 50)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
    func showBalance(balance: Double)-> String{
        var balanceString = ""
        if (balance > 1.0){
            balanceString = String(format: "%.3f", currentPlayer.balance) + " M"
        } else {
            balanceString = String(Int(currentPlayer.balance * 1000)) + " K"
        }
        return balanceString
    }
}

struct EntryPad : View{
    @State var entryText = "0"
    @State var buttonSize = UIScreen.main.bounds.width / 5.5
    @Binding var currentPlayer : PlayerModel
    @Binding var allPlayers : [PlayerModel]
    @Binding var gameID : String
    @State var showMenu = false
    @State var allUsersExceptCurrent : [PlayerModel] = []
    
    @State var selectedReason = "Passed Go"
    @State var selectedUser = ""
    @State var layoutFor = "Minus"
    
    var body: some View{
        VStack{
            Text("\(entryText)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .onLongPressGesture {
                    self.clearEntry()
                }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                    .onEnded({ value in
                                        if value.translation.width < 0 {
                                            self.removeLastEntry()
                                        }

                                        if value.translation.width > 0 {
                                            self.removeLastEntry()
                                        }
                                    }))
                
            
            VStack{
                HStack{
                    Button{
                        self.addToText(value: "1")
                    } label: {
                        Text("1")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    
                    Button{
                        self.addToText(value: "2")
                    } label: {
                        Text("2")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    
                    Button{
                        self.addToText(value: "3")
                    } label: {
                        Text("3")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                
                HStack{
                    Button{
                        self.addToText(value: "4")
                    } label: {
                        Text("4")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    
                    Button{
                        self.addToText(value: "5")
                    } label: {
                        Text("5")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    
                    Button{
                        self.addToText(value: "6")
                    } label: {
                        Text("6")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                
                HStack{
                    Button{
                        self.addToText(value: "7")
                    } label: {
                        Text("7")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    
                    Button{
                        self.addToText(value: "8")
                    } label: {
                        Text("8")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    
                    Button{
                        self.addToText(value: "9")
                    } label: {
                        Text("9")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                
                HStack{
                    Button{
                        self.addToText(value: " (M)")
                    } label: {
                        Text("M")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    
                    Button{
                        self.addToText(value: "0")
                    } label: {
                        Text("0")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    
                    Button{
                        self.addToText(value: " (K)")
                    } label: {
                        Text("K")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                
                HStack{
                    
                    Button{
                        self.layoutFor = "Adding"
                        balanceAction(&currentPlayer, action: "+")
                        self.showMenu.toggle()
                    } label: {
                        Text("+")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    .disabled(self.entryText == "0" || !self.entryText.contains("M") && !self.entryText.contains("K"))
                    
                    Button{
                        self.addToText(value: ".")
                    } label: {
                        Text(".")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    
                    Button{
                        self.layoutFor = "Minus"
                        balanceAction(&currentPlayer, action: "-")
                        self.showMenu.toggle()
                    } label: {
                        Text("-")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(.ultraThinMaterial)
                            .cornerRadius(buttonSize/2)
                    }
                    .padding(.horizontal)
                    .disabled(self.entryText == "0" || !self.entryText.contains("M") && !self.entryText.contains("K"))
                    
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
        }
        .onAppear(){
            self.allUsersExceptCurrent = allPlayers
            self.allUsersExceptCurrent.removeAll(where: {$0.id == self.currentPlayer.id})
        }
        .fullScreenCover(isPresented: self.$showMenu, onDismiss: endingTasks) {
            PopUpBox(selectedReason: self.$selectedReason, selectedUser: self.$selectedUser, allUsers: self.$allUsersExceptCurrent, layoutFor: self.$layoutFor, showMenu: self.$showMenu)
        }
        
    }
    
    func endingTasks(){
        var newHistoryLine = ""
        if(layoutFor == "Adding"){
            newHistoryLine = "\n +$\(entryText) : \(selectedReason)"
            self.currentPlayer.history += newHistoryLine
        } else{
            if(selectedReason != "Paying Rent" && selectedReason != "Transfering"){
                newHistoryLine = "\n -$\(entryText) : \(selectedReason)"
                self.currentPlayer.history += newHistoryLine
            } else{
                //find other user
                var playerNames = [""]
                for player in allPlayers{
                    playerNames.append(player.id)
                }
                playerNames.remove(at: 0)
                let index = playerNames.firstIndex(of: selectedUser)
                //add to other user
                self.balanceAction(&allPlayers[index!], action: "+")
                //add to both history
                if(selectedReason == "Paying Rent"){
                    newHistoryLine = "\n -$\(entryText) : Rent to \(allPlayers[index!].name)"
                    self.currentPlayer.history += newHistoryLine
                    
                    newHistoryLine = "\n +$\(entryText) : Rent from \(self.currentPlayer.name)"
                    allPlayers[index!].history += newHistoryLine
                }
                else{
                    newHistoryLine = "\n -$\(entryText) : Transfer to \(allPlayers[index!].name)"
                    self.currentPlayer.history += newHistoryLine
                    
                    newHistoryLine = "\n +$\(entryText) : Transfer from \(self.currentPlayer.name)"
                    allPlayers[index!].history += newHistoryLine
                }
            }
        }
        
        //clear and reset all fields
        self.clearEntry()
        self.saveAction()
    }
    
    func removeLastEntry(){
        if(entryText != "0"){
            withAnimation(.spring()) {
                if(entryText.contains("M") || entryText.contains("K")){
                    for _ in 0...3{
                        entryText = String(entryText.dropLast())
                    }
                    
                }else{
                    entryText = String(entryText.dropLast())
                }
            }
        }
        
        if(entryText.count == 0){
            withAnimation(.spring()) {
                entryText = "0"
            }
        }
    }
    
    func clearEntry(){
        withAnimation(.spring()) {
            entryText = "0"
        }
    }
    
    func addToText(value : String){
        if(!entryText.contains("M") && !entryText.contains("K") ){
            if(entryText == "0"){
                withAnimation(.spring()) {
                    entryText = ""
                }
            }
            
            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.8)) {
                
                self.entryText += value
            }
            
        }
    }
    
    func balanceAction(_ user: inout PlayerModel, action: String){
        var enteredAmount = entryText
        if(enteredAmount.contains("M")){
            for _ in 0...3{
                enteredAmount.removeLast()
            }
            let theBalance = Double(enteredAmount) ?? 0.00
            print(theBalance)
            withAnimation(.spring()) {
                if(action == "+"){
                    user.balance += theBalance
                } else{
                    user.balance -= theBalance
                }
            }
           
        }
        else if (enteredAmount.contains("K")){
            for _ in 0...3{
                enteredAmount.removeLast()
            }
            
            if(enteredAmount.count == 1){
                enteredAmount = "0.00" + enteredAmount
            }
            else if(enteredAmount.count == 2){
                enteredAmount = "0.0" + enteredAmount
            }
            else{
                enteredAmount = "0." + enteredAmount
            }
            
            let theBalance = Double(enteredAmount) ?? 0.00
            print("The Balance: \(theBalance)")
            withAnimation(.linear) {
                if(action == "+"){
                    user.balance += theBalance
                } else{
                    user.balance -= theBalance
                }
            }
        } else{
            return
        }
    }
    
    func saveAction(){
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(allPlayers)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "\(gameID)")

        } catch {
            print("Unable to Encode Array of Players (\(error))")
        }
    }
}
