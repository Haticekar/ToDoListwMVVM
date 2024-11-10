//
//  AddView.swift
//  ToDoList
//
//  Created by Hatice Kar on 9.11.2024.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel : ListViewModel
    @State var textFieldText : String = ""
    
    @State var alertTitle : String = ""
    @State var showAlert : Bool = false
    
    var body: some View {
        ScrollView{
            VStack {
                TextField("Type something here..", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height:55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding()
                
                Button(action: saveButtonPressed, label:{
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(12)
            
        }
        .navigationTitle("Add an Item ✏")
        .alert(isPresented: $showAlert, content: getAlert)
        
    }
    
    func saveButtonPressed(){
        
        if textIsAppropriate() == true  {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() ->Bool{
        if textFieldText.count < 3{
            alertTitle = "Your new todo item must be at least 3 characters long!! 😨😟"
            showAlert.toggle()
            return false
        }
        return true
    }
    func getAlert() ->Alert{
        return Alert(title: Text(alertTitle))
    }
}

#Preview {
    Group{
        NavigationView{
            AddView()
        }.environmentObject(ListViewModel())
            .preferredColorScheme(.dark)
    }
   
}
