import SwiftUI

struct ContentView: View {

    // MARK: - Header
    let nombre: String = "Federico D. Macias"
    let ubicacion: String = "Heidelberg, DE"

    // Contacto (tuplas)
    let contacto: [(label: String, value: String)] = [
        ("Email", "federico.macias_orozco@stud.uni-heidelberg.de"),
        ("Tel", "(+49) 157-35341083"),
        ("LinkedIn", "linkedin.com/in/federico-d-macias")
    ]

    // Perfil (string)
    let perfil: String =
    "Business-driven CS/Linguistics & Software Engineering student with experience in IT consulting, tenders, and cross-border PM; skilled in Python, SQL, Java, and fine-tuning LLMs for NLP/data solutions."

    // MARK: - Secciones (tuplas + arrays)
    let education: [(title: String, detail: String, date: String)] = [
        ("University of Heidelberg",
         "Computer Science (BS) & Computer Linguistics (BA)",
         "Apr 2023 – Aug 2026"),
        ("TecMilenio University",
         "Software Development Engineering (BS) — GPA: 93/100 — Merit Scholarship (€2,000/year)",
         "Jan 2021 – Dec 2027")
    ]

    let experience: [(title: String, place: String, date: String, bullets: [String])] = [
        ("Nextise GmbH — Project Management Intern",
         "Stuttgart (Hybrid), Germany",
         "May 2025 – Jun 2025",
         [
            "Supported collaboration between programming team (Cameroon) and sales division (Germany).",
            "Translated client needs into technical requirements and facilitated stakeholder communication."
         ]),
        ("Computation BYTE — IT Sales & Project Consultant",
         "Mexico City (Hybrid), Mexico",
         "Jun 2020 – Apr 2025",
         [
            "Worked in IT sales + PM as government supplier; participated in local/state/federal tenders across 15+ cities.",
            "DIF Web-App DB (€120k+): supervised field-testing and implementation; 20,000+ registrations in 80+ localities.",
            "Creel Airport Security (€50k+): won federal tender; managed logistics, delivery, and installation with MX/US suppliers."
         ])
    ]

    let projects: [(name: String, tech: String, bullets: [String])] = [
        ("Transformers T5 Fine-Tuning — Semantic Relations in Noun Compounds",
         "TensorFlow, transformers, SHAP",
         [
            "Fine-tuned T5 on 33,000+ noun compounds; improved performance from near-zero to 90%+ F1.",
            "Zero-shot vs fine-tuned eval + SHAP token explainability + metric visualizations."
         ]),
        ("Stock Trend Prediction with Sentiment & Neural Networks",
         "Python, PyTorch, Optuna, Pandas",
         [
            "Built pipeline with ~9,200 daily samples (2015–2025) + 80,000+ tweets; engineered 36+ features.",
            "Benchmarked LR/RF/GB + LSTM/BiLSTM/1D-CNN across horizons; neural models captured temporal signal better."
         ])
    ]

    let skills: [String] = [
        "Python", "SQL", "Java", "C++", "R", "GitHub",
        "PyTorch", "TensorFlow", "Pandas", "NumPy"
    ]

    // MARK: - UI State (requeridos)
    @State private var mostrarSecciones: Bool = true       // Toggle
    @State private var tamañoTexto: Double = 17            // Slider
    @State private var mostrarAlerta: Bool = false         // Button + Alert

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {

                headerCard

                // Toggle (mostrar/ocultar secciones)
                Toggle("Mostrar secciones del CV", isOn: $mostrarSecciones)

                // Slider (tamaño texto)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Tamaño de texto: \(Int(tamañoTexto))")
                        .font(.subheadline)
                        .opacity(0.8)
                    Slider(value: $tamañoTexto, in: 14...24, step: 1)
                }

                // Botón + alerta
                Button("Ver resumen") { mostrarAlerta = true }
                    .buttonStyle(.borderedProminent)

