//
//  PdfViewController.swift
//  Research Companion
//
//  Created by Isioma Anofienam on 27/01/2020.
//  Copyright © 2020 Isioma Anofienam. All rights reserved.
//

import UIKit
import PDFKit

protocol pdfDataGottenFromSendingView {
    
    //might not use this function
    //pass 1 back if data was gotten successfully, pass 0 if otherwise
    func sendBack(gotData: Int)
}

class PdfViewController: UIViewController {

    let pdfView: PDFView = {
        let pdfV = PDFView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        pdfV.translatesAutoresizingMaskIntoConstraints = false
        pdfV.autoScales = true
        pdfV.displayMode = .singlePageContinuous
        pdfV.displayDirection = .vertical
        return pdfV
    }()
    
    var delegate: pdfDataGottenFromSendingView?
    var data: Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Printing from pdfViewController", data)
        view.addSubview(pdfView)
        pdfView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        if let document = PDFDocument(data: data!){
            pdfView.document = document
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent{
            
            delegate?.sendBack(gotData: 1)
        }
    }

}
