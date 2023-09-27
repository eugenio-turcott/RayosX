//
//  ListaDeRecibos.swift
//  CaritasRayosX
//
//  Created by Alumno on 06/09/23.
//

//
//Llamar a callRecibos(idrecolector)
//

import SwiftUI

struct ListaDeRecibos: View {
    @State private var listaRecibos: Array<RECIBOS> = []
    var body: some View {
        NavigationStack {
            ZStack {
                HStack {
                    Image("logo")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        
                }
                .frame(width: 205.0)
                .padding(.top, -425.0)
                VStack {
                    HStack {
                    }
                    .padding(.bottom, 20.0)
                    VStack {
                        HStack {
                            Text("Recibos")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .fontWeight(.bold)
                        }
                        .padding(.top, 15.0)
                        List(listaRecibos){
                            recibosItem in
                            NavigationLink{
                                DetallesView(recibo: recibosItem, donante: DONANTES(A_MATERNO: "", A_PATERNO: "", EMAIL: "", FECHA_NAC: "", NOMBRE: "", TELEFONO: "", id: 0))
                            }
                            label:{
                                donanteRow(recibo: recibosItem, donante: DONANTES(A_MATERNO: "", A_PATERNO: "", EMAIL: "", FECHA_NAC: "", NOMBRE: "", TELEFONO: "", id: 0))
                        }
                    }
                    .padding(.top, -15.0)
                    .listStyle(.inset)
                }
                .background(.white)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Rosa"), lineWidth: 5))
                
                .padding(.horizontal, 5.0)
                .padding()
            }
            .onAppear(){
                listaRecibos = callRecibos(idR: UserDefaults.standard.integer(forKey:"idR"))
            }
            }
            .background(Color(red: 17/255, green: 151/255, blue: 165/255))
        }
    }
}

struct ListaDeRecibos_Previews: PreviewProvider {
    static var previews: some View {
        ListaDeRecibos()
    }
}