                if mostrarSecciones {
                    sectionCard(
                        title: "Perfil",
                        content: AnyView(
                            Text(perfil)
                                .font(.system(size: tamañoTexto))
                                .opacity(0.9)
                        )
                    )

                    educationCard
                    experienceCard
                    projectsCard
                    skillsCard
                }
            }
            .padding()
        }
        .alert("Resumen", isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("\(nombre)\nEducation: \(education.count)\nExperience: \(experience.count)\nProjects: \(projects.count)")
        }
    }

    // MARK: - Cards

    private var headerCard: some View {
        HStack(alignment: .top, spacing: 12) {

            // Image (foto real)
            Image("profile") // <- Asset name en Xcode: Assets.xcassets
                .resizable()
                .scaledToFill()
                .frame(width: 74, height: 74)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 6) {
                Text(nombre)
                    .font(.system(size: tamañoTexto + 6, weight: .bold))

                Text(ubicacion)
                    .font(.system(size: tamañoTexto, weight: .semibold))
                    .opacity(0.85)

                // Contacto con ForEach (tuplas)
                ForEach(contacto.indices, id: \.self) { i in
                    let c = contacto[i]
                    Text("\(c.label): \(c.value)")
                        .font(.system(size: tamañoTexto - 3))
                        .opacity(0.8)
                }
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }

    private var educationCard: some View {
        sectionCard(title: "Education", content: AnyView(
            VStack(alignment: .leading, spacing: 10) {
                ForEach(education.indices, id: \.self) { i in
                    let e = education[i]
                    VStack(alignment: .leading, spacing: 3) {
                        Text(e.title).font(.system(size: tamañoTexto, weight: .semibold))
                        Text(e.detail).font(.system(size: tamañoTexto - 2)).opacity(0.85)
                        Text(e.date).font(.system(size: tamañoTexto - 3)).opacity(0.7)
                    }
                    if i != education.count - 1 { Divider() }
                }
            }
        ))
    }

    private var experienceCard: some View {
        sectionCard(title: "Experience", content: AnyView(
            VStack(alignment: .leading, spacing: 12) {
                ForEach(experience.indices, id: \.self) { i in
                    let x = experience[i]
                    VStack(alignment: .leading, spacing: 6) {
                        Text(x.title).font(.system(size: tamañoTexto, weight: .semibold))
                        Text("\(x.place) • \(x.date)")
                            .font(.system(size: tamañoTexto - 3))
                            .opacity(0.75)

                        ForEach(x.bullets.indices, id: \.self) { j in
                            Text("• \(x.bullets[j])")
                                .font(.system(size: tamañoTexto - 2))
                                .opacity(0.85)
                        }
                    }
                    if i != experience.count - 1 { Divider() }
                }
            }
        ))
    }

    private var projectsCard: some View {
        sectionCard(title: "Projects", content: AnyView(
            VStack(alignment: .leading, spacing: 12) {
                ForEach(projects.indices, id: \.self) { i in
                    let p = projects[i]
                    VStack(alignment: .leading, spacing: 6) {
                        Text(p.name).font(.system(size: tamañoTexto, weight: .semibold))
                        Text(p.tech).font(.system(size: tamañoTexto - 3)).opacity(0.75)

                        ForEach(p.bullets.indices, id: \.self) { j in
                            Text("• \(p.bullets[j])")
                                .font(.system(size: tamañoTexto - 2))
                                .opacity(0.85)
                        }
                    }
                    if i != projects.count - 1 { Divider() }
                }
            }
        ))
    }

    private var skillsCard: some View {
        sectionCard(title: "Skills", content: AnyView(
            let cols = [GridItem(.adaptive(minimum: 90), spacing: 8)]
            return LazyVGrid(columns: cols, alignment: .leading, spacing: 8) {
                ForEach(skills, id: \.self) { s in
                    Text(s)
                        .font(.system(size: tamañoTexto - 3, weight: .medium))
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 999)
                                .fill(Color(.secondarySystemBackground))
                        )
                }
            }
        ))
    }

    private func sectionCard(title: String, content: AnyView) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: tamañoTexto + 2, weight: .bold))
            content
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(radius: 1)
        )
    }
}
