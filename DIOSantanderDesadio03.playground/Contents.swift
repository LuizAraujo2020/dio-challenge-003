import UIKit

enum Tipo: String {
    case moto, carro, bicicleta
}

class Veiculo: Identifiable {
    let id = UUID()
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

    init(pessoas: Int, rodas: Int, velocidade: Double, abastecer: @escaping () -> Void) {
        super.init(pessoas: pessoas, rodas: rodas, velocidade: velocidade, tipo: .moto, abastecer: abastecer)
    }
}

class Carro: Veiculo {

    init(pessoas: Int, rodas: Int, velocidade: Double, abastecer: @escaping () -> Void) {
        super.init(pessoas: pessoas, rodas: rodas, velocidade: velocidade, tipo: .moto, abastecer: abastecer)
    }
}

class Bicicleta: Veiculo {

    init(pessoas: Int, rodas: Int, velocidade: Double, abastecer: @escaping () -> Void) {
        super.init(pessoas: pessoas, rodas: rodas, velocidade: velocidade, tipo: .moto, abastecer: abastecer)
    }
}

let veiculos: [Veiculo] = [
    Moto(pessoas: 2, rodas: 2, velocidade: 299) {
        print("Abastecido: R$10,00")
    },
    Carro(pessoas: 5, rodas: 4, velocidade: 199) {
        print("Abastecido: R$150,00")
    },
    Carro(pessoas: 5, rodas: 4, velocidade: 230) {
        print("Abastecido: R$100,00")
    },
    Bicicleta(pessoas: 1, rodas: 2, velocidade: 20) {
        print("Bateria carregada por: 2h")
    }
]

func moverVeiculos(vaiculos: [Veiculo]) {
    Task {
        for veiculo in veiculos {
            async let _ = await veiculo.mover()
        }
    }
}

moverVeiculos(vaiculos: veiculos)
