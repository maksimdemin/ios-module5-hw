import UIKit

//Home work Module 5
//Created by Demin Maksim


//  1) В чем различие между классом и объектом?

//Класс - это шаблон, чертеж, описание обекта, где описывается что может иметь объект (свойства), какие сможет выполнять действия (методы, функции). Класс играет роль "заготовки".
//Объект - это уже отдельная экземпляр класса, который "изготовлен" по шаблону,чертежу. Объект индивидуален, это сущность в памяти, которая имеет своё индивидуальное состояние атрибутов (свойств и правил поведения).




//  2) Решить задачу разделения сущностей на классы (используя наследование, где нужно) и протоколы в следующих программах:

//В каких случаях лучше использовать наследование, а в каких — расширения (extension)?



//•    в игре есть сундук с инвентарем. Инвентарь — это различные игровые объекты, например: растения, оружие, квестовые предметы — картинка;

//В игре появляется сундук с инвентарем внутри. Инвентарь можно извлекать из сундука и возвращать обратно. Некоторые артефакты, такие как волшебный драгоценный камень может исчезать через некоторое время.

protocol Returnable {
    func returnIn() -> String
}

protocol BeInSide {
    var inSide: Bool { get set }
    
    func beInSide() -> String
}

protocol Extractable {
    func extract() -> String
}

protocol Disappearing {
    func disappear() -> String
}

protocol Shootable {
    func shoot() -> String
}

protocol Blooming {
    func bloom() -> String
}

class Chest {
    let color: String
    
    init(color: String) {
        self.color = color
    }
    
    func checkContentInsideChest(objects: BeInSide...) {
        for object in objects {
            print(object.beInSide())
        }
    }
}

class Plant: Blooming, BeInSide, Extractable, Returnable {
    var inSide: Bool = true
    
    func bloom() -> String {
        return "Is blooming"
    }
    
    func beInSide() -> String {
        if inSide {
        return "Plant in chest"
        }
        else {
            return "Plant not inside chest"
        }
    }
    
    func extract() -> String {
        inSide = false
        return "Plant extract from chest"
    }
    
    func returnIn() -> String {
        inSide = true
        return "Plant extract return in chest"
    }
}


class Weapon: BeInSide, Extractable, Returnable {
    var inSide: Bool = true
    
    func beInSide() -> String {
        if inSide {
        return "Weapon in chest"
        }
        else {
            return "Weapon not inside chest"
        }
    }
    
    func extract() -> String {
        inSide = false
        return "Weapon extract from chest"
    }
    
    func returnIn() -> String {
        inSide = true
        return "Weapon extract return in chest"
    }
}

extension Weapon: Shootable {
    func shoot() -> String {
        return "Weapon is shooting"
    }
}

class Artefact: BeInSide {
    var inSide: Bool = true
    
    func beInSide() -> String {
        if inSide {
        return "Artefact in chest"
        }
        else {
            return "Artefact not inside chest"
        }
    }
}

class Jewel: Artefact, Disappearing {
    func disappear() -> String {
        return "Your magic gem will disappear after 2 hours..."
    }
}
    


let chest = Chest(color: "black")


let flower = Plant()
let pistol = Weapon()
let jewel = Jewel()

flower.bloom()
flower.beInSide()
flower.extract()
flower.beInSide()
pistol.shoot()
jewel.disappear()

chest.checkContentInsideChest(objects: flower, pistol, jewel)



//•    в игре показывается карта с: игроками, монстрами (ими управляет компьютер), интерактивными предметами и неподвижными элементами (например, деревья, стены) — картинка;

protocol Drawable {
    func draw() -> String
}

protocol Moveable {
    func move() -> String
}

protocol Immovable {
    func notMove() -> String
}

protocol BeEvil {
    func evil() -> String
}

protocol ChangeColor {
    func changeColor() -> String
}

protocol ControllableHuman {
    func movePlayer() -> String
}

protocol ControllableComputer {
    func moveMonster() -> String
}

class Map {
    
    func drawObject (objects: Drawable...) {
        for object in objects {
            print(object.draw())
        }
    }
}

