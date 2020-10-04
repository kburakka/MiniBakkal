//
//  MiniBakkalTests.swift
//  MiniBakkalTests
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import XCTest
@testable import MiniBakkal
import Alamofire

class MiniBakkalTests: XCTestCase {

    private var service: MockService!

    private var presenterGroseryList: GroseryListPresenter!
    private var interactorGroseryList: GroseryListInteractor!
    private var viewGroseryList: MockGroseryListView!
    private var routerGroseryList: MockGroseryListRouter!
    
    private var presenterBasket: BasketPresenter!
    private var interactorBasket: BasketInteractor!
    private var routerBasket: MockBasketRouter!
    private var viewBasket: MockBasketView!
    
    override func setUp() {
        service = MockService()
        interactorGroseryList = GroseryListInteractor(service: service)
        viewGroseryList = MockGroseryListView()
        routerGroseryList = MockGroseryListRouter()
        presenterGroseryList = GroseryListPresenter(view: viewGroseryList,
                                          interactor: interactorGroseryList,
                                          router: routerGroseryList)
        viewGroseryList.presenter = presenterGroseryList
        
        interactorBasket = BasketInteractor(service: service)
        viewBasket = MockBasketView()
        do{
            let selectedProducts = try ResourceLoader.loadSelectedProducts()
            viewBasket.selectedProducts = selectedProducts ?? []
        }catch{
            print("selectedProducts yuklenemedi")
        }
        routerBasket = MockBasketRouter()
        presenterBasket = BasketPresenter(view: viewBasket, interactor: interactorBasket, router: routerBasket)
        viewBasket.presenter = presenterBasket
    }
    
    func testShowGroseryList() throws {
        // Given:
        let expectedGroseryList = try ResourceLoader.loadGroseryList()

        self.viewGroseryList.didLoad()
        let exp = expectation(description: "Test after 15 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 15.0)
        if result == XCTWaiter.Result.timedOut {
            //  Then:
            if self.viewGroseryList.outputs.count == 3 {
                let output = self.viewGroseryList.outputs[0]
                switch output {
                case .setLoading(true):
                break // Success
                default:
                    XCTFail()
                }
                
                let output1 = self.viewGroseryList.outputs[1]
                switch output1 {
                case .setLoading(false):
                break // Success
                default:
                    XCTFail()
                }
                                
                let output2 = self.viewGroseryList.outputs[2]
                switch output2 {
                case .showProducts(expectedGroseryList):
                break // Success
                default:
                    XCTFail()
                }
            }else{
                XCTFail()
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    func testShowBasket() throws {
        // Given:
        let expectedRes = try ResourceLoader.loadCheckoutRes()

        self.viewBasket.showBasket()
        let exp = expectation(description: "Test after 15 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 15.0)
        if result == XCTWaiter.Result.timedOut {
            //  Then:
            if self.viewBasket.outputs.count == 3 {
                let output = self.viewBasket.outputs[0]
                switch output {
                case .setLoading(true):
                break // Success
                default:
                    XCTFail()
                }
                
                let output1 = self.viewBasket.outputs[1]
                switch output1 {
                case .setLoading(false):
                break // Success
                default:
                    XCTFail()
                }
                                
                let output2 = self.viewBasket.outputs[2]
                switch output2 {
                case .confirmCard(let res):
                    if res.message != expectedRes?.message{
                        XCTFail()
                    }
                break // Success
                default:
                    XCTFail()
                }
            }else{
                XCTFail()
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }
}

//Basket
private final class MockBasketView: BasketViewProtocol {
    var presenter: BasketPresenter!
    var outputs: [BasketPresenterOutput] = []
    public var selectedProducts : [Product] = []
    
    func handleOutput(_ output: BasketPresenterOutput) {
        outputs.append(output)
    }
    
    func showBasket(){
        presenter.confirmCard(products: selectedProducts)
    }
}

private final class MockBasketRouter: BasketRouterProtocol {
    var routes: [EBasketRouter] = []

    func navigate(to route: EBasketRouter) {
        routes.append(route)
    }
}

//GroseryList
private final class MockGroseryListView: GroseryListViewProtocol {
    var presenter: GroseryListPresenter!
    var outputs: [GroseryListPresenterOutput] = []
    
    func didLoad(){
        presenter.showProducts()
    }
    func handleOutput(_ output: GroseryListPresenterOutput) {
        outputs.append(output)
    }
}

private final class MockGroseryListRouter: GroseryListRouterProtocol {
    
    var routes: [EGroseryListRouter] = []
    
    func navigate(to route: EGroseryListRouter) {
        routes.append(route)
    }
}

// Service
final class MockService: APIClientProtocol {
    func fetchGroserylist(completion: @escaping (Result<[Product], AFError>) -> Void) {
        APIClient.performRequest(route: APIRouter.groseryList) { (result) in
            completion(result)
        }
    }
    
    func checkout(chekoutReq: ChekoutReq, completion: @escaping (Result<CheckoutRes, AFError>) -> Void) {
        APIClient.performRequest(route: APIRouter.checkout(checkoutReq: chekoutReq)) { (result) in
            completion(result)
        }
    }
}
