import Foundation

// swift result type https://www.cocoawithlove.com/blog/2016/08/21/result-types-part-one.html#the-result-type

enum ResultType<T> {
    case success(T)
    case failure(error: Error)
}
