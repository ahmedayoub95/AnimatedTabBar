//
//  Home.swift
//  AnimatedTabBar
//
//  Created by Ahmed Ayoub on 25/04/2021.
//

import SwiftUI

struct Home: View {
	@State var selectedTab = "house"
    var body: some View {
		ZStack(alignment: .bottom, content: {
			Color(.systemIndigo)
				.ignoresSafeArea()
			
			//Custom Tab Bar
			CustomTabBar(selectedTab: $selectedTab)
		})
	
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
