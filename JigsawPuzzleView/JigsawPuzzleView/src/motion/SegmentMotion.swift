//
// Created by Игорь Трохимчук on 20.06.17.
// Copyright (c) 2017 Игорь Трохимчук. All rights reserved.
//

import Foundation

protocol SegmentMotion {

    func touchesBegan(_ position: CGPoint)
    func touchesMoved(_ position: CGPoint)
    func touchesEnded(_ position: CGPoint)

}
