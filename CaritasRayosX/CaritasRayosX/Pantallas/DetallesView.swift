//
//  DetallesView.swift
//  CaritasRayosX
//
//  Created by Alumno on 06/09/23.
//

import SwiftUI

enum Motivo: String, CaseIterable, Identifiable {
    case enfermo, noEstaba, noDinero
    var id: Self { self }
}


struct DetallesView: View {
    @State private var estatus: Int = 1
    @State var recibo: RECIBOS
    @State var donante: DONANTES
    @State private var isValid = false
    @State private var texto : String = ""
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedMotivo: Motivo = .noDinero


    var body: some View {
        ZStack{
            
            BackgroundView()
            VStack{
                Button(action: {}){
                    HStack{
                        Image(systemName: "arrowshape.turn.up.backward.2")
                            .resizable(resizingMode: .stretch)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                        Text("Atrás")
                            .font(.title3)
                            
                    }
                    .onTapGesture {
                        self.isValid = validate()
                        if self.isValid{
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }

            }
            .foregroundColor(.white)
            .padding(.top, -380.0)
            .padding(.leading, -170)
            
        
            
            
            VStack(alignment: .center){
                
                VStack{
                    HStack { //Nombre
                        Text(donante.NOMBRE + " " + donante.A_PATERNO)
                            .font(.system(size: 35))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("Azul oscuro"))
                    }
                    .padding(.top, 50.0)
                    .padding(.bottom, 20.0)
                    .padding(.horizontal, 10.0)
                    
                    
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Monto:")
                            .font(.system(size: 23))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Azul oscuro"))
                            .padding(.leading, 5)
                        Spacer()
                        Text("$" + String(recibo.IMPORTE))
                            .font(.system(size: 35))
                            .bold()
                            .foregroundColor(Color("Gris"))
                            .multilineTextAlignment(.leading)
                            .frame(width: 150.0)
                    }
                    .padding(.bottom, 30.0)
                    .padding(.horizontal, 30.0)
                    
                    
                    
                    
                    
                    HStack(alignment: .center) {
                        Text("Contacto:")
                            .font(.system(size: 23))
                            .fontWeight(.bold)
                            .foregroundColor(Color("Azul oscuro"))
                            .padding(.leading, 5)
                        Spacer()
                        VStack{
                            Text(donante.TELEFONO)//telefono
                                .font(.system(size: 20))
                                .foregroundColor(Color("Gris"))
                                .multilineTextAlignment(.trailing)
                                .frame(width: 180)
                                .padding(.bottom, 1)
                        }
                    }
                    .padding(.horizontal, 20.0)
                    .padding(.bottom, 70.0)
                    
                    
                    
                    ZStack{
                        HStack {
                            if (estatus == 1) {
                                Color("VerdePicker")
                            } else if (estatus == 2) {
                                Color("RojoPicker")
                            } else {
                                Color("Gris")
                            }
                        }
                        .frame(width: 310.0, height: 60.0)
                        .cornerRadius(10.0)
                        HStack {
                            Picker(selection: $estatus, label: Text("Picker")){
                                Text("Cobrado").fontWeight(.heavy).tag(1)
                                Text("No cobrado").fontWeight(.heavy).tag(2)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .scaledToFit()
                            .scaleEffect(CGSize(width: 1.0, height: 1.5))
                            .frame(width: 300.0, height: 50.0)
                            .background(RoundedRectangle(cornerRadius: 5.0).fill(Color.white))
                            
                        }
                    }
                }
                
                
                Spacer()
                Spacer()
                
                
                VStack{
                    if estatus==2{
                        VStack(alignment: .center){
                            Spacer()
                            Text("Comentarios:")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(Color("Azul oscuro"))
                            Picker("Comentarios", selection: $texto) {
                                Text("").tag("")
                                Text("Estaba enfermo").tag("Estaba enfermo")
                                Text("No estaba").tag("No estaba")
                                Text("No tenia el dinero").tag("No tenia el dinero")
                            }
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 275.0)
                            .font(.title)
                            .bold()
                            .accentColor(Color("Azul oscuro"))
                            .onChange(of: texto) {value in
                                
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.black, lineWidth: 0.35))
                            .frame(width: 300, height: 60.0)
                            .clipped()
                            
                        }
                        .onAppear(){
                            texto = recibo.COMENTARIOS
                        }
                        
                        .padding(.bottom, 30.0)
                        .padding(.horizontal, 30.0)
                    }
                    
                    
                    
                    
                    NavigationStack{
                        HStack(alignment: .top){
                            Button{}
                            label: {
                                Text("Actualizar")
                                    .padding(20)
                                    .frame(width: 330.0, height: 70.0)
                                    .font(.headline)
                                    .background(Color("Azul oscuro"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 20.0)
                                    .padding(.bottom, 20.0)
                                    .onTapGesture {
                                        self.isValid = validate()
                                        if self.isValid {
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                            }
                                
                                
                        }
                            
                    }
                }
                .padding(.bottom, 30.0)
                Spacer()
                
                
                
                
            }
            .background(.white)
            .cornerRadius(35)
            .overlay(RoundedRectangle(cornerRadius: 35).stroke(Color("Rosa"), lineWidth: 4))
            .padding(.top, 110.0)
            .padding(.horizontal, 20.0)
            
        }
        .background(Color("Rosa"))
        .onAppear(){
            estatus = recibo.ID_ESTATUS
            donante = traerDonante(idD: recibo.ID_DONANTE)
            texto=recibo.COMENTARIOS
        }
    }
    
        
    
    private func validate() -> Bool {
        enviarEstatus(estatus: estatus, idRecibo: recibo.id)
        enviarComentarios(comentarios: texto, idRecibo: recibo.id)
        return true
    }
    
}


struct DetallesView_Previews: PreviewProvider {
    static var previews: some View {
        DetallesView(recibo: listaRecibos[0], donante: listaDonantes[0])
    }
}
