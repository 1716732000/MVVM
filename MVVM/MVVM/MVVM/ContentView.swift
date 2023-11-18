//
//  ContentView.swift
//  MVVM
//
//  Created by jose on 17/11/23.
//

import SwiftUI

struct ContentView: View {
    @State var descriptionNote: String = ""
    @StateObject var notesViewModel = NotesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Agregar Tarea")
                    .underline()
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                
                TextEditor(text: $descriptionNote)
                    .foregroundColor(.black)
                    .frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
                    .padding(.horizontal, 12)
                
                Button("Crear Nota"){
                    notesViewModel.saveNote(description: descriptionNote)
                    descriptionNote = ""
                }
                .foregroundColor(.black)
                .frame(width: 150, height: 75)
                .background(Color.green)
                
                Spacer()
                //Aqui la lista
                List {
                    ForEach(notesViewModel.notes, id: \.id){ note in
                            HStack{
                                Text(note.description)
                            }
                            
                        }
                }
                .background(Color.gray)
                }
                
                //Aqui la lista
            }
        }
        
    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
