import SwiftUI

struct CustomTabView: View {
    
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    @Binding var showDetailPage: Bool
    @Binding var showMessagePage: Bool
    
    let tabBarItems: [(image: String, title: String)] = [
        ("map", "places-string".localized),
        ("news", "news-string".localized),
        ("cloud", "weather-string".localized),
        ("message", "profile-string".localized)
    ]
    
    var body: some View {
        ZStack{
            HStack(spacing: 50){
                ForEach(0..<4){ index in
                    Button(action: {
                        if !showDetailPage {
                            tabSelection = index + 1
                        }
                    }){
                        VStack(spacing: nil){
                            Spacer()
                            
                            Image(index + 1 == tabSelection ? "\(tabBarItems[index].image).fill" : tabBarItems[index].image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 28, height: 28)
                            
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .frame(height: 60)
            .offset(y: showDetailPage ? 120 : 0)
            .offset(x: showMessagePage ? 120 : 0)
        }
        .padding(.horizontal)
    }
}

//struct CustomTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTabView(tabSelection: .constant(1), showDetailPage: .constant(false))
//            .previewLayout(.sizeThatFits)
//            .padding(.vertical)
//    }
//}
