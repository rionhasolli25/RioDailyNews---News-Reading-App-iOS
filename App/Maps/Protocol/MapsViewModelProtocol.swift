//
//  MapsViewModelProtocol.swift
//  RioDailyNews
//
//  Created by Rion on 6.10.25.
//

protocol MapsViewModelProtocol : BaseViewModel{
    var coordinateDelegate : MapsViewProtocolDelegate? {get set}
    func showmap()
}
