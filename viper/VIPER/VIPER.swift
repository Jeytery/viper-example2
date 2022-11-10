//
//  VIPER.swift
//  viper
//
//  Created by Jeytery on 09.11.2022.
//

import Foundation
import UIKit

typealias EmptyInputData = Int?

protocol EventOutputable {
    associatedtype ReturnEvent
    typealias EventOutput = (ReturnEvent) -> Void
    
    var onEventOutput: EventOutput? { get set }
}

protocol Initable {
    init()
}

protocol ViperView: Initable {
    associatedtype ViewUIEventOutput
    
    var uiEventOutput: ViewUIEventOutput? { get set }
}

protocol ViperPresenter: Initable {
    associatedtype ViewInput
    associatedtype InteractorInput
    associatedtype PublicInterface
    associatedtype ModuleDelegate
    
    var moduleDelegate: ModuleDelegate? { get set }
    
    var viewInput: ViewInput! { get set }
    var interactorInput: InteractorInput! { get set }
    
    var publicInterface: PublicInterface! { get }
}

protocol ViperInteractor: Initable {
   associatedtype InteractorOutput

   var eventOutput: InteractorOutput! { get set }
}

struct ViperModule<
    View: UIViewController & ViperView,
    Presenter: ViperPresenter,
    Interactor: ViperInteractor
> {
    private(set) var view: View
    private var presenter: Presenter
    private let interactor: Interactor
    
    init(view: View, presenter: Presenter, interactor: Interactor) {
        self.view = view
        self.presenter = presenter
        self.interactor = interactor
    }
    
    var publicInterface: Presenter.PublicInterface {
        get {
            presenter.publicInterface
        }
    }
    
    var delegate: Presenter.ModuleDelegate? {
        get {
            presenter.moduleDelegate
        }
            
        set(newValue) {
            presenter.moduleDelegate = newValue
        }
    }
    
    func dismissViewController(animated: Bool = true) {
        view.dismiss(animated: true)
    }
}

class ViperBuilder<
    View:       UIViewController & ViperView,
    Presenter:  ViperPresenter,
    Interactor: ViperInteractor,
    InputData
> {
    class func viewFactory(_ inputData: InputData?) -> View {
        return View()
    }
    
    class func presenterFactory(_ inputData: InputData?) -> Presenter {
        return Presenter()
    }
    
    class func interactorFactory(_ inputData: InputData?) -> Interactor {
        return Interactor()
    }
    
    class func interceptBuild(
        view: View,
        presenter: Presenter,
        interactor: Interactor,
        inputData: InputData?
    ) {}

    static func build(with inputData: InputData? = nil) -> ViperModule<
        View,
        Presenter,
        Interactor
    > {
        var view = viewFactory(inputData)
        var presenter = presenterFactory(inputData)
        var interactor = interactorFactory(inputData)
    
        view.uiEventOutput = presenter as? View.ViewUIEventOutput
        presenter.viewInput = view as? Presenter.ViewInput
        presenter.interactorInput = interactor as? Presenter.InteractorInput
        interactor.eventOutput = presenter as? Interactor.InteractorOutput
    
        interceptBuild(
            view: view,
            presenter: presenter,
            interactor: interactor,
            inputData: inputData)
        
        return ViperModule(
            view: view,
            presenter: presenter,
            interactor: interactor
        )
    }
}