class Player {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func born() -> String {
        return "Player was born"
    }
}

extension Player: ControllableHuman, Drawable, Moveable {
    func movePlayer() -> String {
        return "I navigate the virtual world"
    }
    
    func draw() -> String {
        return "Player drowed"
    }
    
    func move() -> String {
        return "Player can move"
    }
}

class Monster {
    func createMonster() -> String {
        return "Monster created"
    }
}

extension Monster: ControllableComputer, Drawable, BeEvil, Moveable, ChangeColor {
    func moveMonster() -> String {
        return "The monster is ready to look for a victim"
    }
    
    func draw() -> String {
        return "Monster drawed"
    }
    
    func evil() -> String {
        return "Monster inspire fear"
    }
    
    func move() -> String {
        return "Monster can move"
    }
    
    func changeColor() -> String {
        return "Monster can be a chameleon"
    }
}

class Tree {
    func qrow() -> String {
        return "Tree is growing"
    }
}


extension Tree: Drawable, Immovable {
    func draw() -> String {
        return "Tree drawed"
    }
    
    func notMove() -> String {
        return "Tree immobile object"
    }
}


class Wall: Immovable, Drawable {
    func build() -> String {
        return "Wall was build"
    }
    func notMove() -> String {
        return "Wall immobile object"
    }
    
    func draw() -> String {
        return "Wall drawed"
    }
    
    
}

let map = Map()

let player = Player(name: "Max")
player.born()
player.draw()
player.movePlayer()

let monster = Monster()
monster.createMonster()
monster.draw()
monster.moveMonster()
monster.evil()

let beautifulTree = Tree()
beautifulTree.qrow()
beautifulTree.draw()
beautifulTree.notMove()

let wall = Wall()
wall.build()
wall.draw()
wall.notMove()

map.drawObject(objects: player, monster, beautifulTree, wall)



//•    у приложения есть 3 модели машин, у каждой из которых есть 3 комплектации. Модели отличаются названием, картинкой. Комплектации — названием, ценой, цветом, объемом двигателя.

class Auto {
    var brand: String
    
    init(brand: String) {
        self.brand = brand
        print(produce())
    }
    
    func produce() -> String {
        return "\nThis auto produce in a \(brand) factory"
    }
}

enum ColorAuto: String {
    case Black, Red, Blue, Yellow, Gray, White, Metallic
}

class ModelAuto: Auto {
    var nameModel: String
    var typeBody: String
    var clearance: Double
    
    init(brand: String, nameModel: String, typeBody: String, clearance: Double) {
        self.nameModel = nameModel
        self.typeBody = typeBody
        self.clearance = clearance
        super.init(brand: brand)
    }
    
    
}

class Equipment {
    let modelAuto: ModelAuto
    var typeEquipment: TypeEquipment
    let transmission: TypeTransmission
    let fuel: TypeFuel
    let volumeEngine: Double
    let salon: TypeSalon
    var manHole: Bool
    var audioSystem: Audio
    
    
    init(modelAuto: ModelAuto, typeEquipment: TypeEquipment, transmission: TypeTransmission, fuel: TypeFuel, volumeEngine: Double, salon: TypeSalon, manHole: Bool, audioSystem: Audio) {
        self.modelAuto = modelAuto
        self.typeEquipment = typeEquipment
        self.transmission = transmission
        self.fuel = fuel
        self.volumeEngine = volumeEngine
        self.salon = salon
        self.manHole = manHole
        self.audioSystem = audioSystem
    }
    
    enum TypeEquipment {
        case basic, simple, econom, comfort, elegant, luxury
    }
    
    enum TypeTransmission: String {
        case MT, AT
    }
    
    enum TypeFuel: String {
        case Gas, Diesel
    }
    
    enum TypeSalon {
        case cloth, ecoleather, realleather
    }
    
    enum Audio {
        case basic, ergonomic, comfortlcd, audionavigationsystem
    }
    
    func aboutAuto() {
        print("\nThis auto \(modelAuto.brand) \(modelAuto.nameModel) has equipment \(typeEquipment). \nEquipment include:  \ntransmission - \(transmission) \ntype fuel - \(fuel) \nvolume engine - \(volumeEngine) \nsalon - \(salon) \naudio - \(audioSystem)")
    }
}


