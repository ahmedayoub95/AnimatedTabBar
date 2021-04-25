//
//  CustomTabBar.swift
//  AnimatedTabBar
//
//  Created by Ahmed Ayoub on 25/04/2021.
//

import SwiftUI

struct CustomTabBar: View {
	@Binding var selectedTab:String
	
	//Storing each tab midpoints to animate
	@State var tabPoints: [CGFloat] = []
	
    var body: some View {
		HStack(spacing:0){
			
			//Tab bar buttons here...
			TabBarButton(selectedTab: $selectedTab, tabPoints:$tabPoints, image:"house")
			TabBarButton(selectedTab: $selectedTab, tabPoints:$tabPoints, image:"bookmark")
			TabBarButton(selectedTab: $selectedTab, tabPoints:$tabPoints, image:"message")
			TabBarButton(selectedTab: $selectedTab, tabPoints:$tabPoints, image:"person")
		}
		.padding()
		.background(Color.white
						.clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
		)
		.overlay(
				Circle()
					.fill(Color.white)
					.frame(width: 10, height: 10)
					.offset(x:getCurvePoint() - 20)
			,alignment: .bottomLeading
		)
		.cornerRadius(30)
		.padding(.horizontal)
    }
	func getCurvePoint()->CGFloat{
		if tabPoints.isEmpty{
			return 10
		}else{
			switch selectedTab {
			case "house":
				return tabPoints[0]
			case "bookmark":
				return tabPoints[1]
			case "message":
				return tabPoints[2]
			default:
				return tabPoints[3]
					
			}
		}
	}
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TabBarButton: View{
	
	@Binding var selectedTab:String
	@Binding var tabPoints: [CGFloat]
	var image:String
	
	var body: some View{
		
		GeometryReader{reader -> AnyView in

			let midX = reader.frame(in: .global).midX
			
			DispatchQueue.main.async {
				
				if tabPoints.count <= 4{
					tabPoints.append(midX)
				}
			}
			
			return AnyView(
				Button(action: {
					//changing tab with animation
					withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)){
						selectedTab = image
					}
					
				}, label: {
					Image(systemName: "\(image)\(selectedTab == image ? ".fill":"")")
						.font(.system(size: 25, weight: .semibold))
						.foregroundColor(Color(.black))
						//Lifting View
						//If it is selected
						.offset(y:selectedTab == image ? -10:0)
				})
				//Max frame
				.frame(maxWidth: .infinity,maxHeight:.infinity)

			)
	
		}
		.frame(height:50)
	}
	
}
