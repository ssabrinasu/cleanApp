//
//  SingUpMapper.swift
//  Presentation
//
//  Created by Sabrina on 29/09/21.
//

import Foundation
import Domain

final class SingUpMapper {
    static func toAddAccountModel(viewModel: SingUpViewModel) -> AddAccountModel {
        return AddAccountModel(name: viewModel.name!, email: viewModel.email!, password: viewModel.password!, passwordConfiemation: viewModel.passwordConfirmation!)
    }
}