let toyotaCamry = ModelAuto(brand: "Toyota", nameModel: "Camry", typeBody: "Sedan", clearance: 9.0)

let equipmentSimpleToyota = Equipment(modelAuto: toyotaCamry, typeEquipment: Equipment.TypeEquipment.simple, transmission: Equipment.TypeTransmission.MT, fuel: Equipment.TypeFuel.Diesel, volumeEngine: 2.0, salon: Equipment.TypeSalon.cloth, manHole: false, audioSystem: Equipment.Audio.basic)

let equipmentComfortToyota = Equipment(modelAuto: toyotaCamry, typeEquipment: Equipment.TypeEquipment.comfort, transmission: Equipment.TypeTransmission.AT, fuel: Equipment.TypeFuel.Gas, volumeEngine: 2.0, salon: Equipment.TypeSalon.ecoleather, manHole: false, audioSystem: Equipment.Audio.comfortlcd)

let equipmentLuxuryToyota = Equipment(modelAuto: toyotaCamry, typeEquipment: Equipment.TypeEquipment.luxury, transmission: Equipment.TypeTransmission.AT, fuel: Equipment.TypeFuel.Gas, volumeEngine: 3.0, salon: Equipment.TypeSalon.realleather, manHole: true, audioSystem: Equipment.Audio.audionavigationsystem)

equipmentLuxuryToyota.aboutAuto()
equipmentComfortToyota.aboutAuto()
equipmentSimpleToyota.aboutAuto()




//  3) Ответить, не используя xcode: что выведется в консоль в результате выполнения следующего кода (если код некорректен, написать, какая строчка и почему не скомпилируется):

//protocol A{
//    func a()
//}
//
//protocol B{
//    func b()
//}
//
//extension B{
//    func b(){
//        print("B")
//    }
//}
//
//class C: A{
//    func a() {
//        print("A")
//    }
//
//    func c(){
//        print("C")
//    }
//}
//
//class D: C, B{
//    func b() {
//        print("B")
//    }
//
//    func d(){
//        print("D")
//    }
//}


//Тут мы сталкиваемся с полиморфизмом (возможность взаимозаменяемости типов).

//let v1: A = D() - константа v1 типа A (экземляр класса D). Класс D наследует класс С, который реализует класс С. Поэтому можно сделать взаимозаменяемость типов. Константе v1 типа А присваивается инициализация класса D()  Ошибок нет.
//v1.a() - так как константа v1 имеет тип протокола А, то ей доступны все функции этого протокола, а именно функцию .a() Ошибок нет.

//let v2: B = C() - константа v2 типа B (экземляр класса C). Класс С никакие классы не наследует, реализует только протокол А. Поэтому константе v2 нельзя отнести к типу B. Нет возможности сделать такую взаимозаменяемость. Ошибка компиляции.
//v2.c() - константа v2 имеет тип протокола B и ей доступны только только функции протокола B. Ошибка компиляции.

//let v3: C = D() - константа v3 типа С (экземляр класса D). Класс D наследует класс С. Поэтому можно сделать взаимозаменяемость типов. Константе v3 типа С присваивается инициализация класса D()  Ошибок нет.
//v3.d() - константа v3 имеет тип класса С и ей доутпны все фунции класса С, а именно функции .а() и .с(), поэтому функция .d() недоуступна и будет ошибка компиляции.

//let v4: D = D() - тут ошибок нет. В этом случае можно было написать иначе let v4 = D()
//v4.a() - константа v4 имеет тип класса D. Класс D наследует класс С и поэтому контанте v4 доступны все функции классов D и C. Ошибок нет.




//Additional task

protocol MainFuncPhone {
    func outgoingСall(number: Int) -> String
    
    func incomingCall(number: Int) -> String
}

//Abstract class
class Phone: MainFuncPhone {
    private let yearIssue: Int
    private let brand: String
    
    init(yearIssue: Int, brand: String) {
        self.yearIssue = yearIssue
        self.brand = brand
    }
    
