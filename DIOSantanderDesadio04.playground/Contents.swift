import UIKit

enum Tipo: String {
    case moto, carro, bicicleta
}

protocol Veiculo: Identifiable {
    var id: UUID { get }
    var pessoas: Int { get }
    var rodas: Int { get }
    var velocidade: Double { get }
    var tipo: Tipo { get }
    var abastecer: () -> Void { get }
}

extension Veiculo {
    var id: UUID { UUID() }

    func mover() async {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.1..<1.0)) {

            switch self.tipo {
                case .bicicleta: print("Acelerando a \(self.velocidade)km/h")
                case .carro: print("Acelerando a \(self.velocidade)km/h")
                case .moto: print("Acelerando a \(self.velocidade)km/h")
            }
        }
    }
}

class Moto: Veiculo {
    let pessoas: Int
    let rodas: Int
    let velocidade: Double
    let tipo: Tipo
    let abastecer: () -> Void

    init(pessoas: Int,
         rodas: Int,
         velocidade: Double,
         tipo: Tipo,
         abastecer: @escaping () -> Void) {
        self.pessoas = pessoas
        self.rodas = rodas
        self.velocidade = velocidade
        self.tipo = tipo
        self.abastecer = abastecer
    }
}

class Carro: Veiculo {
    let pessoas: Int
    let rodas: Int
    let velocidade: Double
    let tipo: Tipo
    let abastecer: () -> Void

    init(pessoas: Int,
         rodas: Int,
         velocidade: Double,
         tipo: Tipo,
         abastecer: @escaping () -> Void) {
        self.pessoas = pessoas
        self.rodas = rodas
        self.velocidade = velocidade
        self.tipo = tipo
        self.abastecer = abastecer
    }
}

class Bicicleta: Veiculo {
    let pessoas: Int
    let rodas: Int
    let velocidade: Double
    let tipo: Tipo
    let abastecer: () -> Void

    init(pessoas: Int,
         rodas: Int,
         velocidade: Double,
         tipo: Tipo,
         abastecer: @escaping () -> Void) {
        self.pessoas = pessoas
        self.rodas = rodas
        self.velocidade = velocidade
        self.tipo = tipo
        self.abastecer = abastecer
    }
}

let veiculos: [any Veiculo] = [
    Moto(pessoas: 2, rodas: 2, velocidade: 299, tipo: .moto) {
        print("Abastecido: R$10,00")
    },
    Carro(pessoas: 5, rodas: 4, velocidade: 199, tipo: .carro) {
        print("Abastecido: R$150,00")
    },
    Carro(pessoas: 5, rodas: 4, velocidade: 230, tipo: .carro) {
        print("Abastecido: R$100,00")
    },
    Bicicleta(pessoas: 1, rodas: 2, velocidade: 20, tipo: .bicicleta) {
        print("Bateria carregada por: 2h")
    }
]

func moverVeiculos(vaiculos: [any Veiculo]) {
    Task {
        for veiculo in veiculos {
            async let _ = await veiculo.mover()
        }
    }
}

moverVeiculos(vaiculos: veiculos)
