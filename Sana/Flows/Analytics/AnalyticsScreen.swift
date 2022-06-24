//
//  AnalyticsScreen.swift
//  Sana
//
//  Created by Rustam-Deniz Emirali on 21.06.2022.
//

import SwiftUI
import SwiftUICharts

struct AnalyticsScreen: View {
    let income: Double = 200000
    let expenses: Double = 100000
    
    var body: some View {
        ZStack {
            ScrollView {
    
                VStack {
                    HStack {
                        Text("June 2022")
                            .foregroundColor(Color.accentBlue)
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.leading, 24)
                            .padding(.top, 24)
                            .padding(.bottom, 16)
                        Spacer()
                        Image("IconNotification")
                            .foregroundColor(.accentBlue)
                            .frame(width: 24, height: 24)
                        Image("IconAdd")
                            .foregroundColor(.accentBlue)
                            .frame(width: 24, height: 24)
                            .padding(.leading, 24)
                            .padding(.trailing, 24)
                    }
                        .background(Color.white)
        
                    VStack(alignment: .leading, spacing: 16) {
                        ZStack {
                            VStack(spacing: 0) {
                                HStack {
                                    Text("June cash flow")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.dark)
                                    Spacer()
                                    Button(action: {}) {
                                        Text("See all")
                                            .font(.footnote)
                                            .foregroundColor(.accentBlue)
                                    }
                                }
                                    .padding(.top, 24)
                                    .padding(.horizontal, 16)
                                HStack() {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("Left")
                                            .font(.caption)
                                            .foregroundColor(.dark60)
                                        Text("362 500 ₸")
                                            .font(.title2)
                                            .foregroundColor(.dark)
                                    }
                                    Spacer()
                                }
                                    .padding(.top, 16)
                                    .padding(.horizontal, 16)
                                VStack {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 3) {
                                            Text("Income")
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                            Text("600 000 ₸")
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                        }
                                        Spacer()
                                        VStack(alignment: .trailing, spacing: 3) {
                                            Text("Expense")
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                            Text("237 500 ₸")
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                    HStack(alignment: .bottom) {
                            
                                        VStack(alignment: .leading) {
                                
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color(uiColor: UIColor(red: 0.039, green: 0.773, blue: 0.639, alpha: 1)))
                                                .frame(height: income * 100 / (income + expenses))
                                        }
                                        VStack(alignment: .trailing) {
                                
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color(uiColor: UIColor(red: 0.941, green: 0.431, blue: 0.384, alpha: 1)))
                                                .frame(height: expenses * 100 / (income + expenses))
                                        }
                                    }
                                }
                                    .padding(.horizontal, 16)
                                    .padding(.top, 16)
                                    .padding(.bottom, 24)
                            }
                        }
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 0.35, x: 0, y: 1)
            
                        ZStack {
                            VStack(spacing: 0) {
                                HStack {
                                    Text("June spending categories")
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.dark)
                                    Spacer()
                                    Button(action: {}) {
                                        Text("See all")
                                            .font(.footnote)
                                            .foregroundColor(.accentBlue)
                                    }
                                }
                                    .padding(.top, 24)
                                    .padding(.horizontal, 16)
                                HStack() {
                                    VStack(alignment: .leading, spacing: 0) {
                                        Text("You've spent")
                                            .font(.caption)
                                            .foregroundColor(.dark60)
                                        Text("237 500 ₸")
                                            .font(.title2)
                                            .foregroundColor(.dark)
                                    }
                                    Spacer()
                                }
                                    .padding(.top, 16)
                                    .padding(.horizontal, 16)
                                PieChartView(data: [8,23,54,32], title: "", legend: nil, style: .init(backgroundColor: .white, accentColor: .orange, gradientColor: .init(start: .orange, end: .orange), textColor: .black, legendTextColor: .black, dropShadowColor: .white), form: ChartForm.extraLarge, dropShadow: false, valueSpecifier: "")
                                VStack(alignment: .leading) {
                                    HStack() {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12).fill(Color.accentBlue)
                                            Text("Groceries 85 000 ₸")
                                                .foregroundColor(.white)
                                                .font(.caption2)
                                                .fontWeight(.semibold)
                                        }
                                            .frame(height: 30)
                            
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12).fill(Color.accentBlue)
                                            Text("Pharmacy 61 750 ₸")
                                                .foregroundColor(.white)
                                                .font(.caption2)
                                                .fontWeight(.semibold)
                                        }
                                            .frame(height: 30)
                                        Spacer()
                                    }
                                        .padding(.horizontal, 16)
                                    HStack() {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12).fill(Color.accentBlue)
                                            Text("Restaurants 30 875 ₸")
                                                .foregroundColor(.white)
                                                .font(.caption2)
                                                .fontWeight(.semibold)
                                        }
                                            .frame(height: 30)
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12).fill(Color.accentBlue)
                                            Text("Other 35 625 ₸")
                                                .foregroundColor(.white)
                                                .font(.caption2)
                                                .fontWeight(.semibold)
                                        }
                                            .frame(height: 30)
                                        Spacer()
                                    }
                                        .padding(.bottom, 16)
                                        .padding(.horizontal, 16)
                                }
                            }
                        }
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 0.35, x: 0, y: 1)
                        Spacer()
                    }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                }
            }

        }
            .background(Color.extraWhite)
    }
}

struct AnalyticsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsScreen()
    }
}
