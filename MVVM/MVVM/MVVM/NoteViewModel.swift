//
//  NoteViewModel.swift
//  MVVM
//
//  Created by jose on 17/11/23.
//

import Foundation
import SwiftUI //Para tomar el Binding

final class NotesViewModel: ObservableObject{
    @Published var notes: [NoteModel] = []
    
    init(){//Cargar datos guardados
        notes = getAllNotes()
    }
    
    func saveNote(description: String){//Guardar datos
        let newNote = NoteModel(description: description)
        notes.insert(newNote, at: 0)
        encodeAndSaveAllNotes()
    }
    
    private func encodeAndSaveAllNotes(){
        if let encoded = try? JSONEncoder().encode(notes){
            UserDefaults.standard.set(encoded, forKey: "notes")//Guardar datos en cell
        }
    }
    
    func getAllNotes() -> [NoteModel]{
        if let notesData = UserDefaults.standard.object(forKey: "notes") as? Data {
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData){
                return notes
            }
        }
        return []
    }
    
    //Remover Notas
    func removeNote(withId id: String){
        notes.removeAll(where: { $0.id == id})
        encodeAndSaveAllNotes()
    }
    
    func updateFavoriteNote(note: Binding<NoteModel>){
        note.wrappedValue.isFavorited = !note.wrappedValue.isFavorited
        encodeAndSaveAllNotes()
    }
}
