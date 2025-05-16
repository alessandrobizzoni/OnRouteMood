//
//  ORMSubmittedFormsView.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 16/5/25.
//

import SwiftUI

struct ORMSubmittedFormsView: View {
    
    var viewModel: ORMMainViewModel
    
    @Binding var showBugList: Bool
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                
                Button("Report a Bug") {
                    showBugList = false
                }
            }
            .padding()
            
            VStack(spacing: 12) {
                ForEach(viewModel.completedForms) { form in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(form.firstName) \(form.surname)")
                            .font(.headline)
                        Text("Email: \(form.email)")
                            .font(.subheadline)
                        if !form.phone.isEmpty {
                            Text("Phone: \(form.phone)")
                        }
                        Text("Date & Time: \(form.date.formatted(date: .abbreviated, time: .shortened))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Divider()
                        Text(form.description)
                            .font(.body)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                }
            }
            .padding()
        }
        .padding()
    }
}
