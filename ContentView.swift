import SwiftUI

struct ContentView: View {

    // Constantes (let)
    let nombre: String = "Federico Macias"
    let edad: Int = 22

    // Variable (var) - ejemplo de estado que puede cambiar
    @State private var mostrarDetalles: Bool = true

    // Arreglo de tuplas: (título, detalle) -> Formación académica
    let formacion: [(titulo: String, detalle: String)] = [
        ("Ingeniería en Desarrollo de Software", "TecMilenio (México)"),
        ("Lingüística Computacional", "Universität Heidelberg (Alemania)")
    ]

    // Arreglo de tuplas: (experiencia, detalle) -> Experiencia profesional / académica
    let experiencia: [(titulo: String, detalle: String)] = [
        ("Estudios en el extranjero", "Experiencia académica en Alemania"),
        ("Área de interés", "Lingüística Computacional")
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {

                Text(nombre)
                    .font(.title)
                    .bold()

                Text("Edad: \(edad)")
                    .font(.headline)

                Toggle("Mostrar secciones del currículum", isOn: $mostrarDetalles)

                if mostrarDetalles {

                    Text("Experiencia")
                        .font(.title2)
                        .bold()
                        .padding(.top, 8)

                    ForEach(experiencia.indices, id: \.self) { i in
                        let item = experiencia[i]
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.titulo)
                                .font(.headline)
                            Text(item.detalle)
                                .font(.subheadline)
                        }
                        .padding(.vertical, 6)
                    }

                    Text("Formación académica")
                        .font(.title2)
                        .bold()
                        .padding(.top, 8)

                    ForEach(formacion.indices, id: \.self) { i in
                        let item = formacion[i]
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.titulo)
                                .font(.headline)
                            Text(item.detalle)
                                .font(.subheadline)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .padding()
        }
    }
}
