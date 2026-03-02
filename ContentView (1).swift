//
//  ContentView.swift
//  BibliotecaPersonal
//
//  Created by Nick Rivera Guth on 28/2/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = LibraryViewModel()
    @State private var selectedBook: Book?

    var body: some View {
        NavigationSplitView {
            // LISTA (Lado izquierdo en iPad, principal en iPhone)
            List(vm.filteredBooks, selection: $selectedBook) { book in
                HStack {
                    VStack(alignment: .leading) {
                        Text(book.title).font(.headline)
                        Text(book.author).font(.subheadline).foregroundStyle(.secondary)
                    }
                    Spacer()
                    if book.isFavorite {
                        Image(systemName: "star.fill").foregroundStyle(.yellow)
                    }
                }
                .tag(book)
                .swipeActions {
                    Button { vm.toggleFavorite(book) } label: {
                        Label("Favorito", systemImage: "star")
                    }
                    .tint(.yellow)
                }
            }
            .navigationTitle("Biblioteca IDS")
            .searchable(text: $vm.searchText, prompt: "Buscar por título o autor")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Toggle(isOn: $vm.showOnlyFavorites) {
                        Image(systemName: vm.showOnlyFavorites ? "star.fill" : "star")
                    }
                    .toggleStyle(.button)
                }
            }
        } detail: {
            // DETALLE (Lado derecho en iPad, vista empujada en iPhone)
            if let book = selectedBook {
                let currentBook = vm.books.first(where: { $0.id == book.id }) ?? book
                BookDetailView(book: currentBook) {
                    vm.toggleFavorite(currentBook)
                }
            } else {
                ContentUnavailableView(
                    "Selecciona un libro",
                    systemImage: "book.closed",
                    description: Text("Elige un título de la lista para ver sus detalles.")
                )
            }
        }
    }
}
