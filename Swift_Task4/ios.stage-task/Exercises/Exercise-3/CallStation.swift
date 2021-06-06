import Foundation

final class CallStation {
    var usersArray = [User]()
    var callsArray = [Call]()
}

extension CallStation: Station {

    func users() -> [User] {
        return usersArray
    }
    
    func add(user: User) {
        if (!usersArray.contains(user)) {
            usersArray.append(user)
        }
    }
    
    func remove(user: User) {
       usersArray = usersArray.filter { $0 != user }
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        case .start(from: let from, to: let to):
            if !usersArray.contains(from) && !usersArray.contains(to) { return nil }
            else if !usersArray.contains(to) {
                let call = Call(id: CallID.init(), incomingUser: from, outgoingUser: to, status: .ended(reason: .error))
                callsArray.append(call)
                return call.id
            }
            else if let _ = callsArray.firstIndex(where: {($0.incomingUser == to ||
                                                           $0.outgoingUser == to) &&
                                                          ($0.status == .calling ||
                                                           $0.status == .talk)}) {
                let call = Call(id: CallID.init(), incomingUser: from, outgoingUser: to, status: .ended(reason: .userBusy))
                callsArray.append(call)
                return call.id
            } else {
                let call = Call(id: CallID.init(), incomingUser: from, outgoingUser: to, status: .calling)
                callsArray.append(call)
                return call.id
            }
            
        case .answer(from: let from):
            if !usersArray.contains(from) {
                guard let index = callsArray.firstIndex(where: {$0.outgoingUser == from}) else {return nil}
                callsArray[index].status = .ended(reason: .error)
                return nil
            } else {
                guard let index = callsArray.firstIndex(where: {$0.outgoingUser == from}) else {return nil}
                callsArray[index].status = .talk
                return callsArray[index].id
            }
            
            
        case .end(from: let from):
            guard let index = callsArray.firstIndex(where: {$0.incomingUser == from || $0.outgoingUser == from}) else {return nil}
            if (callsArray[index].status == .talk) {
                callsArray[index].status = .ended(reason: .end)
            } else if (callsArray[index].status == .calling) {
                callsArray[index].status = .ended(reason: .cancel)
            }
            
            return callsArray[index].id
        }
    }
    
    func calls() -> [Call] {
        callsArray
    }
    
    func calls(user: User) -> [Call] {
        return callsArray.filter { $0.incomingUser == user || $0.outgoingUser == user }
    }
    
    func call(id: CallID) -> Call? {
        return callsArray.filter { $0.id == id }.first
    }
    
    func currentCall(user: User) -> Call? {
        callsArray.filter {($0.incomingUser == user || $0.outgoingUser == user) &&
        ($0.status == .calling || $0.status == .talk)}.first
    }
}
