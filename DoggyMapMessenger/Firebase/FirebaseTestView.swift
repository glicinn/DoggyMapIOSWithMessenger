////
////  FirebaseTestView.swift
////  DoggyMap
////
////  Created by Дмитрiй Дѣренъ on 25.04.2023.
////
//
//import SwiftUI
//import Firebase
//
//struct FirebaseTestView: View {
//    
//    @ObservedObject var model = FirebaseTestViewModel()
////    @ObservedObject var mapmodel = MapFirebaseViewModel()
//    
//    @State var name = ""
//    @State var surname = ""
//    @State var login = ""
//    
//    var body: some View {
//        
//        VStack{
////                        List (model.list){ item in
////                            Text(item.name)
////                        }
//            
//            //            Divider()
//            
//            VStack(spacing: 5){
//                VStack{
//                    TextField("Login", text: $login)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    TextField("Name", text: $name)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                    TextField("Surname", text: $surname)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                }
//                .padding(.bottom, 40)
//                
//                
//                Button(action: {
//                    // Call addData
//                    model.addData(name: name, surname: surname, login: login)
//                    
//                    // Clear TexrFields
//                    login=""
//                    name=""
//                    surname=""
//                }){
//                    
//                    Text("Add ")
//                        .frame(width: UIScreen.main.bounds.size.width - 50)
//                        .frame(minHeight: 55,
//                               maxHeight: UIScreen.main.bounds.size.height/15)
//                        .bold()
//                        .font(Font.custom("Avenir", size: 22))
//                        .background(Color.black)
//                        .foregroundColor(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                    
//                }
//                
//                //                Button(action: {
//                //                    // Call addData
//                //                }){
//                //                    Text("MapList")
//                //                }
//            }
//            .padding()
//            
//        }
//        
//    }
//    
//    init(){
//        model.getData()
//        //        mapmodel.getData()
//    }
//}
//
//struct FirebaseTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        FirebaseTestView()
//    }
//}
//
//
