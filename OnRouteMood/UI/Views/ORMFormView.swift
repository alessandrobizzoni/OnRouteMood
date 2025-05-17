//
//  ORMFormView.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 16/5/25.
//

import SwiftUI

struct ORMFormView: View {
    
    @Binding var isShowingForm: Bool
    
    @Binding var showBugList: Bool
    
    var viewModel: ORMMainViewModel
    
    @State private var firstName = ""
    
    @State private var surname = ""
    
    @State private var email = ""
    
    @State private var phone = ""
    
    @State private var date = Date()
    
    @State private var description = ""
    
    @State private var showValidationError = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User information")) {
                    validatedTextField("*Name", text: $firstName, isValid: !firstName.isEmpty)
                    validatedTextField("*Surname", text: $surname, isValid: !surname.isEmpty)
                    validatedTextField("*Email", text: $email, isValid: isValidEmail(email))
                        .keyboardType(.emailAddress)
                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)
                    
                }
                
                Section(header: Text("Error details")) {
                    DatePicker(
                        "Date & Time",
                        selection: $date,
                        in: ...Date(),
                        displayedComponents: [
                            .date,
                            .hourAndMinute
                        ]
                    )
                    .tint(.reversePrimaryORM)
                    
                    TextEditor(text: $description)
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    showValidationError && description.isEmpty ? Color.red : Color.gray.opacity(0.4),
                                    lineWidth: 1
                                )
                        )
                    
                    Text("\(description.count)/200")
                        .font(.caption)
                        .foregroundColor(description.count > 200 ? .red : .gray)
                }
                
                Section {
                    Button("Enviar") {
                        sendFormData()
                    }
                    .disabled(description.count > 200)
                    
                    if !viewModel.completedForms.isEmpty {
                        Button("Completed Reports") {
                            showBugList = true
                        }
                    }
                }
            }
            .navigationTitle("Report a Bug")
            .alert("Invalid Form", isPresented: $showValidationError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Please fill in all required fields correctly.")
            }
        }
    }
}

private extension ORMFormView {
    private func validatedTextField(_ title: String, text: Binding<String>, isValid: Bool) -> some View {
        TextField(title, text: text)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(showValidationError && !isValid ? Color.red : Color.clear, lineWidth: 1)
            )
    }
}

private extension ORMFormView {
    var validateForm: Bool {
        return !firstName.isEmpty &&
        !surname.isEmpty &&
        isValidEmail(email) &&
        !description.isEmpty &&
        description.count <= 200
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let regex = #"^\S+@\S+\.\S+$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }
    
    func sendFormData() {
        if validateForm {
            viewModel.saveForm(
                firstName: firstName,
                surname: surname,
                email: email,
                phone: phone,
                date: date,
                description: description
            )
            isShowingForm = false
        } else {
            showValidationError = true
        }
    }
}
