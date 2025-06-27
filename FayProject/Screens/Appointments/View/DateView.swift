//
//  DateView.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import SwiftUI

struct DateView: View {
    enum Theme {
        case upcoming, past
        
        var monthBackgroundColor: Color {
            switch self {
            case .upcoming:
                Color.secondaryTheme
            case .past:
                Color.tertiaryBackground
            }
        }
        
        var monthTextColor: Color {
            switch self {
            case .upcoming:
                Color.primaryTheme
            case .past:
                Color.primaryText
            }
        }
    }
    let date: Date
    let theme: Theme
    
    var body: some View {
        VStack(spacing: .zero) {
            Text(month)
                .foregroundStyle(theme.monthTextColor)
                .font(.caption)
                .frame(height: 18)
                .frame(maxWidth: .infinity)
                .background(theme.monthBackgroundColor)
            Text(day)
                .bold()
                .foregroundStyle(Color.primaryText)
                .frame(maxHeight: .infinity)
        }
        .frame(width: 48, height: 48)
        .background(Color.secondaryBackground)
        .cornerRadius(3.6)
    }
    
    private var month: String {
        date.formatted(Date.FormatStyle().month(.abbreviated)).uppercased()
    }
    
    private var day: String {
        date.formatted(Date.FormatStyle().day())
    }
}

#Preview {
    Group {
        DateView(date: Date(), theme: .upcoming)
        DateView(date: Date(), theme: .past)
    }
}