    func aboutPhone() -> String {
        return "\nThe phone was produced in \(yearIssue). \nBrand - \(brand)."
    }
    
    func outgoingСall(number: Int) -> String {
        return "outgoingcall to number: \(number)"
    }
    
    func incomingCall(number: Int) -> String {
        return "incomingcall from number: \(number)"
    }
}

//Wired and Wireless phones

class WiredPhone: Phone {
    final let lineVoltage = 60
    private let dialerType: String
    
    init(dialerType: String, yearIssue: Int, brand: String) {
        self.dialerType = dialerType
        super.init(yearIssue: yearIssue, brand: brand)
    }
    
    override func aboutPhone() -> String {
        return super.aboutPhone() + "\nSupply voltage = \(lineVoltage). \nDialer type - \(dialerType)"
    }
    
    func connectToLine() -> String {
        return "A telephone is connected to the wired line. The dialer type is \(dialerType). Supply voltage = \(lineVoltage) V"
    }
}



class WirelessPhone: Phone {
    private let volumeBattery: Int
    
    init(yearIssue: Int, brand: String, volumeBattery: Int) {
        self.volumeBattery = volumeBattery
        super.init(yearIssue: yearIssue, brand: brand)
    }
    
    func checkVolBattery() -> Int {
        return volumeBattery
    }
}

//Smartphone

class Smartphone: WirelessPhone {
    var operationSystem: String

    init(yearIssue: Int, brand: String, volumeBattery: Int, operationSystem: String) {
        self.operationSystem = operationSystem
        super.init(yearIssue: yearIssue, brand: brand, volumeBattery: volumeBattery)
    }
    
    override func aboutPhone() -> String {
        return super.aboutPhone() + "\nVolume battery = \(checkVolBattery()) mAh. \nOperation system - \(operationSystem)"
    }
}


class User {
    func readInfoAboutAnyPhone(phones: Phone...) {
        for phone in phones {
            print(phone.aboutPhone())
        }
    }
    
    func callToEmergency(phones: Phone...) {
        for phone in phones {
            print(phone.outgoingСall(number: 911))
        }
    }
}


//Создаем три телефона-объекта (экземпляра разных типов (классов)).
let firstPhone = Phone(yearIssue: 1896, brand: "AT&T")
let handlePhone = WiredPhone(dialerType: "Handle", yearIssue: 1968, brand: "ATS")
let firsIphone = Smartphone(yearIssue: 2007, brand: "Apple", volumeBattery: 1400, operationSystem: "iOS")

//Наследование - это иерархия сверху вниз, где вверху находятся (абстрактные классы) типы с общими свойствами и методами, которые унаследуются нижестоящими типами (классами). Например, если посмотреть ниже, то класс Smartphone имеет только свойство operationSystem и переопределенный метод aboutPhone. Все остальные свойства и методы достаются этому классу по наследсту от класса родителя Phone и протокола MainFuncPhone. Например в строке 571 мы видим как экземпляру доступен метод родительского класса outgoingCall.

//Инкапсуляция - это обертка, через которую недоступны пользователю свойства или методы внутри класса. Это один из принципов ООП,где свойства и поведение объекта объединяются (обертываются) внутри класса, внутренняя пеализация скрывается от пользовател, а для работы с объектом предоставляется открытый интерфейс. Это реализовывается с помощью модификаторов доступа, таких как private (доступен только внутри класса), public (доступен вне модуля), final (невозможно переопределить или сделать какие либо изменения). В коде это представлено в строках: 499,500, 519 итд.

//Полимор - возможность использовать разные объекты через один и тот же интерфейс (тип), при это каждый объект выполняет свою логику. В нашем случае мы через один метод прогоняем разные экземпляры, используя общий интерфейс. В коде строки:579, 580.

handlePhone.connectToLine()
firstPhone.outgoingСall(number: 89029999999)
firsIphone.outgoingСall(number: 89999999999)
firsIphone.checkVolBattery()

let user = User()
user.readInfoAboutAnyPhone(phones: firstPhone, handlePhone, firsIphone)
user.callToEmergency(phones: handlePhone, firsIphone)









