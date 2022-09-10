//
//  SwiftUIView.swift
//  Monopoly Calculator
//
//  Created by Nihal Memon on 6/26/22.
//

import SwiftUI

struct PopUpBox: View {
    //Convert To Binding Later
    @Binding var selectedReason : String
    @Binding var selectedUser : String
    @Binding var allUsers : [PlayerModel]
    @Binding var layoutFor : String
    @Binding var showMenu : Bool
    
    @State var addingReasons = ["Passed Go", "City Fees", "Other"]
    @State var minusReasons = ["City Fees", "Bought A House", "Bought A Hotel", "Bought A Property", "Paying Rent", "Transfering", "Other"]
   
    var body: some View {
        ZStack {
            BackgroundGradient()
            VStack{
                if(layoutFor == "Adding"){
                    Text("Adding Money To The Balance")
                        .font(.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                        .padding(.top)
                    Spacer()
                    HStack{
                        Text("Select A Reason")
                            .font(.title3)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    Picker("", selection: self.$selectedReason) {
                        ForEach(addingReasons, id: \.self){reason in
                            Text(reason)
                                .foregroundColor(.white)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Spacer()
                    
                }
                else{
                    Text("Subtracting Money From Balance")
                        .font(.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.top)
                    Spacer()
                    HStack{
                        Text("Select A Reason")
                            .font(.title3)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    Picker("", selection: self.$selectedReason) {
                        ForEach(minusReasons, id: \.self){reason in
                            Text(reason)
                                .foregroundColor(.white)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    if(self.selectedReason == "Transfering" || self.selectedReason == "Paying Rent"){
                        HStack{
                            Text("Select A Person")
                                .font(.title3)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        Picker("", selection: self.$selectedUser) {
                            ForEach(allUsers){users in
                                HStack{
                                    Text(users.name)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                    
                    Spacer()
                }
                Button{
                    self.showMenu = false
                } label: {
                    Text("Done")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(.horizontal)
                        .padding(.vertical, 7)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                }
                .padding(.bottom)

            }
            .padding()
            .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
            .background(.ultraThinMaterial)
            .cornerRadius(30)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .ignoresSafeArea()
        .background(.clear)
    }
}
