//: [Previous](@previous)

import Foundation
import UIkit
import Combine
//: [Next](@next)

func getId(_ completionHandler: @escaping (Result<Int,Error>)-> Void){
    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
        let id = 101
        completionHandler(.success(id))
    })
}

func getName(id: Int,_ completionHandler: @escaping  (Result<String,Error>)-> Void){
    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
        let name = "Hidubai"
        completionHandler(.success(name))
    })
}


func getIdWithAsync() async  -> Int {
    await Task.sleep( 2 * 1_000_000_000)  // 2 seconds delay (in nanoseconds)
    let userId = 101  // Simulated user ID
    print(Thread.current.isMainThread)
    return userId
}

func getNameWithAsync(id: Int) async  -> String {
    await Task.sleep( 2 * 1_000_000_000)   // 2 seconds delay (in nanoseconds)
    let name = "Hidubai"
    print(Thread.current.isMainThread)
    return name
}

Task{
    do {
        let userId = await getIdWithAsync()
        let userName = await getNameWithAsync(id: userId)
        print(userName)
    }catch {
        print("Failed with error: \(error)")
    }
}

//getId { userIdResponse in
//    switch userIdResponse {
//    case .success(let userId):
//        getName(id: userId) { userNameResponse in
//            switch userNameResponse {
//            case .success(let userName):
//                print(userName)
//            case .failure(let failure):
//                //Need to handle failure
//                print(failure)
//            }
//
//        }
//    case .failure(let failure):
//        //Need to handle failure
//        print(failure)
//    }
//}

Task{
    do {
        let userId = await getIdWithAsync()
        let userName = await getNameWithAsync(id: userId)
        print(userName)
    }catch {
        print("Failed with error: \(error)")
    }
}

var cancallable:Set(AnyCancellable) = []
[1, 2, 3]
        .publisher
        .sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print("Something went wrong: \(error)")
            case .finished:
                print("Received Completion")
            }
        }, receiveValue: { value in
            print("Received value \(value)")
        }).store(in: &cancallable)

extension Notification.Name {
    static let newEvent = Notification.Name("new_event")
}
struct Event {
    let title: String
    let scheduledOn: Date
}

let eventPublisher = NotificationCenter.Publisher(center: .default, name: .newEvent, object: nil)
    .map { (notification) -> String? in
        return (notification.object as? Event)?.title ?? ""
    }

let theEventTitleLabel = UILabel()

let newEventLabelSubscriber = Subscribers.Assign(object: theEventTitleLabel, keyPath: \.text)
eventPublisher.subscribe(newEventLabelSubscriber)

let event = Event(title: "Introduction to Combine Framework", scheduledOn: Date())
NotificationCenter.default.post(name: .newEvent, object: event)
print("Recent event notified is: \(theEventTitleLabel.text!)")
let event1 = Event(title: " Combine Framework", scheduledOn: Date())
NotificationCenter.default.post(name: .newEvent, object: event1)
print("Recent event notified is: \(theEventTitleLabel.text!)")


let subscription = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()
    .sink { output in
        print("finished stream with : \(output)")
    } receiveValue: { value in
        print("receive value: \(value)")
    }

RunLoop.main.schedule(after: .init(Date(timeIntervalSinceNow: 5))) {
    print(" - cancel subscription")
    subscription.cancel()
}

