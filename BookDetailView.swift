//
//  BookDetailView.swift
//  BibliotecaPersonal
//
//  Created by Nick Rivera Guth on 28/2/26.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    let onToggleFavorite: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: "book.pages.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                    .foregroundColor(.accentColor)
                    .padding(.top)

                Text(book.title)
                    .font(.title)
                    .bold()

                VStack(alignment: .leading, spacing: 10) {
                    Label("Autor: \(book.author)", systemImage: "person.fill")
                    Label("Año: \(String(book.year))", systemImage: "calendar")
                }
                .font(.headline)
                .foregroundStyle(.secondary)

                Divider()

                Button(action: onToggleFavorite) {
                    Label(
                        book.isFavorite ? "Quitar de Favoritos" : "Marcar como Favorito",
                        systemImage: book.isFavorite ? "star.slash.fill" : "star.fill"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(book.isFavorite ? .orange : .blue)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Detalles del Libro")
#if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
    }
}
