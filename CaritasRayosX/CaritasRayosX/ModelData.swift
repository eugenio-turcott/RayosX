//
//  ModelData.swift
//  CaritasRayosX
//
//  Created by Alumno on 06/09/23.
//

import Foundation

var idR: String = "0"

func loginVeriD(nombre:String, contrasenaI:String) -> String{
    var lista: Array<recolector> = []
    var contrasena: String = ""
    guard let url = URL(string: "http://10.14.255.65:10206/crud/read?NOMBRE=\(nombre)") else{
        print("Error en hacer crud")
        return "Error"
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        
        let jsonDecoder = JSONDecoder()
        if(data != nil){
            do{
                let recolectorList = try jsonDecoder.decode([recolector].self, from: data!)
                lista = recolectorList
                for recolector in recolectorList{
                    contrasena = recolector.CONTRASENA
                    print(idR)
                    print("Id: \(recolector.id) - Titulo: \(recolector.NOMBRE)")
                    idR = recolector.id
                    print(idR)
                }
            }catch{
                print(error)
            }
        }
        group.leave()
    }
    task.resume()
    group.wait()
    
    if lista.isEmpty {
        return "Error"
    }
    else{
        if (contrasena == contrasenaI){
            return idR
        }
        else{
            return "Error"
        }
    }
    
}

func loginVer(nombre:String, contrasenaI:String) -> Bool{
    var lista: Array<recolector> = []
    var contrasena: String = ""
    guard let url = URL(string: "http://10.14.255.65:10206/crud/read?NOMBRE=\(nombre)") else{
        print("Error en hacer crud")
        return false
    }
    
    let group = DispatchGroup()
    group.enter()
    
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        
        let jsonDecoder = JSONDecoder()
        if(data != nil){
            do{
                let recolectorList = try jsonDecoder.decode([recolector].self, from: data!)
                lista = recolectorList
                for recolector in recolectorList{
                    contrasena = recolector.CONTRASENA
                    print(idR)
                    print("Id: \(recolector.id) - Titulo: \(recolector.NOMBRE)")
                    idR = recolector.id
                    print(idR)
                }
            }catch{
                print(error)
            }
        }
        group.leave()
    }
    task.resume()
    group.wait()
    
    if lista.isEmpty {
        return false
    }
    else{
        if (contrasena == contrasenaI){
            return true
        }
        else{
            return false
        }
    }
    
}

var listaRecibos = callRecibos(idEnCall: idR)

func callRecibos(idEnCall: String) -> Array<recibos>{
    var listaRecibos: Array<recibos> = []
    print("Entre a funcion")
    print("Antes de query http://10.14.255.65:10206/crud/readReciboxIdR?id=\(idEnCall)")
    guard let url = URL(string: "http://10.14.255.65:10206/crud/readReciboxIdR?id=\(idEnCall)") else{
        /*listaRecibos[0] = recibos(id:3, aPaterno: "Mama", comentarios:"", email:"", estatusPago: "", idDireccionCobro: "1", idRecolector: "0", importe: 200, nombre: "eugenio", telMovil: "")*/
        print("http://10.14.255.65:10206/crud/readReciboxIdR?id=\(idEnCall)")
        return listaRecibos
    }

    let group = DispatchGroup()
    group.enter()

    let task = URLSession.shared.dataTask(with: url){
        data, response, error in

        let jsonDecoder = JSONDecoder()
        if(data != nil){
            do{
                let decodeRecibos = try jsonDecoder.decode([recibos].self, from: data!)
                listaRecibos = decodeRecibos
                for recibosItem in decodeRecibos{
                    print("Id: \(recibosItem.id) - Nombre: \(recibosItem.NOMBRE)")
                }
            }catch{
                print(error)
            }
        }
        group.leave()
    }
    task.resume()
    group.wait()
    return listaRecibos

}
