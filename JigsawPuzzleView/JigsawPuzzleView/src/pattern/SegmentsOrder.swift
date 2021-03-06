//
// Created by Игорь Трохимчук on 19.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import Foundation

class SegmentsOrder {

    var order: Dictionary<Int, Int> = Dictionary<Int, Int>()
    weak var segments: Segments?

    init(_ segments: Segments!) {
        self.segments = segments
    }

    func setupOrderFromInitialData() {
        if order.count > 0 {
            order.removeAll()
        }
        for i in 0...segments!.sizedSegments.count-1 {
            order[i] = i;
        }
    }

}

extension SegmentsOrder {

    func swapSegments(_ index1: Int, _ index2: Int) {
        if index1 == index2 {return}
        swapSegmentsInArray(index1, index2)
        swapSegmentsOrder(index1, index2)
    }

    fileprivate func swapSegmentsInArray(_ index1: Int, _ index2: Int) {
        let sizedSegments: [Segment] = segments!.sizedSegments
        let segment1 = sizedSegments[index1]
        let segment2 = sizedSegments[index2]
        let position = segment1.centerPosition
        segment1.centerPosition = segment2.centerPosition
        segment2.centerPosition = position
        segments!.sizedSegments[index1] = segment2
        segments!.sizedSegments[index2] = segment1
    }

    fileprivate func swapSegmentsOrder(_ index1: Int, _ index2: Int) {
        let key1: Int = order.allKeysForValue(val: index1).first!
        let key2: Int = order.allKeysForValue(val: index2).first!
        order[key1] = index2
        order[key2] = index1
    }

}

extension SegmentsOrder {

    func blend() {
        for i in 0...order.count-1 {
            let currIndex: Int = order[i]!
            let randomIndex = Int(arc4random_uniform(UInt32(order.count - 1)))
            if currIndex != randomIndex {
                if segments!.sizedSegments != nil {
                    swapSegmentsInArray(currIndex, randomIndex)
                }
                swapSegmentsOrder(currIndex, randomIndex)
            }
        }
    }

}

extension SegmentsOrder {

    func isSegmentsInSequentialOrder() -> Bool {
        for i in 0...order.count-1 {
            if order[i] != i {
                return false
            }
        }
        return true
    }

}

extension Dictionary where Value : Equatable {
    func allKeysForValue(val : Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}
