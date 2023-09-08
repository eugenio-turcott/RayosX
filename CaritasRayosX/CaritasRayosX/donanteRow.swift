//
//  donanteRow.swift
//  CaritasRayosX
//
//  Created by Alumno on 06/09/23.
//

import SwiftUI

struct donanteRow: View {
    var recibos:recibos
    @State private var estatus: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Text("\(recibos.NOMBRE) \(recibos.A_PATERNO)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0/255, green: 59/255, blue: 92/255))
                    .padding(.leading, 30.0)
                    .padding(.top, 10.0)
                    .offset(y:5)
                
                Spacer()
                Image("simboloInfo2")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45.0)
                    .offset(y: 10)
                Spacer()
            }
            HStack{
                Spacer()
                Picker(selection: $estatus, label: Text("Picker")){
                    Text("No localizado").tag("No localizado")
                    Text("Pagado").tag("Pagado")
                    Text("No pagado").tag("No pagado")
                }.padding(.leading, 10.0).frame(width: 330.0, height: 50.0).pickerStyle(.segmented)
                Spacer()
            }
            // Opciones de estatus
        }
        
    }
}

struct donanteRow_Previews: PreviewProvider {
    static var previews: some View {
        donanteRow(recibos: listaRecibos[0])
    }
}
