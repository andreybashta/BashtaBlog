//
//  PostMarksCell.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 2/1/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import UIKit

class PostMarksCell: UITableViewCell {

    @IBOutlet weak var marksLabel: UILabel!
    
    func ConfigureCell(mark: MarkData) {
        marksLabel.text = mark.name
    }
    
}
